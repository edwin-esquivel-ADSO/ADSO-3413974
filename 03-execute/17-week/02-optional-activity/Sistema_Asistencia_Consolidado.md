# Sistema de Gestión de Asistencia — Documento Consolidado

**Ficha:** 3413974 — Análisis y Desarrollo de Software (SENA)
**Estado:** Versión definitiva consolidada (unifica las tres propuestas previas)
**Fecha de consolidación:** 11/07/2026

> **Nota metodológica:** Este documento reúne y reorganiza, sin eliminar ninguna idea, el contenido de las tres versiones trabajadas previamente: (1) la propuesta de módulo QR integrado a SOFIA Plus, (2) el análisis profesional con reglas de negocio, actores y modelo enriquecido, y (3) el planteamiento de un sistema independiente que no depende de SOFIA Plus. Donde dos fuentes proponían lo mismo, se fusionó en un único requisito; donde divergían (ver nota de la sección 3), se documentan ambas opciones para que el equipo decida.

---

## 1. Problemática

El proceso actual de toma de asistencia presenta las siguientes fallas:

- **Operativas (fuente 1):** el registro en SOFIA Plus es lento y manual, quita dinamismo al inicio de la clase, genera pérdida de tiempo de formación y aumenta el riesgo de errores o bloqueos por inactividad.
- **De modelo de datos (fuente 2):** el esquema binario presente/ausente no representa tardanzas, salidas anticipadas, asistencia parcial ni justificaciones; no hay rol de Aprendiz ni de Coordinador con permisos diferenciados; no existe auditoría de cambios; no se definen jornadas, bloques horarios ni modalidad (presencial/virtual/híbrida); no hay notificaciones ni reportes estadísticos reales; no se contempla el olvido de registro por parte del instructor, ni el traslado de ficha, ni la conectividad en clases virtuales, ni límites de tiempo para modificar un registro, ni la diferencia entre falta justificada e injustificada.
- **De alcance institucional (fuente 3):** se plantea además la necesidad de un sistema propio, más ágil, que no dependa de SOFIA Plus.

---

## 2. Descripción General de la Solución

El sistema centraliza el llamado a lista, la automatización por código QR, la gestión de horarios/jornadas y el ciclo completo de justificaciones y auditoría, resolviendo tanto el problema operativo (fuente 1) como los vacíos de modelo de datos (fuente 2).

Al seleccionar la ficha y la sesión de formación, la plataforma despliega de inmediato el listado completo del grupo con dos flujos complementarios:

1. **QR dinámico con verificación de ubicación:** el instructor proyecta un código QR aleatorio, válido por un tiempo configurable (por defecto 5 minutos). El aprendiz, ya autenticado, lo escanea desde su celular; el sistema valida el token, el dispositivo, y **la ubicación GPS del aprendiz contra la geocerca del ambiente**, registrando su presente en tiempo real.
2. **Gestión y registro en bloque:** para quienes no alcanzaron a registrar el QR, el instructor visualiza la lista con los ausentes pre-marcados, puede definir horas de falla, justificaciones masivas o individuales, y cargar un archivo Excel semanal, consolidando todo con un solo botón.

El registro por bloques horarios permite además capturar asistencia parcial (tardanzas, salidas anticipadas), y todo el ciclo de justificaciones, auditoría, notificaciones de riesgo y reportes queda soportado de forma nativa.

> **Nota de decisión de arquitectura:** la fuente 1 planteaba modificar la pantalla nativa de SOFIA Plus, mientras que la fuente 3 planteaba un sistema independiente que no use SOFIA Plus. Para no perder ninguna de las dos ideas, este documento asume que el sistema se construye como **plataforma propia e independiente**, con un requisito no funcional de interoperabilidad que deja abierta una futura integración o exportación de datos hacia SOFIA Plus (ver RNF-13).

---

## 3. Actores del Sistema

| Actor | Descripción |
|---|---|
| **Instructor** | Registra, modifica y consulta la asistencia de los aprendices de sus fichas asignadas; genera y proyecta el QR. |
| **Aprendiz** | Escanea el QR o se autoregistra en sesión virtual, consulta su propia asistencia y radica justificaciones. |
| **Coordinador Académico** | Aprueba/rechaza justificaciones y modificaciones sensibles; consulta estadísticas generales; recibe soportes de justificación. |
| **Administrador del Sistema** | Gestiona usuarios, roles, fichas, ambientes y parámetros de configuración (jornadas, umbrales, ventanas de tiempo, radio de geocerca). |
| **Sistema (actor automático)** | Calcula estados de asistencia, valida token/dispositivo/ubicación, genera notificaciones y alertas de riesgo. |

