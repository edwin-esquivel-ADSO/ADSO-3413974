# Resumen Operativo de Procesos BPMN 2.0 — Sistema de Gestión de Horarios SENA

> **Documento Consolidado de Procesos BPMN**  
> **Ubicación de Fuentes XML:** `procesos Mockup BPMN/procesos Mockup BPMN/diagram_1.bpmn` a `diagram_10.bpmn`  
> **Propósito:** Documentar funcional y técnicamente los 10 flujos de trabajo que modelan la operación del Sistema de Gestión de Horarios SENA, detallando objetivos, actores ("Los Quién"), entradas/salidas de datos y la secuencia paso a paso.

---

## 1. diagram_1.bpmn — Creación y Validación Preventiva del Horario

### 1.1 Nombre del Proceso
**Creación y Validación Preventiva del Horario por el Coordinador Académico**

### 1.2 Objetivo del Proceso
Permitir al Coordinador Académico estructurar un horario borrador para una Ficha de Formación específica, ejecutando validaciones preventivas de disponibilidad docente, tope de horas semanales y cumplimiento de capacidad e infraestructura de los ambientes antes de guardar o publicar.

### 1.3 Actores Involucrados (Los "Quién")
- **Coordinador Académico**: Actor humano responsable de seleccionar la Ficha, asignar el RAP, seleccionar el Instructor y el Ambiente de formación.
- **Sistema (Motor de Programación)**: Actor automatizado que evalúa las reglas de negocio (disponibilidad, capacidad, equipamiento y cumplimiento del 100% de intensidad horaria).

### 1.4 Entradas y Salidas de Datos
- **Entradas**: Selección de Ficha de Formación (`enrollment_ficha_id`), Resultado de Aprendizaje (`learning_outcome_id`), Instructor propuesto (`instructor_id`), Ambiente de Formación (`environment_id`), Franja horaria (días, hora inicio/fin).
- **Salidas / Entidades Impactadas**: Registro de `Schedule` en estado `DRAFT`, sesiones de clase creadas en `ClassSession`, banderas de alerta de capacidad o sobrepaso de horas en la interfaz.

### 1.5 Pasos Principales del Flujo
1. **Inicio**: El Coordinador accede al módulo de programación de horarios y selecciona la Ficha de Formación objetivo.
2. **Asignación pedagógica**: Selecciona la competencia y el Resultado de Aprendizaje (RAP) a programar en el trimestre.
3. **Validación de Instructor (`Gateway: ¿Instructor disponible?`)**:
   - *Camino Feliz*: El sistema verifica que el instructor no tenga cruces de horario ni supere la intensidad máxima contractual (40h/semana).
   - *Excepción*: Si el instructor presenta un cruce o incapacidad, el sistema bloquea la asignación y sugiere instructores alternativos de la misma red de conocimiento.
4. **Validación de Ambiente (`Gateway: ¿Ambiente cumple capacidad y equipamiento?`)**:
   - *Camino Feliz*: El sistema valida que la capacidad del ambiente (`capacity`) sea mayor o igual al total de aprendices de la ficha (`total_learners`) y disponga del equipamiento requerido (ej. computadores, aire acondicionado).
   - *Excepción*: Si el ambiente no cumple, el sistema emite una advertencia de aforo o falta de recursos.
5. **Verificación de Cobertura Curricular (`Gateway: ¿100% de horas?`)**:
   - El sistema calcula si la sumatoria de franjas asignadas cubre el 100% de la duración en horas del RAP.
6. **Fin**: Se guarda el borrador del horario (`Schedule` en estado `DRAFT`).

---

## 2. diagram_2.bpmn — Publicación de Horarios y Motor de Conflictos

### 2.1 Nombre del Proceso
**Publicación de Horarios y Detección Automatizada de Conflictos**

### 2.2 Objetivo del Proceso
Ejecutar la validación algorítmica de cruces e inconsistencias sobre un horario borrador antes de hacerlo visible al centro de formación, gestionando el flujo de aprobación o la emisión de alertas de cruce en tiempo real.

