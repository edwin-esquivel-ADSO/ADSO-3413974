# Auditoría E2E Ficha 3145555 — Listado de Errores y Banco de Temas para Sustentación

**Fecha de evaluación:** 23-24 de octubre de 2026  
**Fuente:** [Evaluación e2e 3145555](https://code-sena.github.io/ADSO-3145555/informes/2026-10-23-evaluacion-e2e-3145555/index.html)  
**Objetivo:** Distribución individual de temas para Discord y preparación para la ronda de preguntas y feedback técnico con los instructores.

---

## 1. Tabla de 25 Errores Bloqueantes y Críticos (Para asignación en Discord)

> **Regla de asignación:** Cada aprendiz escoge un número único, lo publica en el canal de Discord (*ej: "Jesús - Tema #17"* o *"Edwin - Tema #10"*) y prepara su explicación técnica y solución.

| # | Severidad | Equipo / Proyecto | Repositorio afectado | Hallazgo Técnico (Problema) | Solución Definitiva (Cómo cerrarlo) |
|---|---|---|---|---|---|
| **1** | **Bloqueante** | **Eq 2** · SmartHome | `from_movil` | El alta de dispositivos no está integrada en el móvil: sin dispositivos no hay control ni consumo. | Conectar la app móvil a las sesiones de configuración del backend (`crear`, `identificar`, `completar`) y definir identidad MQTT por dispositivo. |
| **2** | **Bloqueante** | **Eq 2** · SmartHome | `smart-home-database` | La BD declarada está congelada y no es la que el backend necesita; ningún flujo principal completa contra ella. | Unificar una sola fuente de verdad de BD, sincronizar los 64 changesets de Liquibase y agregar validación en CI con `prisma validate`. |
| **3** | **Bloqueante** | **Eq 5** · Lava Rápido | `backend` | Contraseña de BD, clave de firma JWT y clave de aplicación Gmail en texto claro en `main`, `qa` y en el historial git. | 1) Rotar ya todas las claves (invalida sesiones JWT activas). 2) Reescribir historial con `git filter-repo`. 3) Activar GitHub secret scanning y gitleaks en CI. |
| **4** | **Bloqueante** | **Eq 6** · One Language | `OneLanguage-Database` | Contraseña de PostgreSQL en claro en `dev`, `main`, `qa` y en todo el historial del repo público. | Rotar la contraseña en todos los ambientes, reemplazar por placeholders (`${DB_PASSWORD}`), purgar historial y habilitar push protection. |
| **5** | **Bloqueante** | **Eq 7** · Hidro Smart | `PT_HS` | Archivos `.env` con credenciales reales (PostgreSQL, JWT, SMTP) subidos al repositorio público. | Rotar credenciales de inmediato, eliminar ramas comprometidas o purgar con `git filter-repo`, y usar únicamente `.env.example`. |
| **6** | **Bloqueante** | **Eq 9** · SaborExpress | `SaborExpressBack` | Clave JWT, contraseña SMTP y claves de PostgreSQL y usuario gerente quedaron en el historial de `main`. | Rotar los 4 secretos, reescribir historial en todas las ramas con `git filter-repo`, documentar variables y agregar `gitleaks` al pipeline. |
| **7** | **Bloqueante** | **Eq 11** · Alerta Mujer | `AlertaMujer_Frontend` | Credencial de administrador en texto claro dentro de los tests de Playwright y en el historial. | Extraer credenciales a variables de entorno protegidas en el runner de CI, sembrar usuarios sintéticos de test y rotar la cuenta comprometida. |
| **8** | **Bloqueante** | **Eq 12** · EcoRuteando | `Movil-EcoRuteando` | Clave de Google Maps (API Key) escrita directamente en el código de la app móvil y en `main`. | Revocar y regenerar la API Key, restringirla por huella SHA-1 y paquete Android (`com.ecoruteando.mobile`), y moverla a variables de build (`gradle.properties`). |
| **9** | **Crítico** | **Eq 1** · Driviqe | `Back-end` | El backend confirma reservas y genera pagos como "APROBADO" sin consultar a la pasarela (Wompi). | Eliminar la aprobación artificial en `confirmReservationPayment`; confirmar únicamente mediante el Webhook criptográficamente validado de Wompi. |
| **10** | **Crítico** | **Eq 1** · Driviqe | `Back-end` | La clave de firma JWT tiene un valor por defecto en el código y nadie la sobrescribe. | Eliminar fallback en `JwtService`; abortar el arranque si falta `JWT_SECRET` (mínimo 256 bits aleatorios). Separar claves de acceso y tokens de entrega. |
| **11** | **Crítico** | **Eq 1** · Driviqe | `database` | Scripts DML crean superadmin y seis encargados con contraseñas fijas y conocidas en todos los ambientes. | Excluir semillas DML de producción mediante contextos de Liquibase (`context="dev"`), inyectar admin inicial por variables de entorno y rotar credenciales. |
| **12** | **Crítico** | **Eq 2** · SmartHome | `smart-home-docs` | Repo público de documentación contiene archivos Word con credenciales reales, correos y contraseñas. | Purgar archivos e historial con `git filter-repo`, rotar todas las credenciales expuestas y publicar únicamente manuales con datos simulados. |
| **13** | **Crítico** | **Eq 2** · SmartHome | `smarthome-frontend-web` | La rama `dev` es un cascarón vacío; la integración real está atrapada en ramas `09-dev`/`12-dev` sin fusionar. | Crear Pull Request para fusionar `12-dev` en `dev`, verificar compilación y pruebas en CI y habilitar despliegue continuo. |
| **14** | **Crítico** | **Eq 2** · SmartHome | General (Arquitectura) | Los 5 repositorios declarados no forman un sistema reproducible que arranque en conjunto. | Crear un `docker-compose.yml` maestro que orqueste backend, frontend, postgres, liquibase y broker MQTT con documentación de inicio paso a paso. |
| **15** | **Crítico** | **Eq 2** · SmartHome | `smart-home-database` | Usuario administrador se crea en migraciones con contraseña débil y conocida en claro en el SQL. | Eliminar contraseñas fijas del SQL; generar hash fuera del repo o exigir parámetro de Liquibase y obligar a cambio de clave en el primer inicio. |
| **16** | **Crítico** | **Eq 3** · Guardián Escolar | `Backend-Guardian-Escolar` | Clave de firma JWT tiene valor por defecto público y se rellena con 'x' si es corta o vacía. | Eliminar valor por defecto en `application.yml`, validar en el constructor de `JwtService` mínimo 32 bytes sin relleno y detener inicio si no existe. |
| **17** | **Crítico** | **Eq 4** · FaceLit | `FaceLit-Backend` | Endpoints de asistencia facial no validan rol ni pertenencia: cualquier usuario autenticado altera asistencias. | Restringir `/api/facial/events/**` por roles con `@PreAuthorize("hasRole('INSTRUCTOR')")` y verificar que el instructor pertenezca a la ficha evaluada. |
| **18** | **Crítico** | **Eq 4** · FaceLit | `FaceLit-Backend` | Código de recuperación de contraseña de 6 dígitos sin limitación de tasa (rate-limit) ni asociación al correo. | Atar código al correo del solicitante, bloquear tras 3-5 intentos fallidos, aplicar rate limiting por IP y emitir token temporal de un solo uso. |
| **19** | **Crítico** | **Eq 5** · Lava Rápido | `backend` | El esquema de BD no está en ningún repositorio entregado (backend depende de BD no versionada). | Versionar esquema completo con Liquibase o Flyway en repositorio `database/` con semillas y scripts reproducibles. |
| **20** | **Crítico** | **Eq 6** · One Language | `OneLanguage-AI` | El modelo de IA de traducción de señas no está publicado ni versionado (imposible reproducir en local). | Publicar paquete del modelo en GitHub Releases o bucket S3 con hash de integridad SHA-256 e instrucciones de instalación. |
| **21** | **Crítico** | **Eq 6** · One Language | `OneLanguage-Backend` | Clave JWT de prueba y contraseña de BD por defecto en historial público sin evidencia de rotación. | Generar secreto seguro de 256 bits cargado vía `JWT_SECRET`, validar longitud al arrancar y rotar credenciales en la base de datos. |
| **22** | **Crítico** | **Eq 11** · Alerta Mujer | `AlertaMujer_Frontend` | El registro móvil exige un simulador de SMS (usuarios reales en entornos normales no pueden registrarse). | Integrar proveedor real de SMS (ej. Twilio) o restaurar verificación por correo electrónico; no retornar códigos de verificación en la respuesta HTTP. |
| **23** | **Crítico** | **Eq 12** · EcoRuteando | `EcoRuteando` (Web) | El secreto del 2FA (TOTP) se envía en la URL a un servicio externo (`api.qrserver.com`) para dibujar el QR. | Generar el código QR localmente en el cliente con librerías JavaScript (`qrcode` o `qrcode.react`), eliminando la fuga de secretos a terceros. |
| **24** | **Crítico** | **Eq 12** · EcoRuteando | `EcoRuteandoBackend` | Cualquier usuario registrado puede modificar configuraciones globales, factores de CO2 y exportaciones. | Agregar atributos `[Authorize(Roles="Admin,SuperAdmin")]` en endpoints de `/api/admin`, validar autorización a nivel de servicio y responder `403 Forbidden`. |
| **25** | **Crítico** | **Eq 12** · EcoRuteando | `EcoRuteandoBackend` | El token temporal de 2FA y el token de dispositivo de confianza funcionan como tokens de acceso total. | Emitir tokens intermedios con diferente `scope` o `claim` (`token_type: "2fa_pending"`), y rechazarlos en el middleware de autenticación principal. |

