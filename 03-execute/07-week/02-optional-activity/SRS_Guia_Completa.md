# 📋 SRS — Software Requirements Specification
### Guía Completa: Conceptos, Estructura y Aplicación a Proyectos de Software

---

## 1. ¿Qué es un SRS?

Un **SRS (Software Requirements Specification)** es un documento formal que describe de manera exhaustiva el comportamiento esperado de un sistema de software. Define **qué debe hacer** el sistema (no cómo hacerlo), sirviendo como contrato entre el cliente, el equipo de desarrollo y los stakeholders.

> 📌 Estándar de referencia: **IEEE 830** (reemplazado por **ISO/IEC/IEEE 29148:2018**)

---

## 2. ¿Por qué es crítico un SRS?

| Problema sin SRS | Solución con SRS |
|---|---|
| Requisitos ambiguos o cambiantes | Requisitos claros, medibles y verificables |
| Desacuerdo entre cliente y dev | Base contractual compartida |
| Retrabajo costoso | Defectos detectados en etapa temprana |
| Estimaciones incorrectas | Alcance definido para planificación |
| Código sin criterios de aceptación | Pruebas alineadas con requisitos |

**Dato clave:** Corregir un error en producción puede costar hasta **100 veces más** que detectarlo en la fase de requisitos.

---

## 3. Conceptos Fundamentales

### 3.1 Tipos de Requisitos

#### 🔵 Requisitos Funcionales (RF)
Describen **qué hace** el sistema: funcionalidades, comportamientos, reglas de negocio.

```
RF-001: El sistema debe permitir al usuario registrarse con correo y contraseña.
RF-002: El sistema debe enviar un correo de confirmación al registrarse.
RF-003: El sistema debe bloquear la cuenta tras 5 intentos fallidos de login.
```

#### 🟠 Requisitos No Funcionales (RNF)
Describen **cómo lo hace** el sistema: calidad, rendimiento, restricciones.

```
RNF-001 (Rendimiento):   El sistema debe responder en < 2 segundos bajo 1000 usuarios concurrentes.
RNF-002 (Disponibilidad): El sistema debe tener uptime del 99.9% mensual.
RNF-003 (Seguridad):     Las contraseñas deben almacenarse con hash bcrypt (costo ≥ 12).
RNF-004 (Usabilidad):    Un usuario nuevo debe completar el registro en < 3 minutos.
RNF-005 (Portabilidad):  El sistema debe funcionar en Chrome, Firefox y Safari (últimas 2 versiones).
```

#### 🟢 Requisitos de Interfaz
- **Interfaz de Usuario (UI):** Diseño, navegación, accesibilidad (WCAG 2.1 AA).
- **Interfaz de Hardware:** Sensores, dispositivos, periféricos.
- **Interfaz de Software:** APIs externas, servicios de terceros, integraciones.
- **Interfaz de Comunicación:** Protocolos (REST, SOAP, gRPC), formatos (JSON, XML).

#### 🟣 Restricciones del Sistema
Limitaciones tecnológicas, legales o de negocio no negociables.

```
R-001: El sistema debe cumplir con la Ley 1581 de Protección de Datos (Colombia).
R-002: El backend debe desarrollarse en Node.js 18+ o Java 17+.
R-003: La base de datos debe ser PostgreSQL 14+.
```

---

### 3.2 Atributos de Calidad de los Requisitos (SMART)

Un requisito bien escrito debe ser:

| Atributo | Descripción | Ejemplo ❌ | Ejemplo ✅ |
|---|---|---|---|
| **S**pecific | Preciso y sin ambigüedad | "El sistema debe ser rápido" | "La API debe responder en < 500ms" |
| **M**easurable | Verificable con criterios objetivos | "Buena usabilidad" | "Score SUS ≥ 75" |
| **A**chievable | Técnicamente factible | "Tiempo real absoluto" | "Latencia ≤ 100ms en LAN" |
| **R**elevant | Alineado con objetivos de negocio | Requisito duplicado | Requisito trazable a objetivo |
| **T**raceable | Identificable y rastreable | Sin ID | RF-042 con origen en HU-012 |

---

### 3.3 Trazabilidad de Requisitos

La trazabilidad vincula cada requisito con su origen y su implementación.

```
Necesidad de Negocio → Historia de Usuario → Requisito → Componente → Caso de Prueba
```

**Matriz de Trazabilidad (ejemplo):**

| Req ID | Descripción | Historia de Usuario | Módulo | Caso de Prueba |
|---|---|---|---|---|
| RF-001 | Registro de usuario | HU-001 | AuthModule | TC-001, TC-002 |
| RF-002 | Confirmación por email | HU-001 | NotificationService | TC-003 |
| RNF-001 | Respuesta < 2s | NFR-PER-01 | API Gateway | TC-PERF-001 |

---

## 4. Estructura Estándar del Documento SRS (IEEE 830 / ISO 29148)