### 2.3 Actores Involucrados (Los "Quién")
- **Coordinador Académico**: Revisa el resumen del horario borrador y solicita la publicación formal.
- **Sistema (Motor de Conflictos)**: Ejecuta las consultas de solapamiento en base de datos (`SchedulingConflict`).

### 2.4 Entradas y Salidas de Datos
- **Entradas**: Solicitud de publicación del `Schedule` ID.
- **Salidas / Entidades Impactadas**: Registros creados en `SchedulingConflict`, cambio de estado de `Schedule` (`DRAFT` → `CONFLICT_DETECTED` o `IN_REVIEW`), notificaciones emitidas a través de `Notification`.

### 2.5 Pasos Principales del Flujo
1. **Inicio**: El Coordinador hace clic en el botón "Publicar Horario".
2. **Ejecución del Motor de Conflictos**: El servicio realiza la detección automatizada de:
   - Doble reserva de instructor en el mismo bloque horario (`INSTRUCTOR_DOUBLE_BOOKING`).
   - Sobrereserva de ambiente de formación (`ROOM_OVERBOOKING`).
   - Colisión de sede o desplazamientos imposibles.
3. **Evaluación de Resultados (`Gateway: ¿Existen conflictos en los horarios?`)**:
   - *Si existen conflictos*: El sistema genera registros en `SchedulingConflict`, marca la bandera `has_conflict = TRUE` en las `ClassSession` afectadas y despliega un modal con la lista de cruces críticos y advertencias.
   - *Si no existen conflictos*: El sistema habilita el botón de confirmación de publicación directa.
4. **Resolución / Decisiones**: El Coordinador ajusta los cruces o confirma la publicación con advertencias menores.
5. **Fin**: Transición de estado del horario y notificación enviada.

---

## 3. diagram_3.bpmn — Máquina de Estados de Publicación de Horario

### 3.1 Nombre del Proceso
**Máquina de Estados y Transición Oficial a Horario Publicado**

### 3.2 Objetivo del Proceso
Formalizar el cambio del ciclo de vida del horario a estado `PUBLISHED`, haciendo efectivas las asignaciones docentes y desencadenando la distribución masiva de notificaciones a aprendices e instructores.

### 3.3 Actores Involucrados (Los "Quién")
- **Coordinador Académico**: Confirma la acción de publicación final en la interfaz.
- **Sistema (Servicio de Horarios & Notification Service)**: Actualiza el estado en base de datos y distribuye las alertas PUSH y correos institucionales.
- **Instructor / Aprendiz**: Destinatarios de las notificaciones del nuevo horario publicado.

### 3.4 Entradas y Salidas de Datos
- **Entradas**: Confirmación en modal de publicación (`schedule_id`).
- **Salidas / Entidades Impactadas**: `Schedule.status_id` actualizado a `PUBLISHED`, campo `published_at` con marca de tiempo, registros en `Notification` (canales PUSH y EMAIL) y traza en `AuditRecord`.

### 3.5 Pasos Principales del Flujo
1. **Inicio**: Apertura del modal de confirmación final de publicación de horario.
2. **Verificación de Conflictos Residuales (`Gateway: ¿Hay conflictos pendientes?`)**:
   - *Si hay conflictos críticos*: Se aborta la publicación y se obliga al usuario a corregir en la grilla.
   - *Si no hay conflictos*: Se procede con el cierre del periodo borrador.
3. **Evaluación de Confirmación (`Gateway: ¿Confirma la publicación?`)**:
   - El actor valida los términos y hace clic en "Confirmar y Notificar".
4. **Transición de Estado**: El sistema ejecuta una transacción que cambia `Schedule.status_id` a `PUBLISHED` e inmutabiliza la versión.
5. **Despacho de Notificaciones**: Se generan mensajes asincrónicos para cada aprendiz de la ficha y cada instructor programado.
6. **Fin**: Horario visible públicamente en el portal web y aplicación móvil.

