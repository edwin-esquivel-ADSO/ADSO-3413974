# INFORME TÉCNICO N° 2: PLAN DE MEJORA, OPTIMIZACIÓN Y MADUREZ DEL SISTEMA
**Proyecto:** Sistema de Control y Gestión de Asistencia SENA (ADSO)  
**Fecha de Publicación:** 19 de Noviembre de 2026  
**Área:** Aseguramiento de Calidad (QA), Arquitectura de Software y Ciberseguridad  
**Objetivo:** Establecer la hoja de ruta técnica para llevar el proyecto a nivel de producción institucional a gran escala.  

---

## 1. Diagnóstico de Madurez del Software

El análisis estático y la ejecución de la suite E2E confirman que la aplicación posee un **diseño arquitectónico de alto nivel**:
- Separación clara en capas: Presentación (`src/app`), Controladores (`route.ts`), Dominio (`domain/`), Servicios de Negocio (`services/`) y Repositorios (`repositories/`).
- Validaciones estrictas en tiempo de ejecución con schemas de `zod`.
- Algoritmos avanzados de seguridad (HMAC-SHA256 rotativo, cálculo de distancia Haversine, bloqueo optimista OCC y verificación biométrica vectorial).

No obstante, al someter el proyecto al rigor de pruebas automatizadas y proyectar su despliegue en centros de formación del SENA (que atienden a más de 30.000 aprendices por regional), se identifican áreas de mejora indispensables agrupadas en **6 pilares fundamentales**.

---

## 2. Pilares de Mejora y Recomendaciones Técnicas

### 2.1. Seguridad y Remediación de Vulnerabilidades

#### Hallazgo:
La auditoría de dependencias (`npm audit`) detectó **6 vulnerabilidades en el árbol de paquetes (5 de severidad alta, 1 crítica)** asociadas a librerías transitivas de parsing HTTP y manipulación de archivos (`busboy` / subdependencias de carga multipart).

#### Recomendaciones:
1. **Remediación Inmediata de Dependencias:**
   ```bash
   npm audit fix
   ```
2. **Fortalecimiento del Mecanismo de Autenticación de Instructores:**
   - *Situación Actual:* El inicio de sesión para instructores y coordinadores requiere únicamente el número de documento y el nombre completo (sin credenciales secretas).
   - *Riesgo:* Cualquier usuario que conozca el documento y nombre de un instructor puede suplantar su identidad y acceder a crear/cerrar sesiones.
   - *Mejora Propuesta:* 
     - Implementar inicio de sesión mediante **contraseña segura cifrada con `bcryptjs`** (el campo `password_hash` ya existe en la tabla `users` pero no se exige actualmente).
     - Habilitar autenticación multifactor (**MFA**) con códigos TOTP o vinculación al directorio activo institucional del SENA (**Microsoft Entra ID / Office 365** mediante NextAuth o OAuth 2.0).

---

### 2.2. Resiliencia de Infraestructura y Entornos Híbridos (Local vs Nube)

#### Hallazgo:
Durante la puesta en marcha local, el conector `src/lib/db.ts` forzaba `ssl: { rejectUnauthorized: false }`. En PostgreSQL local (sin TLS), esto provocaba el error fatal `The server does not support SSL connections`. Aunque fue corregido durante esta sesión, debe formalizarse en la arquitectura del conector.

#### Mejoras Propuestas:
1. **Configuración de Conexión Universal:**
   ```typescript
   // src/lib/db.ts
   const connectionString = process.env.DATABASE_URL || '';
   const isLocal = connectionString.includes('localhost') || 
                   connectionString.includes('127.0.0.1') || 
                   process.env.DB_SSL === 'false';

   pool = new Pool({
     connectionString,
     ssl: isLocal ? false : { rejectUnauthorized: false },
     max: parseInt(process.env.DB_POOL_MAX || '20', 10),
     idleTimeoutMillis: 30000,
     connectionTimeoutMillis: 5000,
   });
   ```