```
SRS
├── 1. Introducción
│   ├── 1.1 Propósito
│   ├── 1.2 Alcance
│   ├── 1.3 Definiciones, Acrónimos y Abreviaturas
│   ├── 1.4 Referencias
│   └── 1.5 Visión General del Documento
│
├── 2. Descripción General
│   ├── 2.1 Perspectiva del Producto
│   ├── 2.2 Funciones del Producto
│   ├── 2.3 Características de los Usuarios
│   ├── 2.4 Restricciones
│   ├── 2.5 Suposiciones y Dependencias
│   └── 2.6 Distribución de Requisitos
│
├── 3. Requisitos Específicos
│   ├── 3.1 Requisitos Funcionales
│   ├── 3.2 Requisitos No Funcionales
│   ├── 3.3 Requisitos de Interfaz
│   └── 3.4 Restricciones de Diseño
│
├── 4. Apéndices
│   ├── A. Diagramas (casos de uso, flujos)
│   ├── B. Prototipos / Mockups
│   └── C. Glosario extendido
```

---

## 5. Cómo Aplicar el SRS a un Proyecto de Software Real

### 5.1 Fase 1: Elicitación de Requisitos

Técnicas para recopilar requisitos de los stakeholders:

- **Entrevistas:** Conversaciones estructuradas con usuarios finales y product owners.
- **Workshops (JAD):** Sesiones grupales con todos los stakeholders clave.
- **Observación:** Estudiar cómo los usuarios realizan sus tareas actuales.
- **Análisis de documentos:** Revisar sistemas existentes, manuales, procesos.
- **Prototipos:** Mockups y wireframes para validar comprensión.
- **Historias de Usuario:** En metodologías ágiles, como punto de partida para RF.

### 5.2 Fase 2: Análisis y Especificación

```
Entrevistas / Workshops
        ↓
Historias de Usuario / Casos de Uso
        ↓
Clasificación (RF / RNF / Interfaz / Restricciones)
        ↓
Validación con stakeholders
        ↓
Documentación formal en SRS
        ↓
Revisión y aprobación (sign-off)
```

### 5.3 Fase 3: Plantilla de Requisito Atómico

Cada requisito debe documentarse así:

```markdown
## RF-[NNN]: [Nombre corto del requisito]

**ID:**            RF-001
**Prioridad:**     Alta / Media / Baja
**Estado:**        Propuesto / Aprobado / Implementado / Verificado
**Origen:**        Historia de Usuario HU-001
**Descripción:**   El sistema DEBE permitir al usuario autenticarse mediante email y contraseña.
**Precondición:**  El usuario tiene una cuenta activa en el sistema.
**Flujo Normal:**
  1. El usuario ingresa email y contraseña.
  2. El sistema valida las credenciales contra la base de datos.
  3. Si son correctas, el sistema genera un JWT y redirige al dashboard.
**Flujos Alternativos:**
  - 2a. Credenciales incorrectas → mostrar mensaje de error genérico.
  - 2b. Cuenta bloqueada → redirigir a proceso de desbloqueo.
**Criterio de Aceptación:**
  - DADO QUE el usuario tiene cuenta activa
  - CUANDO ingresa credenciales correctas
  - ENTONCES recibe JWT válido y accede al dashboard en < 2s
**Componentes relacionados:** AuthController, UserRepository, JWTService
**Casos de prueba:** TC-001, TC-002, TC-003
```

### 5.4 Gestión de Cambios en Requisitos

Los requisitos evolucionan. Todo cambio debe seguir un proceso:

```
1. Solicitud de Cambio (Change Request - CR)
        ↓
2. Análisis de Impacto (técnico, costo, tiempo)
        ↓
3. Aprobación por CCB (Change Control Board)
        ↓
4. Actualización del SRS (versión incrementada)
        ↓
5. Comunicación a todos los stakeholders
        ↓
6. Actualización de componentes afectados (código, pruebas, docs)
```

**Control de versiones del SRS:**

| Versión | Fecha | Autor | Descripción del Cambio |
|---|---|---|---|
| 1.0 | 2025-01-10 | J. Pérez | Versión inicial aprobada |
| 1.1 | 2025-02-05 | M. García | Se agrega RF-045: exportación PDF |
| 2.0 | 2025-03-20 | J. Pérez | Rediseño módulo de pagos |

---

## 6. SRS en Metodologías Ágiles vs. Tradicionales

| Aspecto | Waterfall (Tradicional) | Ágil (Scrum/Kanban) |
|---|---|---|
| Documento | SRS completo antes de desarrollar | SRS vivo + Product Backlog |
| Momento | Al inicio del proyecto | Iterativo por sprint |
| Nivel de detalle | Exhaustivo desde el inicio | Just-in-time (se detalla cuando se necesita) |
| Cambios | Proceso formal de control de cambios | Reordenamiento del backlog |
| Requisitos no funcionales | En sección dedicada del SRS | Definition of Done + NFR Backlog |
| Validación | Sign-off formal | Review de sprint con stakeholders |