---

## 4. Requisitos Funcionales (RF)

| Código | Requisito |
|---|---|
| RF01 | El sistema deberá desplegar automáticamente el listado completo de aprendices al seleccionar la ficha, permitiendo registrar estados enriquecidos de asistencia (Presente, Ausente, Tarde, Ausencia parcial, Justificado, Permiso, Incapacidad). |
| RF02 | El sistema deberá permitir seleccionar varios aprendices a la vez (casillas) y asignarles horas/justificación en bloque, manteniendo la opción de editar cada fila individualmente. |
| RF03 | El sistema deberá permitir cargar un archivo Excel para pre-rellenar los datos de fallas, y copiar automáticamente la fecha de inicio en la de fin (editable) para inasistencias de varios días. |
| RF04 | El sistema deberá contar con un botón único que guarde en un solo paso todas las novedades de asistencia configuradas en pantalla. |
| RF05 | El sistema deberá permitir registrar asistencia por bloques horarios y calcular automáticamente el estado global de la jornada (parcial, tardanza, etc.) a partir de dichos bloques. |
| RF06 | El sistema deberá permitir generar y proyectar un código QR dinámico por sesión, con token criptográfico no reutilizable, vigencia configurable (por defecto 5 min), autenticación previa del aprendiz, registro automático de sus datos al escanear y sincronización en tiempo real del listado del instructor. |
| RF07 | El sistema deberá validar que la petición de escaneo provenga de la sesión activa del dispositivo del aprendiz, e impedir el doble registro o el registro desde un mismo hardware para dos cuentas distintas. |
| RF08 | Al finalizar el tiempo del QR, el sistema deberá consolidar automáticamente la matriz de asistentes (presentes) y ausentes. |
| RF09 | **(Nuevo)** El sistema deberá capturar la geolocalización del aprendiz al escanear el QR o autoregistrarse, y validarla contra el radio (geocerca) configurado para el ambiente de la sesión. |
| RF10 | **(Nuevo)** Si la ubicación queda fuera de rango o no está disponible, el sistema deberá marcar el registro como "pendiente de revisión" sin bloquear al aprendiz; el administrador podrá configurar las coordenadas y el radio de cada ambiente. |
| RF11 | El sistema deberá permitir configurar jornadas, horarios y bloques (con descansos) por ficha, ambiente e instructor. |
| RF12 | El sistema deberá permitir registrar la modalidad de la sesión (presencial, virtual o híbrida), el autoregistro del aprendiz en sesiones virtuales, y las incidencias técnicas de conexión como causal justificada. |
| RF13 | El sistema deberá permitir cancelar una sesión sin generar faltas, y asociar más de un instructor a una misma sesión. |
| RF14 | El sistema deberá permitir generar, desde el perfil del aprendiz, un soporte de justificación con datos precargados dirigido al correo de Coordinación. |
| RF15 | El sistema deberá permitir adjuntar evidencia digital a una justificación y gestionar un flujo formal de aprobación/rechazo por parte del coordinador. |
| RF16 | El sistema deberá permitir al aprendiz radicar justificaciones desde su propio perfil dentro de un plazo definido, incluso después de ocurrida la falta. |
| RF17 | El sistema deberá registrar en un historial de auditoría inmutable toda modificación a un registro de asistencia, restringiendo la edición libre a una ventana de tiempo configurable y exigiendo aprobación del coordinador fuera de ella o al cambiar "Ausente" a "Presente". |
| RF18 | El sistema deberá notificar automáticamente al registrar una falta, y alertar al aprendiz, instructor y coordinador cuando se supere el umbral de inasistencia injustificada. |
| RF19 | El sistema deberá permitir consultar el historial de asistencia con filtros (ficha, aprendiz, fecha, modalidad, estado) y generar reportes estadísticos y de riesgo de deserción, incluyendo la consulta propia del aprendiz. |
| RF20 | El sistema deberá permitir transferir aprendices entre fichas/ambientes conservando su historial, restringir a cada instructor a sus fichas asignadas, y requerir autenticación por rol (RBAC) para Instructor, Aprendiz, Coordinador y Administrador. |

---

## 5. Requisitos No Funcionales (RNF)