2. **Manejo de Ráfagas con Connection Pooler (PgBouncer):**
   - En una jornada típica de clase, 30 a 45 aprendices de un grupo escanean el código QR casi al mismo segundo (efecto "avalancha").
   - Es mandatorio activar el endpoint con **pooling de Neon** (`-pooler` en la URL de conexión) para reutilizar sockets y evitar agotar el límite de conexiones concurrentes de PostgreSQL.

---

### 2.3. Resiliencia y Disponibilidad de la Biometría Facial

#### Hallazgo:
El módulo de registro biométrico (`src/app/aprendiz/register/page.tsx`) descarga los modelos de redes neuronales de `@vladmandic/face-api` directamente desde una red de distribución externa:
```typescript
const MODEL_URL = 'https://cdn.jsdelivr.net/npm/@vladmandic/face-api@1.7.15/model';
```
Si el centro de formación tiene bloqueos de proxy, firewall estricto o cortes temporales de salida a internet internacional, la verificación biométrica queda totalmente inoperativa.

#### Mejoras Propuestas:
1. **Empaquetamiento Local de Pesos de Modelos (Zero-External Dependency):**
   - Descargar los archivos binarios de pesos (`tiny_face_detector_model-weights_manifest.json`, `face_landmark_68_model-weights_manifest.json`, `face_recognition_model-weights_manifest.json`) y almacenarlos en `/public/models/face/`.
   - Modificar la URL de carga para apuntar a `/models/face`, permitiendo que el sistema funcione 100% en intranet local.
2. **Implementación de Detección Activa de Vida (*Liveness Detection*):**
   - Actualmente se valida la distancia euclidiana del descriptor 128D, lo que previene vectores disimilares pero no garantiza que la imagen no provenga de una fotografía estática mostrada a la cámara.
   - Agregar desafío pasivo de parpadeo (*Eye Aspect Ratio - EAR*) o solicitud de giro leve de cabeza ($\pm 15^\circ$) antes de capturar el embedding final.

---

### 2.4. Geocercas GPS Híbridas para Aulas e Interiores

#### Hallazgo:
El registro de asistencia exige de forma obligatoria coordenadas GPS y restringe la presencia a un radio de 100 metros del ambiente. En muchos centros de formación del SENA, los ambientes de software (ADSO) están situados en sótanos, laboratorios de redes blindados o estructuras metálicas donde la señal de satélites GPS es nula o reporta precisiones pobres ($\pm 250$ metros).

#### Mejoras Propuestas:
1. **Mecanismo de Geocerca Híbrida / Multicapa:**
   - **Capa 1 (Primaria):** GPS si la precisión es $\le 120$ metros.
   - **Capa 2 (Fallback Intranet SENA):** Si el dispositivo reporta `Ubicación no disponible` o precisión deficiente, el servidor evalúa si la IP pública del aprendiz coincide con el rango CIDR institucional de la sede del centro de formación (e.g., `186.84.x.x` asignado por MinTIC/SENA).
   - **Capa 3 (Validación de Subred / Gateway):** Detección del prefijo de red o SSID corporativo "SENA_APRENDICES".

---

### 2.5. Experiencia de Usuario (UX/UI) y Accesibilidad

#### Hallazgo:
En varios módulos del panel de instructor y coordinador se utilizan cuadros de diálogo nativos del navegador (`window.alert()`, `window.prompt()`, `window.confirm()`).
- Los navegadores modernos en dispositivos móviles bloquean o silencian estas alertas.
- En pruebas automatizadas E2E pueden generar bloqueos de hilos (*thread lock*) si no son interceptados.
- El ingreso de motivos de rechazo mediante `window.prompt()` degrada la experiencia de usuario.

#### Mejoras Propuestas:
1. **Reemplazo por Componentes React de UI Accesibles:**
   - Integrar un sistema de notificaciones no intrusivas (*Toast*) como `sonner` o `react-hot-toast`.
   - Construir modales de confirmación con accesibilidad semántica (WAI-ARIA) para las acciones críticas (Aprobar/Rechazar Excusa, Finalizar Sesión).