---

## 4. diagram_4.bpmn — Gestión de Novedades e Incapacidades Docentes

### 4.1 Nombre del Proceso
**Radicación y Aprobación de Excepciones e Incapacidades del Instructor**

### 4.2 Objetivo del Proceso
Gestionar el ciclo de vida de una novedad docente (incapacidad médica, comisión de servicios, calamidad), desde su radicación con soporte digital por el instructor hasta la desasignación/reprogramación de clases por Coordinación.

### 4.3 Actores Involucrados (Los "Quién")
- **Instructor**: Radica la novedad, adjunta el documento de soporte e indica el rango de fechas.
- **Coordinador Académico**: Revisa el soporte adjunto y aprueba o rechaza la solicitud.
- **Sistema (Actors & Scheduling Service)**: Cancela o desasigna las sesiones de clase en el periodo afectado.

### 4.4 Entradas y Salidas de Datos
- **Entradas**: Formulario de excepción (tipo de novedad, fecha/hora inicio y fin, motivo text, archivo adjunto PDF/JPG).
- **Salidas / Entidades Impactadas**: Registro en `InstructorException` (`SUBMITTED` → `APPROVED` / `REJECTED`), actualización de `ClassSession.session_status_id` a `CANCELLED` / `REPROGRAMMED`, alerta a Coordinación.

### 4.5 Pasos Principales del Flujo
1. **Inicio**: El Instructor ingresa al módulo "Mis Novedades" y radicará una excepción.
2. **Diligenciamiento y Carga**: Selecciona el tipo de excepción, establece el rango temporal, escribe la justificación y adjunta el soporte PDF/JPG obligatorio.
3. **Revisión por Coordinación (`Gateway: ¿Coordinación aprueba soporte?`)**:
   - El Coordinador inspecciona el documento adjunto (`support_document_url`) y la justificación.
   - *Rechazado*: La novedad cambia a estado `REJECTED` y se notifica al instructor la razón.
   - *Aprobado*: La novedad cambia a estado `APPROVED`.
4. **Desasignación de Sesiones**: El sistema identifica todas las `ClassSession` del instructor dentro del rango temporal y actualiza su estado a canceladas o pendientes de reemplazo.
5. **Fin**: Se libera la disponibilidad de la Ficha para programación de plan de contingencia.

---

## 5. diagram_5.bpmn — Seguimiento Curricular y Bitácora de Ficha

### 5.1 Nombre del Proceso
**Seguimiento Curricular, Bitácora de Clase y Control de Asistencia**

### 5.2 Objetivo del Proceso
Registrar la ejecución pedagógica diaria de cada sesión de clase, capturando el número de aprendices asistentes/ausentes, las horas ejecutadas y actualizando automáticamente el porcentaje de avance acumulado en RAPs.

### 5.3 Actores Involucrados (Los "Quién")
- **Instructor**: Registra la bitácora al finalizar la jornada o sesión de clase.
- **Sistema (Monitoring Service)**: Calcula algorítmicamente el porcentaje de avance curricular (`curriculum_progress_pct`) y valida reglas de sobrepaso.

### 5.4 Entradas y Salidas de Datos
- **Entradas**: Ficha, fecha, sesión de clase, conteo de aprendices asistentes y ausentes, horas ejecutadas, observaciones pedagógicas.
- **Salidas / Entidades Impactadas**: Nuevo registro en `FichaTracking` y `FichaTrackingOutcome`, actualización de avance en RAPs, banderas de cancelación o sobrepaso de horas.

### 5.5 Pasos Principales del Flujo
1. **Inicio**: El Instructor selecciona la clase del día en su agenda pedagógica.
2. **Evaluación de Estado de Clase (`Gateway: ¿Sesión cancelada?`)**:
   - *Si fue cancelada*: Se marca la bitácora como cancelada (`is_cancelled = TRUE`) y se requiere seleccionar el motivo (ej. novedad docente, mantenimiento).
   - *Si fue ejecutada*: Se procede al formulario de registro de asistencia.