| Código | Requisito |
|---|---|
| RNF01 | **Rendimiento:** registro individual vía QR en máximo 2–3 segundos; registro de una ficha completa (hasta 40 aprendices) en máximo 3 segundos. |
| RNF02 | **Seguridad:** comunicación bajo HTTPS, control de acceso basado en roles (RBAC) y auditoría inmutable (no editable ni eliminable). |
| RNF03 | **Disponibilidad y concurrencia:** disponibilidad mínima del 99% en horario de formación, soportando hasta 50 registros simultáneos en 10 segundos sin degradar la interfaz. |
| RNF04 | **Compatibilidad y usabilidad:** Web App responsiva compatible con Chrome, Edge, Firefox, Android e iOS sin apps externas; registro masivo de una ficha completable en menos de 2–3 minutos sin capacitación especializada. |
| RNF05 | **Protección de datos:** cumplimiento de la Ley 1581 de 2012 para datos personales, evidencias médicas y de ubicación; los datos de geolocalización deben almacenarse cifrados y usarse exclusivamente para validar asistencia. |
| RNF06 | **(Nuevo) Precisión de geolocalización:** radio de precisión configurable (ej. 20–50 m) acorde a la precisión típica de GPS en interiores; la imprecisión se trata como revisión manual, no como bloqueo automático. |
| RNF07 | **Escalabilidad y mantenibilidad:** el sistema debe crecer en fichas/aprendices sin degradar el rendimiento, y sus reglas de negocio (umbrales, ventanas de tiempo, radio de geocerca) deben ser configurables sin cambios de código. |
| RNF08 | **Disponibilidad offline e interoperabilidad (futuro):** registro sin conexión con sincronización posterior (recomendado), y posible integración/exportación de datos hacia SOFIA Plus. |

---

## 6. Reglas de Negocio (RN)

| Código | Regla |
|---|---|
| RN01 | La asistencia se gestiona por bloques horarios dentro de una jornada, no como un valor único por día. |
| RN02 | Un aprendiz llega tarde si su hora de ingreso está dentro de un margen configurable (ej. 15 min); después de ese margen se considera ausencia parcial del bloque correspondiente. |
| RN03 | El estado global de asistencia se calcula automáticamente a partir de las horas asistidas frente a las horas totales de la jornada. |
| RN04 | Toda modificación a un registro de asistencia debe quedar registrada en el historial de auditoría, sin excepción. |
| RN05 | Un instructor solo puede modificar libremente un registro dentro de la ventana de tiempo definida (ej. 48 horas) posterior al cierre de la sesión. |
| RN06 | Modificaciones fuera de la ventana permitida, o que cambien "Ausente" a "Presente", requieren aprobación del coordinador. |
| RN07 | Toda justificación debe estar respaldada por evidencia digital y quedar en estado "Pendiente" hasta su aprobación o rechazo. |
| RN08 | Una falta justificada no incrementa el indicador de riesgo de pérdida de formación; una falta injustificada sí. |
| RN09 | El sistema debe notificar automáticamente cuando el porcentaje de inasistencia injustificada supere el umbral definido por el Reglamento del Aprendiz vigente. |
| RN10 | Un aprendiz solo puede tener un registro de asistencia por bloque horario y por sesión (no duplicados). |
| RN11 | El instructor solo puede registrar/modificar asistencia de las fichas y ambientes que tiene asignados. |
| RN12 | Al cambiar de ficha o ambiente, el historial de asistencia previo del aprendiz se conserva y queda asociado a la ficha de origen. |
| RN13 | En sesiones virtuales se debe registrar la modalidad y, si aplica, evidencia de conexión. |
| RN14 | Las sesiones canceladas no generan faltas para ningún aprendiz de la ficha. |
| RN15 | Los reportes de asistencia deben poder filtrarse por ficha, aprendiz, fecha, instructor, modalidad y tipo de estado. |
| RN16 | **(Nuevo)** Un registro de asistencia presencial cuya geolocalización quede fuera del radio configurado para el ambiente no se rechaza automáticamente: queda en estado "Pendiente de revisión" y el instructor decide si lo valida como presente. |
| RN17 | **(Nuevo)** Un aprendiz sin permisos de geolocalización activados en su dispositivo podrá igualmente escanear el QR, pero su registro quedará marcado como "Ubicación no disponible", visible para el instructor. |

> ⚠️ **Nota de cumplimiento normativo:** RN08 y RN09 deben validarse contra el Reglamento del Aprendiz SENA vigente (Acuerdo 009 de 2024 o el que aplique), ya que los porcentajes y causales de retiro por inasistencia pueden variar entre versiones.

---

## 7. Casos de Uso