> 💡 **En proyectos ágiles**, el SRS no desaparece: se fragmenta en épicas, historias de usuario y criterios de aceptación, complementados con documentos de arquitectura y un backlog bien gestionado.

---

## 7. Herramientas para Gestionar SRS

| Herramienta | Tipo | Uso |
|---|---|---|
| **Jira** | ALM/Ágil | Historias de usuario, epics, trazabilidad |
| **Confluence** | Wiki | Documentación SRS colaborativa |
| **Azure DevOps** | ALM/DevOps | Requisitos, pruebas, pipelines integrados |
| **ReqIF** | Estándar | Intercambio de requisitos entre herramientas |
| **IBM DOORS** | ALM Enterprise | Gestión avanzada con trazabilidad completa |
| **Notion / Obsidian** | General | Documentación ligera para startups |
| **GitHub Issues** | Dev | Gestión simple de requisitos en repos |

---

## 8. Errores Comunes en un SRS

1. **Requisitos ambiguos:** "El sistema debe ser fácil de usar" → ¿medible cómo?
2. **Gold plating:** Especificar features que nadie pidió.
3. **Mezclar QUÉ con CÓMO:** El SRS define qué, no la arquitectura.
4. **Sin criterios de aceptación:** ¿Cómo saber cuándo está "listo"?
5. **Sin priorización:** Todo en "Alta prioridad" es lo mismo que ninguna.
6. **Requisitos duplicados:** Contradicciones internas difíciles de detectar.
7. **No versionar el documento:** Sin control de cambios = caos.
8. **Olvidar los RNF:** Los errores de rendimiento/seguridad son los más costosos en producción.

---

## 9. Ejemplo Práctico: SRS para una App de E-Commerce

### Contexto
> Sistema de comercio electrónico para pequeñas empresas con módulos de catálogo, carrito, pagos y gestión de pedidos.

### Fragmento de Requisitos Funcionales

```
RF-001: Gestión de Catálogo
  - El sistema DEBE permitir crear productos con: nombre, descripción, precio, stock, imágenes (máx 5).
  - El sistema DEBE soportar categorías jerárquicas (máx 3 niveles).
  - El sistema DEBE actualizar el stock en tiempo real al confirmar una compra.

RF-002: Carrito de Compras
  - El sistema DEBE persistir el carrito por 30 días sin login.
  - El sistema DEBE calcular totales con impuestos según la región del usuario.
  - El sistema DEBE validar disponibilidad de stock al proceder al pago.

RF-003: Proceso de Pago
  - El sistema DEBE integrar Stripe y PayPal como pasarelas de pago.
  - El sistema DEBE soportar pagos en COP, USD y EUR.
  - El sistema DEBE enviar comprobante de pago por email en < 1 minuto tras confirmación.
```

### Fragmento de Requisitos No Funcionales

```
RNF-001 (Rendimiento):
  - Tiempo de carga del catálogo: < 1.5s con hasta 10,000 productos.
  - Procesamiento de pago: < 3s en el 95% de las transacciones.

RNF-002 (Seguridad):
  - Comunicación cifrada TLS 1.3 en todas las rutas.
  - Datos de tarjeta nunca almacenados en el sistema (tokenización PCI-DSS).
  - Autenticación con JWT + refresh tokens (expiración: 15 min / 7 días).

RNF-003 (Escalabilidad):
  - La arquitectura debe soportar escalar horizontalmente hasta 50,000 usuarios concurrentes.
  - Auto-scaling habilitado en cloud provider para picos de demanda.
```

---

## 10. Checklist de Calidad para tu SRS

```
✅ ¿Tiene un ID único cada requisito?
✅ ¿Cada requisito es verificable/testeable?
✅ ¿Se usó "DEBE" (obligatorio) vs "DEBERÍA" (deseable) correctamente?
✅ ¿Están priorizados todos los requisitos (MoSCoW o similar)?
✅ ¿Existe criterio de aceptación para cada RF?
✅ ¿Los RNF tienen valores numéricos específicos?
✅ ¿Hay matriz de trazabilidad?
✅ ¿El documento tiene control de versiones?
✅ ¿Fue revisado y aprobado por stakeholders?
✅ ¿Los requisitos son consistentes entre sí (sin contradicciones)?
```

---

## 11. Estándares y Referencias

| Estándar | Descripción |
|---|---|
| **IEEE 830-1998** | Práctica recomendada para SRS (base histórica) |
| **ISO/IEC/IEEE 29148:2018** | Estándar vigente para ingeniería de requisitos |
| **ISO/IEC 25010** | Modelo de calidad de software (base para RNF) |
| **BABOK v3** | Guía de análisis de negocios (elicitación) |
| **SWEBOK v3** | Cuerpo de conocimiento en ingeniería de software |

---

*Documento generado como referencia técnica. Adaptar según metodología, tecnología y contexto organizacional del proyecto.*