3. **Registro de Asistencia y Horas**: El instructor ingresa `attended_learners`, `absent_learners`, `executed_hours` y observaciones.
4. **Control de Horas Impartidas (`Gateway: ¿Horas superan la duración?`)**:
   - El sistema compara las horas acumuladas contra el total del RAP (`duration_hours`). Se emite una alerta si se supera la intensidad máxima aprobada.
5. **Cálculo de Avance Automatizado**: El servicio actualiza `curriculum_progress_pct = (aps_approved / aps_total) * 100`.
6. **Fin**: Cierre de la bitácora e integración con tableros de analítica.

---

## 6. diagram_6.bpmn — Monitoreo de Indicadores KPI y Analítica Institucional

### 6.1 Nombre del Proceso
**Monitoreo de Indicadores KPI y Analítica Institucional por el Director**

### 6.2 Objetivo del Proceso
Permitir a la Alta Dirección (Director de Centro / Subdirector) monitorear tableros de mando ejecutivos con métricas de ocupación de ambientes, avance de fichas, horas dictadas por instructor y alertas tempranas de deserción o subejecución.

### 6.3 Actores Involucrados (Los "Quién")
- **Director de Centro / Subdirector**: Actor que consulta el dashboard KPI, aplica filtros y exporta reportes.
- **Sistema / Analytics**: Motor de agregación de datos que calcula métricas en tiempo real a partir de `scheduling-service` y `monitoring-service`.

### 6.4 Entradas y Salidas de Datos
- **Entradas**: Filtros de consulta (Rango de fechas, Centro de Formación, Sede, Coordinación, Programa, Ficha).
- **Salidas / Entidades Impactadas**: Visualización de widgets KPI en pantalla, reportes exportados en formato CSV/PDF mediante `document-service`.

### 6.5 Pasos Principales del Flujo
1. **Inicio**: El Director ingresa al portal institucional y abre el módulo "Analítica Institucional & KPIs".
2. **Carga y Agregación**: El sistema procesa los indicadores clave (ej. % Ocupación de Aulas, % Avance Curricular Promedio, Ratio Aprendiz/Instructor).
3. **Evaluación de Riesgos (`Gateway: ¿Indicador bajo umbral?`)**:
   - *Si el indicador está crítico (rojo)*: El sistema resalta la Ficha o Instructor en el tablero con alertas visuales de riesgo de deserción o atraso lectivo.
4. **Interacción Drill-Down**: El Director hace clic en un widget para desglosar la información por ficha o coordinación académica.
5. **Exportación Documental (`Gateway: ¿Solicita exportación?`)**:
   - *Si solicita exportar*: El sistema envía los datos al `document-service` para generar un reporte oficial en PDF/CSV con sello institucional.
6. **Fin**: Cierre de consulta o descarga del archivo.

---

## 7. diagram_7.bpmn — Generación de Documentos y Certificaciones Oficiales

### 7.1 Nombre del Proceso
**Generación de Documentos y Certificaciones Oficiales con Firma Digital**

### 7.2 Objetivo del Proceso
Expedir reportes oficiales del sistema (ej. Horario Oficial de Ficha, Reporte de Carga Horaria Docente, Certificados) garantizando validez jurídica mediante código Hash SHA-256, Firma Digital y código de Retención Documental (TRD).

### 7.3 Actores Involucrados (Los "Quién")
- **Usuario Solicitante (Coordinador / Instructor / Aprendiz)**: Solicita la emisión de un documento específico.
- **Sistema (Document Service)**: Valida permisos, renderiza la plantilla HTML/Markdown, compila a PDF, aplica el Hash SHA-256 y registra la auditoría.