---

## 2. Errores Transversales Comunes (Por si los instructores preguntan a nivel general)

Estos son los criterios globales donde falló la mayoría de la ficha:

1. **R-6.4 Pruebas en CI (12 / 12 equipos fallaron):**
   * *Diagnóstico:* Ningún equipo configuró la ejecución automática de pruebas (`npm test`, `pytest`, `mvn test`) en GitHub Actions ante cada Pull Request o push.
   * *Solución:* Crear el archivo `.github/workflows/ci.yml` configurando el runner con el paso `run tests`.

2. **R-4.7 Calidad y Tamaño de Clases (9 / 12 equipos fallaron):**
   * *Diagnóstico:* Clases con miles de líneas acumulando lógica de negocio, acceso a datos y controladores (violación del Principio de Responsabilidad Única - SRP).
   * *Solución:* Refactorización a arquitectura por capas (Controlador -> Servicio -> Repositorio) o hexagonal.

3. **T-13.9 Sincronización de Ramas (8 / 12 equipos fallaron):**
   * *Diagnóstico:* La rama `main` está vacía o desactualizada; los avances reales quedaron atrapados en `develop` o ramas personales.
   * *Solución:* Aplicar GitFlow ordenado, consolidar Pull Requests hacia `main` y etiquetar versiones estables (tags semánticos).