| Código | Caso de uso | Actor principal |
|---|---|---|
| CU01 | Iniciar / cerrar sesión | Todos los roles |
| CU02 | Seleccionar ficha y sesión de formación | Instructor |
| CU03 | Visualizar listado de aprendices | Instructor |
| CU04 | Desplegar módulo QR de clase | Instructor |
| CU05 | Validar token y tiempo límite del QR | Sistema |
| CU06 | Escanear QR e impedir duplicados / multidispositivo | Aprendiz / Sistema |
| CU07 | **(Nuevo)** Validar geolocalización del aprendiz contra la geocerca del ambiente | Sistema |
| CU08 | Actualizar lista de asistencia en tiempo real | Sistema / Instructor |
| CU09 | Registrar asistencia por bloque horario (incl. parcial: tardanza/salida anticipada) | Instructor |
| CU10 | Consolidar ausencias y carga masiva (Excel) | Instructor |
| CU11 | Modificar un registro de asistencia | Instructor / Coordinador |
| CU12 | Consultar historial de asistencia (por ficha, aprendiz, fecha) | Instructor / Coordinador |
| CU13 | Consultar mi asistencia | Aprendiz |
| CU14 | Radicar justificación de inasistencia (con evidencia) | Aprendiz / Instructor |
| CU15 | Tramitar justificación directa a Coordinación (correo) | Aprendiz |
| CU16 | Aprobar o rechazar justificación | Coordinador |
| CU17 | Aprobar modificación fuera de ventana permitida | Coordinador |
| CU18 | Generar reporte de asistencia | Instructor / Coordinador |
| CU19 | Generar reporte de aprendices en riesgo de deserción | Coordinador |
| CU20 | Configurar jornada, bloques horarios, descansos y geocerca del ambiente | Administrador |
| CU21 | Transferir aprendiz entre fichas/ambientes | Administrador / Coordinador |
| CU22 | Cancelar sesión de formación | Instructor |
| CU23 | Autoregistrar asistencia en sesión virtual | Aprendiz |
| CU24 | Consultar historial de auditoría de un registro | Coordinador / Administrador |
| CU25 | Gestionar usuarios y roles | Administrador |
| CU26 | Recibir notificación de riesgo de inasistencia | Aprendiz / Instructor / Coordinador (automático) |

---

## 8. Clases Principales del Dominio

| Clase | Descripción breve |
|---|---|
| **Usuario** | Clase base para autenticación (generaliza a Instructor, Aprendiz, Coordinador, Administrador). |
| **Instructor** | Especialización de Usuario; asociado a una o varias fichas. |
| **Aprendiz** | Especialización de Usuario; asociado a una ficha activa. |
| **Coordinador** | Especialización de Usuario con permisos de aprobación. |
| **Ficha** | Agrupación académica de aprendices bajo un programa de formación. |
| **Ambiente** | Espacio físico o virtual donde se desarrolla la formación; incluye **coordenadas de referencia y radio de geocerca** (nuevo atributo). |
| **SesionFormacion** | Instancia concreta de una jornada (fecha, ficha, ambiente, modalidad, instructor(es)). |
| **BloqueHorario** | Segmento de tiempo dentro de una sesión. |
| **Asistencia** | Registro del estado de un aprendiz en un bloque horario; incluye **coordenadas de registro y bandera de validación de ubicación** (nuevo atributo). |
| **Justificacion** | Solicitud de justificación de inasistencia, con tipo y evidencia. |
| **Evidencia** | Archivo o documento adjunto a una justificación. |
| **Auditoria** | Registro histórico e inmutable de cambios sobre una Asistencia. |
| **Notificacion** | Mensaje automático generado por el sistema ante eventos relevantes. |
| **Reporte** | Documento generado a partir de consultas y agregaciones de asistencia. |
| **UmbralRiesgo** | Configuración de parámetros para el cálculo de riesgo de deserción. |

---

## 9. Diagrama de Secuencia del Proceso (con geolocalización)

```
Instructor                      Sistema                              Aprendiz
    |                                    |                              |
    | 1. Selecciona ficha e inicia QR    |                              |
    |----------------------------------->|                              |
    |                                    | 2. Genera QR dinámico        |
    |                                    |    (válido por 5 min)        |
    | 3. Proyecta QR en el ambiente      |                              |
    |<-----------------------------------|                              |
    |                                    | 4. Escanea QR e inicia sesión|
    |                                    |<-----------------------------|
    |                                    | 5. Solicita permiso de       |
    |                                    |    ubicación al dispositivo  |
    |                                    |<-----------------------------|
    |                                    | 6. Valida:                   |
    |                                    |    - Tiempo (< 5 min)        |
    |                                    |    - Dispositivo único       |
    |                                    |    - No duplicado            |
    |                                    |    - Ubicación dentro de     |
    |                                    |      geocerca del ambiente   |
    | 7. Notifica registro en vivo       | 8. Guarda "Presente" en BD   |
    |<-----------------------------------|----------------------------->|
    |                                    |                              |
    |============ A LOS 5 MINUTOS: EXPIRACIÓN DEL QR ===================|
    |                                    |                              |
    | 9. Muestra lista consolidada       |                              |
    |    (ausentes / pendientes de       |                              |
    |    revisión por ubicación)         |                              |
    |<-----------------------------------|                              |
    | 10. Agrega horas de falla / Excel  |                              |
    |     y presiona "Registrar"         |                              |
    |----------------------------------->|                              |
    |                                    | 11. Almacena novedades       |
    |                                    | 12. Aprendiz inicia          |
    |                                    |     justificación dirigida   |
    |                                    |     a Coordinación           |
    |                                    |<-----------------------------|
```