### 7.4 Entradas y Salidas de Datos
- **Entradas**: ID del documento/entidad a certificar, ID del usuario solicitante, tipo de plantilla (`template_id`).
- **Salidas / Entidades Impactadas**: Registro en `Document` (`file_path`, `file_hash`, `digital_signature`, `trd_code`), archivo PDF descargable, log en `AuditRecord`.

### 7.5 Pasos Principales del Flujo
1. **Inicio**: El usuario hace clic en "Generar Reporte PDF" o "Expedir Certificación".
2. **Validación de Seguridad (`Gateway: ¿Datos y permisos válidos?`)**:
   - *Permiso denegado*: Se muestra un mensaje de error HTTP 403 Forbidden y se registra intento fallido en `AuditRecord`.
   - *Permiso concedido*: Se procede a extraer los datos relacionales de la entidad.
3. **Renderizado de Plantilla**: El engine compila los datos dentro de la plantilla oficial (`DocumentTemplate`).
4. **Criptografía y Estampa**:
   - Se calcula el Hash checksum SHA-256 del contenido binario.
   - Se estampa la firma digital institucional y el código TRD.
5. **Almacenamiento y Entrega**: El PDF se guarda en la ruta física/cloud y se entrega al usuario mediante descarga directa.
6. **Fin**: Inserción del registro inmutable en `Document` y actualización de auditoría.

---

## 8. diagram_8.bpmn — Administración de Catálogos, Parámetros y RBAC

### 8.1 Nombre del Proceso
**Administración de Catálogos, Parámetros del Sistema y Roles RBAC**

### 8.2 Objetivo del Proceso
Gestionar la configuración maestra de la plataforma, incluyendo la creación/edición de datos de referencia (Sedes, Tipos de Ambiente, Estados) y la matriculación/asignación de roles y permisos a usuarios con soporte de resolución administrativa.

### 8.3 Actores Involucrados (Los "Quién")
- **Administrador / Soporte**: Usuario superadministrador con permisos de gestión global.
- **Sistema (IAM & Reference Data Service)**: Verifica restricciones de integridad referencial antes de actualizar catálogos o permisos.

### 8.4 Entradas y Salidas de Datos
- **Entradas**: Formularios de creación/edición de catálogos (`CatalogDetail`), asignación de rol (`user_id`, `role_id`, `training_center_id`, `resolution_number`).
- **Salidas / Entidades Impactadas**: Registros creados/modificados en `User`, `Role`, `UserRole`, `TrainingCenter`, `CatalogDetail`, traza inmutable en `AuditRecord`.

### 8.5 Pasos Principales del Flujo
1. **Inicio**: El Administrador ingresa al módulo de "Administración del Sistema & Parámetros".
2. **Gestión de Catálogos / Usuarios**: Selecciona la opción de parametrizar catálogos maestros o gestionar cuentas de usuario.
3. **Validación de Integridad Referencial**:
   - Antes de desactivar o modificar un catálogo o rol, el sistema valida que no existan entidades activas dependientes (ej. no eliminar un estado si está en uso por `Schedule`).
4. **Asignación RBAC con Resolución**: El Administrador otorga un nuevo rol a un usuario, especificando el Centro de Formación de alcance y el número de resolución oficial SIGA.
5. **Inmutabilidad en Auditoría**: Se graba una entrada en `AuditRecord` con el objeto anterior (`old_values`) y nuevo (`new_values`).
6. **Fin**: Aplicación inmediata de las nuevas reglas de control de acceso.

---

## 9. diagram_9.bpmn — Sistema de Notificaciones del Aprendiz ante Modificaciones

### 9.1 Nombre del Proceso
**Sistema de Notificaciones del Aprendiz ante Cambios de Horario o Aula**

### 9.2 Objetivo del Proceso
Detectar automáticamente cualquier modificación realizada sobre un horario previamente publicado (cambio de ambiente, reprogramación de hora o reemplazo de instructor) e informar de inmediato a los aprendices afectados mediante notificaciones interactivas.