4. **D5 Seguridad y Gestión de Secretos (Más del 60% de los proyectos):**
   * *Diagnóstico:* Claves de bases de datos, tokens JWT y contraseñas de correos quemadas en el código o subidas en archivos `.env`.
   * *Solución:* Cumplir el principio de *12-Factor App*, inyectar secretos mediante variables de entorno en tiempo de ejecución y usar `.env.example` en repositorios.

---

## 3. Guía Rápida para Sustentar al Frente (Estructura de 2 Minutos)

Cuando te toque pasar al frente frente al instructor (o ante el instructor John Corredor), responde usando esta estructura técnica:

1. **Identificación:** *"El error evaluado corresponde al Hallazgo #[X] del [Equipo Y], clasificado como [Bloqueante / Crítico]."*
2. **Impacto:** *"El riesgo principal es que permite [ej: suplantación de identidad / bypass de pagos / exposición de credenciales / caída del sistema en despliegue]."*
3. **Causa Raíz:** *"Ocurre porque el código [ej: hardcodea secretos por defecto / carece de validación de roles en el middleware / expone credenciales en el historial de git]."*
4. **Solución Implementada:** *"La solución técnica requiere: 1) Rotar o revocar las credenciales comprometidas, 2) Limpiar el historial con `git filter-repo`, y 3) Ajustar la capa de seguridad con [decoradores de autorización / validación de firmas criptográficas / variables de entorno obligatorias en el arranque]."*