---

## 10. Situaciones Excepcionales Relevantes (incluye ubicación)

| # | Situación | Tratamiento propuesto |
|---|---|---|
| E1 | El aprendiz llega minutos después de iniciada la jornada. | Se registra hora real de llegada; el sistema calcula si es "Tardanza" o "Ausencia parcial" según el margen configurado. |
| E2 | El aprendiz olvida activar el GPS o niega el permiso de ubicación. | El registro queda marcado como "Ubicación no disponible", visible para revisión del instructor (RN17); no bloquea el registro de presente. |
| E3 | El aprendiz escanea el QR fuera del radio del aula (señal GPS imprecisa o intento de fraude). | El registro queda "Pendiente de revisión" (RN16); el instructor decide si lo valida, en lugar de un rechazo automático. |
| E4 | El instructor olvidó registrar la asistencia. | Se permite "asistencia extemporánea" dentro de la ventana definida, marcada como registro tardío en auditoría. |
| E5 | El instructor registró asistencia por error. | Corrección dentro de la ventana permitida; fuera de ella requiere aprobación del coordinador. |
| E6 | Clases virtuales o problemas de conexión. | Autoregistro por código de sesión sin geolocalización obligatoria; incidencias técnicas se registran como causal justificada. |
| E7 | Un aprendiz cambia de ambiente o ficha. | Se transfiere conservando el historial de asistencia previo. |
| E8 | Dos instructores comparten la misma ficha. | El sistema permite múltiples instructores asociados a una misma sesión, cada uno con su propio registro. |

---

## 11. Riesgos y Consideraciones para el Desarrollo

- **Precisión del GPS en interiores:** el radio de la geocerca debe calibrarse por ambiente; por eso las validaciones de ubicación fallidas se tratan como revisión manual y no como bloqueo automático (evita falsos negativos).
- **Privacidad de datos de ubicación:** al ser un dato sensible, debe almacenarse cifrado y con acceso restringido, conforme a la Ley 1581 de 2012.
- **Definición del umbral de riesgo de deserción:** validar contra el Reglamento del Aprendiz SENA vigente antes de fijarlo como regla fija; se recomienda configurable.
- **Concurrencia en fichas compartidas:** si dos instructores comparten ficha, definir cómo se evita duplicidad de registros simultáneos.
- **Registro offline:** si se soporta, diseñar la estrategia de sincronización y resolución de conflictos desde el inicio.
- **Escalabilidad de notificaciones:** diseñar el módulo de notificaciones de forma asíncrona (colas) para no afectar el rendimiento del registro.
- **Decisión de integración con SOFIA Plus:** definir en fases posteriores si el sistema opera en paralelo, exporta datos, o eventualmente se integra (ver nota de la sección 2).

---

## 12. Recomendaciones para el SRS y Modelo de Datos

1. Adoptar la estructura IEEE 830 / ISO-IEC-IEEE 29148 (introducción, descripción general, requisitos, anexos).
2. Redactar cada RF con el formato "El sistema deberá [acción] cuando [condición]", con criterios de aceptación medibles.
3. Incluir matriz de trazabilidad entre RF, casos de uso y clases del dominio.
4. Definir un glosario de términos SENA (ficha, ambiente, aprendiz, instructor, formación titulada/complementaria).
5. Modelar `Asistencia` como entidad asociativa entre `Aprendiz`, `SesionFormacion` y `BloqueHorario`, con clave única compuesta.
6. Modelar `Auditoria` como tabla append-only (solo inserción, nunca actualizable).
7. Incluir tabla `Configuracion`/`Parametros` para reglas variables (umbral de riesgo, ventana de edición, margen de tardanza, **radio de geocerca**).
8. Indexar `fecha`, `ficha_id` y `aprendiz_id` en la tabla de Asistencia para optimizar reportes.

---

*Fin del documento consolidado — Base lista para el desarrollo del SRS formal, los diagramas UML y el modelo de base de datos.*