### 9.3 Actores Involucrados (Los "Quién")
- **Aprendiz**: Destinatario de la notificación PUSH/Email en su dispositivo o portal.
- **Sistema (Notification Service & Scheduling Service)**: Servicio automatizado de fondo que monitorea modificaciones en `ClassSession` y despacha alertas.

### 9.4 Entradas y Salidas de Datos
- **Entradas**: Evento de actualización sobre `ClassSession` (cambio de `environment_id` o `instructor_id`).
- **Salidas / Entidades Impactadas**: Nuevos registros en `Notification` (`channel = PUSH/EMAIL`, `deep_link = /horario/ficha/...`), indicador visual de alerta en UI del aprendiz.

### 9.5 Pasos Principales del Flujo
1. **Inicio (Evento)**: El Coordinador guarda una modificación en una `ClassSession` de una Ficha con horario publicado.
2. **Clasificación del Evento (`Gateway: ¿Qué cambio de aula o instructor?`)**:
   - *Cambio de Aula/Ambiente*: Se clasifica como alerta de reubicación espacial.
   - *Cambio de Instructor*: Se clasifica como alerta de sustitución docente.
3. **Construcción del Mensaje y Deep Link**: Se genera un texto amigable resaltando el cambio y se adjunta un enlace directo (`deep_link`).
4. **Despacho Multicanal**: El `notification-service` entrega el aviso vía Push a la App Móvil y por correo a `@soy.sena.edu.co`.
5. **Interacción del Aprendiz (`Gateway: ¿Hace clic?`)**:
   - Si el Aprendiz toca la notificación, el sistema lo redirige de inmediato a la vista "Mi Horario" con el bloque modificado resaltado en color.
6. **Fin**: Confirmación de entrega y marca de lectura (`is_read = TRUE`).

---

## 10. diagram_10.bpmn — Autenticación del Aprendiz y Consulta de Horario

### 10.1 Nombre del Proceso
**Autenticación del Aprendiz y Consulta de Horario Vigente**

### 10.2 Objetivo del Proceso
Garantizar el acceso seguro del aprendiz a la plataforma mediante autenticación de credenciales, direccionándolo a la consulta de su horario trimestral vigente y el detalle de recursos pedagógicos asociados.

### 10.3 Actores Involucrados (Los "Quién")
- **Aprendiz**: Usuario que ingresa al portal o App Móvil para consultar su programación académica.
- **Sistema (IAM & Scheduling Service)**: Autentica al usuario, identifica la Ficha activa y retorna las sesiones de clase.

### 10.4 Entradas y Salidas de Datos
- **Entradas**: Formulario de Login (número de documento / correo y contraseña), selección de fecha en calendario.
- **Salidas / Entidades Impactadas**: Token de sesión (JWT), vista del horario semanal renderizada en pantalla, registros en `AuditRecord` (evento LOGIN).

### 10.5 Pasos Principales del Flujo
1. **Inicio**: El Aprendiz abre la aplicación e ingresa sus credenciales de acceso.
2. **Verificación de Credenciales (`Gateway: ¿Las credenciales coinciden?`)**:
   - *No coinciden*: Muestra mensaje de error "Usuario o contraseña inválidos" y bloquea tras 3 intentos.
   - *Coinciden*: El sistema genera el token JWT e identifica la Ficha en la que el aprendiz está matriculado (`Learner.enrollment_ficha_id`).
3. **Consulta de Horario (`Gateway: ¿Horario publicado?`)**:
   - *No publicado*: Despliega una pantalla de "Estado Vacío" (*Empty State*) indicando que la Coordinación aún no ha publicado el horario del trimestre.
   - *Publicado*: Carga la grilla semanal con las sesiones programadas.
4. **Selección y Detalle**: El aprendiz hace clic sobre una franja de clase para desplegar el modal con: Nombre del RAP, Instructor, Ambiente, Sede, Modalidad y Enlace Virtual si aplica.
5. **Fin**: Consulta finalizada satisfactoriamente.