2. **Paginación del Lado del Servidor (*Server-Side Pagination*):**
   - En `/api/coordinador/history` y `/api/instructor/history`, actualmente se consulta la totalidad de filas sin paginación `LIMIT / OFFSET`. Conforme pasen los meses y se acumulen más de 50.000 asistencias, el payload JSON pesará decenas de megabytes.
   - Implementar paginación cursor-based o paginación por páginas (`page=1&limit=50`).

---

### 2.6. Ciclo de Vida de Calidad Continua (CI/CD Pipeline)

Para garantizar que el software preserve su calidad en cada nuevo commit o pull request, se propone la integración de un workflow automatizado en GitHub Actions.

#### Pipeline Propuesto (`.github/workflows/e2e-quality.yml`):
```yaml
name: E2E Quality & Regression Suite

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_DB: asistencia_sena
          POSTGRES_USER: sena_user
          POSTGRES_PASSWORD: sena_password
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - name: Checkout Código Fuente
        uses: actions/checkout@v4

      - name: Configurar Node.js 20
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'

      - name: Instalar Dependencias
        run: npm ci

      - name: Instalar Navegadores Playwright
        run: npx playwright install --with-deps chromium

      - name: Migraciones y Semillas de Base de Datos
        env:
          DATABASE_URL: postgresql://sena_user:sena_password@localhost:5432/asistencia_sena
          DB_SSL: 'false'
        run: |
          npm run db:migrate
          node database/seeds/seed-ficha-3413974.js

      - name: Ejecutar Pruebas E2E Profundas de Dominio
        env:
          DATABASE_URL: postgresql://sena_user:sena_password@localhost:5432/asistencia_sena
          DB_SSL: 'false'
          JWT_SECRET: ci_cd_super_secret_test_key_2026
        run: npm run test:deep

      - name: Compilar y Arrancar Servidor Web
        env:
          DATABASE_URL: postgresql://sena_user:sena_password@localhost:5432/asistencia_sena
          DB_SSL: 'false'
          JWT_SECRET: ci_cd_super_secret_test_key_2026
        run: |
          npm run build
          npm run start &
          npx wait-on http://localhost:3000

      - name: Ejecutar Pruebas E2E de Navegador con Playwright
        run: npm run test:e2e

      - name: Publicar Reporte HTML de Playwright
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-e2e-report
          path: playwright-report/
```

---

## 3. Matriz de Priorización de Mejoras (Roadmap de Evolución)

| Prioridad | Iniciativa / Tarea | Impacto | Esfuerzo | Justificación Institucional |
| :---: | :--- | :---: | :---: | :--- |
| 🔴 **P1** | Modelos de Face-API alojados localmente (`/public/models`) | **Crítico** | Bajo (1 día) | Garantiza funcionamiento de biometría en sedes sin internet o con proxy restrictivo. |
| 🔴 **P1** | Autenticación robusta con contraseña o SSO SENA (Entra ID) | **Crítico** | Medio (3 días) | Evita suplantaciones de instructores y coordinadores en el inicio de sesión. |
| 🟡 **P2** | Sustitución de `window.alert/prompt` por Modales y Toasts accesibles | **Alto** | Bajo (2 días) | Corrige incompatibilidades en navegadores móviles de aprendices. |
| 🟡 **P2** | Geocerca GPS con fallback de IP pública institucional | **Alto** | Medio (3 días) | Evita bloqueos a aprendices ubicados en aulas subterráneas o con baja señal satelital. |
| 🟢 **P3** | Paginación en servidor (`LIMIT / OFFSET`) para historial | **Medio** | Medio (2 días) | Evita degradación de memoria cuando la base supere 50.000 registros. |
| 🟢 **P3** | Integración de pipeline CI/CD en GitHub Actions | **Medio** | Bajo (1 día) | Asegura que ningún pull request futuro rompa las 49 pruebas E2E existentes. |

---

## 4. Conclusión

El proyecto posee bases arquitectónicas excepcionales que resuelven con maestría los desafíos de integridad de asistencia académica. La adopción de este **Plan de Mejora y Madurez** cerrará las brechas de despliegue operacional en sedes físicas del SENA, blindará la plataforma contra vectores de suplantación y garantizará un escalamiento concurrente sin fricciones para miles de aprendices e instructores a nivel nacional.
