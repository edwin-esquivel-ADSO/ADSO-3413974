# Sustentación técnica ADSO: Horarios y Asistencia SENA

**Fecha de corte:** 28 de agosto de 2026  
**Propósito:** presentar dos dominios relacionados, pero deliberadamente separados: el sistema de **gestión de horarios** ya modelado en BPMN y datos lógicos, y la hoja de ruta del sistema de **asistencia** en proceso de modernización.

## Resultado ejecutivo

La evidencia local demuestra que el trabajo de las sesiones del 8 y 15 de agosto corresponde al dominio de **Horarios**: planeación, conflictos, publicación, RAP, novedades y seguimiento. La sesión del 22 de agosto incorpora documentación de **Asistencia** —Discovery, ADRs y modelo de datos—, pero los diez BPMN almacenados allí siguen describiendo horarios, no QR, biometría o excusas.

La defensa más sólida es presentar ambos frentes así:

1. **Horarios:** artefactos BPMN y de modelo lógico ya existentes; se explica qué resuelven y qué ajustes de notación quedan pendientes.
2. **Asistencia:** arquitectura objetivo y migración gobernada, basada en Discovery y ADRs, sin afirmar que cada decisión propuesta esté ya implementada.

## 1. Trazabilidad de la evidencia

| Fecha | Ruta y artefacto | Dominio | Evidencia principal |
|---|---|---|---|
| 08 de agosto | `Agosto/08/MVP/01-workflows-mockup.md`, `models.md`, `models_3.md`, auditoría e historias de usuario | Horarios | Auditoría del mockup, actores, flujos y modelo lógico preliminar. |
| 15 de agosto | `Agosto/15/MacroProceso.bpmn`, `SubProceso1.bpmn`, `SubProceso2.bpmn`, `SubProceso3.bpmn`, `models.md` | Horarios | BPMN operativos y modelo lógico global. |
| 22 de agosto | `Agosto/22/MVP - BPMN - MDLDATOS/` | Horarios / Asistencia | Guion y modelo de horarios, Discovery y ADRs del sistema de asistencia. |
| Repositorio final | `Asistencia Sena MVP -FINAL/` | Asistencia | PHP legado, `database`, `docs/discovery.md`, ADR-001 a ADR-009 y scripts de migración. |

### Control de consistencia documental

- La subcarpeta existente se llama `procesos Mockup BPMN/procesos Mockup BPMN`; no coincide literalmente con el nombre escrito en la guía.
- `diagram_1.bpmn` a `diagram_10.bpmn` tienen títulos como “Maquetación y creación de horario”, “Publicación oficial de horario” y “Notificación y verificación de cambio de horario”. Son evidencia de **Horarios**, no de los diez procesos de asistencia.
- `Agosto/15/models.md` señala fecha 17 de junio y estado “Borrador”, aunque se conserva bajo la sesión de agosto. Se usa como modelo lógico de referencia, no como DDL final.
- `Agosto/08/MVP/01-workflows-mockup.md` contiene bytes nulos y `models_2.md` tiene problemas de codificación. Para explicar el modelo conviene utilizar `models.md` y `models_3.md`.

## 2. Dominio A — Sistema de gestión y planeación de horarios

### 2.1 Objetivo de negocio

Planear, validar, publicar y ajustar horarios de formación sin cruces de instructor, ambiente, franja o capacidad. El resultado permite que instructores y aprendices consulten una agenda publicada, y que el coordinador gestione novedades y conflictos de manera trazable.

### 2.2 BPMN disponibles y defensa técnica

| Artefacto | Qué se defiende | Actores visibles |
|---|---|---|
| `MacroProceso.bpmn` | Ciclo trimestral: planear fichas, validar cruces, oficializar, publicar, consultar agenda y evaluar RAP. | Coordinación/Director, Sistema, Instructor, Aprendiz. |
| `SubProceso1.bpmn` | Asignación de ficha, instructor y ambiente; validación de cruces; ciclo de corrección si hay conflicto. | Coordinador, Sistema. |
| `SubProceso2.bpmn` | Registro de juicio evaluativo y actualización de avance del RAP. | Instructor, Sistema/SofiaPlus. |
| `SubProceso3.bpmn` | Solicitud, evaluación y decisión de novedad o cambio de horario. | Instructor, Coordinador, Sistema. |

#### Macroproceso de planeación y publicación

La Coordinación selecciona fichas, instructores y ambientes. El sistema valida restricciones de disponibilidad. Una vez el horario es aprobado, se publica y se notifica. Instructor y aprendiz consultan su agenda; el instructor registra lo ejecutado y reporta los resultados de aprendizaje.

La idea que debe quedar clara es que **un horario no se publica solo porque fue digitado**: primero debe atravesar la validación de recursos y conflictos. La publicación convierte el borrador en información oficial para los usuarios afectados.

#### Subproceso de conflictos y cruces

En `SubProceso1.bpmn`, el sistema evalúa “¿Existe cruce de horario o ambiente?”.

```text
Coordinador selecciona ficha, instructor y ambiente
  → Sistema valida disponibilidad
  → XOR: ¿existe cruce?
      Sí → muestra alerta y motivo → corregir parámetros → validar de nuevo
      No → guardar horario y publicar en agenda
```

La colisión de un ambiente técnico para dos fichas en la misma franja se resuelve impidiendo la segunda asignación. El sistema reporta el conflicto, devuelve el proceso a la selección y conserva únicamente una asignación válida. En una implementación física, esta garantía no debe depender solo de la pantalla: se complementa con restricción de solapamiento o validación transaccional en la base de datos.

#### Asignación de RAP y novedades

En `SubProceso2.bpmn`, el instructor selecciona ficha y RAP, registra el juicio evaluativo y el sistema actualiza el avance. En `SubProceso3.bpmn`, el instructor solicita una modificación; el coordinador decide y el sistema actualiza la agenda y notifica.

Para responder sobre la coincidencia entre competencia/RAP y disponibilidad contractual, se debe indicar que la validación ocurre **antes de guardar la sesión**, dentro de la validación de disponibilidad. El diseño lógico debe vincular el instructor con sus competencias, fichas y vigencia contractual; si no existe una asignación válida, la sesión no se publica.

### 2.3 Compuertas, carriles y mejoras BPMN

| Elemento | Uso correcto para horarios | Estado de los archivos revisados |
|---|---|---|
| XOR | Elegir una sola ruta: hay/no hay cruce, aprobar/rechazar novedad, RAP completo/en proceso. | Sí aparecen; las salidas deben mantener etiquetas explícitas “Sí/No” o condiciones equivalentes. |
| AND | Ejecutar tareas simultáneas e independientes, por ejemplo verificar instructor y ambiente en paralelo, seguido de una unión AND. | No hay compuertas AND en los BPMN revisados. Solo deben agregarse si ambas validaciones ocurren realmente en paralelo; no como decoración. |
| Lanes | Representar responsable real: Coordinación Académica, Instructor solicitante, Director de Grupo y Sistema SofiaPlus/Gestor. | Hay carriles, pero algunos agrupan actores (“Coordinación/Director”, “Sistema/SofiaPlus”, “Instructor/Solicitante”). Conviene separarlos cuando la responsabilidad sea distinta. |
| Eventos de fin | Diferenciar publicación/actualización exitosa de conflicto, rechazo o dato inválido. | Hay finales, pero no siempre son eventos de error explícitos. |

### 2.4 Modelo de datos de horarios y 3FN

El modelo lógico usa entidades como `Environment`, `EnrollmentFicha`, `TrainingProgram`, `Competency`, `LearningOutcome`, `Schedule`, `ClassSession`, `Instructor` y reglas de disponibilidad. Para una sustentación relacional se puede expresar con estas tablas núcleo:

| Tabla | Responsabilidad | Relación clave |
|---|---|---|
| `programas_formacion` | Catálogo del programa. | 1:N con `fichas`; 1:N con `competencias`. |
| `competencias` | Unidad curricular del programa. | 1:N con `rap`. |
| `rap` | Resultado de aprendizaje evaluable. | N:1 con competencia; asociado a sesión o planeación. |
| `fichas` | Cohorte concreta de un programa. | N:1 con programa; N:M con instructores. |
| `instructores` | Datos del formador y su capacidad. | N:M con fichas y competencias mediante tablas de cruce. |
| `ambientes` | Aula o laboratorio y su capacidad/equipamiento. | 1:N con sesiones o disponibilidad. |
| `horarios_sesion` | Instancia de clase: ficha, instructor, ambiente, día y franja. | N:1 con ficha, instructor, ambiente y RAP. |
| `instructor_fichas` | Tabla intermedia de asignaciones. | Resuelve N:M entre instructores y fichas. |
| `ambiente_horarios` o la referencia desde sesión | Ocupación del ambiente por franja. | Permite detectar colisiones. |

**Justificación de 3FN:** cada tabla describe una sola entidad; la ficha no repite el nombre del programa, la sesión no repite datos del ambiente ni del instructor y las relaciones N:M se resuelven en tablas intermedias. Esto reduce anomalías de actualización y evita que el mismo hecho se guarde varias veces.

**Controles que deben mencionarse:**

- claves foráneas con `ON DELETE RESTRICT` para proteger asignaciones históricas;
- `CHECK (hora_fin > hora_inicio)` para evitar franjas inválidas;
- índice compuesto en `(ambiente_id, dia_semana, hora_inicio, hora_fin)` y otro equivalente para instructor;
- validación transaccional de solapamiento antes de confirmar una sesión.

### 2.5 Preguntas y respuestas: horarios

**¿Cómo resuelve el BPMN una colisión de ambiente?**  
El gestor valida disponibilidad antes de guardar. La XOR “¿Existe cruce?” dirige al coordinador a una alerta y a corregir la asignación; solo la ruta sin conflicto guarda y publica. En la base de datos se refuerza con índices y validación de solapamiento.

**¿Qué ocurre si el instructor no está disponible para el RAP?**  
La sesión no debe avanzar a publicación. La validación consulta la asignación del instructor a ficha/competencia y su disponibilidad contractual; si falla, genera conflicto y vuelve a la fase de planeación.

**¿Por qué una tabla intermedia `instructor_fichas`?**  
Porque un instructor puede atender varias fichas y una ficha puede recibir formación de varios instructores. Una lista dentro de una sola tabla rompería la 1FN y dificultaría la integridad referencial.

## 3. Dominio B — Sistema de asistencia: hoja de ruta arquitectónica

### 3.1 Alcance delimitado

El MVP de asistencia cubre QR dinámico, enrolamiento y verificación biométrica, registro de asistencia, excusas, evidencias y concurrencia. No absorbe horarios, calificaciones ni matrículas. Esa delimitación evita convertir una modernización acotada en una reescritura total.

### 3.2 Fases de evolución

| Fase | Finalidad | Evidencia / resultado esperado |
|---|---|---|
| 0. Discovery | Congelar línea base, problema, actores, alcance y deuda técnica PHP. | `docs/discovery.md`, inventario de hallazgos P0–P2 y criterios de aceptación. |
| 1. ADRs | Formalizar decisiones, alternativas y consecuencias. | ADR-001 a ADR-009, con estatus visible. |
| 2. Gobernanza modular | Separar responsabilidades físicas y de revisión. | `app/web`, `backend`, `database`, `docs`; reglas de nombres, pruebas y CI. |
| 3. Datos y backend | Construir la persistencia y las validaciones atómicas. | Vector `FLOAT8[]`, entidad `excusas`, constraints, endpoints y pruebas. |
| 4. Auditoría y cierre | Probar la solución y retirar progresivamente las rutas PHP. | Dark launch, métricas, feature flags, reconciliación y plan de retiro. |

### 3.3 ADRs que sostienen el diseño

| ADR | Decisión |
|---|---|
| 001 | Migrar PHP MVC a Next.js con TypeScript. |
| 002 | Adoptar verificación biométrica facial con consentimiento. |
| 003 | Aplicar QR HMAC-SHA256 rotativo y límite de reapertura. |
| 004 | Guardar `public_id` de Cloudinary y entregar URL firmada temporal. |
| 005 | Gobernar un repositorio modular con `app/web`, `backend`, `database`, `docs`. |
| 006 | Persistir un descriptor facial vectorial para mejorar rendimiento. |
| 007 | Actualizar paneles activos con polling controlado y revalidación. |
| 008 | Usar bloqueo optimista con `version` para decisiones de excusa. |
| 009 | Separar flujo y autoridad de excusas unidía y multidía. |

### 3.4 Punto crítico que se debe expresar con precisión

La documentación tiene tres estados diferentes que no deben confundirse:

- ADR-001 a ADR-005 figuran como **aceptados**; ADR-006 a ADR-009 como **propuestos**.
- El repositorio revisado no contiene aún las carpetas físicas `app/web` y `backend` que ADR-005 propone.
- `migrate.js` guarda `face_descriptor_json TEXT`; el objetivo de ADR-006 es `FLOAT8[]`. Tampoco están materializadas en `schema.sql` la tabla canónica `excusas`, `excusa_instructores`, `CHECK (fecha_fin >= fecha_inicio)` ni la unicidad `(qr_session_id, aprendiz_id)`.

Además, los documentos no son completamente consistentes respecto a biometría: unas secciones describen extracción del descriptor en el cliente y comparación en servidor; otras describen comparación en cliente. La decisión recomendada para cerrar la brecha es: **el cliente captura y extrae el descriptor; el backend valida, recupera la referencia y calcula la distancia**, sin devolver el descriptor de referencia. Esta definición debe quedar en el contrato del endpoint y en las pruebas de rendimiento.

## 4. Migración de monolito desestructurado a monolito modular

### Definiciones

| Modelo | Característica |
|---|---|
| Monolito desestructurado | Interfaz, reglas de negocio y acceso a datos se mezclan; hay dependencias implícitas y cambios difíciles de aislar. El PHP legado es la línea base. |
| Monolito modular | Una aplicación y un despliegue, pero módulos con dueño, contratos y dependencias controladas. Cada módulo posee una responsabilidad cohesiva. |
| Microservicios | Procesos desplegables independientes que se comunican por red y exigen observabilidad, resiliencia y coordinación de datos distribuidos. No son el objetivo del MVP. |

El monolito modular conserva despliegues atómicos y transacciones locales. Por eso evita la latencia interservicio y el costo de Saga/2PC que los microservicios introducirían prematuramente.

### Comparación de estrategias

| Estrategia | Descripción | Ventajas | Riesgos |
|---|---|---|---|
| Strangler Fig adaptado | Un feature flag o middleware dirige un flujo nuevo al módulo moderno mientras el PHP atiende lo demás. | Entregas graduales, rollback rápido y menor tiempo de inactividad. | Coexistencia temporal y posible divergencia de datos. |
| Migración vertical por módulos | Mover UI, reglas y persistencia de una capacidad completa: Auth → Asistencia → Excusas. | Contextos claros y pruebas de regresión enfocadas. | Requiere puentes de datos transitorios. |
| Migración horizontal por capas | Rehacer primero datos, luego backend y finalmente UI. | Esquema nuevo uniforme desde el principio. | Tiende a Big Bang y tarda en entregar valor. |

**Decisión recomendada:** Strangler Fig como estrategia principal, ejecutada mediante migración vertical. Así se sustituye una capacidad completa y usable sin cortar todo el sistema.

### Operación segura durante la transición

| Riesgo | Práctica de control |
|---|---|
| Datos inconsistentes | Definir una fuente de verdad por módulo, permitir solo escrituras controladas y usar réplica unidireccional temporal si hace falta. |
| Error del módulo nuevo | Feature flag revierte tráfico al PHP si se supera el umbral acordado de fallos. |
| Regresión funcional | Dark launch: la lógica moderna calcula en sombra y sus resultados se comparan con PHP sin cambiar el resultado del usuario. |
| Carrera en excusas | `version` y `UPDATE` condicional; si no modifica filas, responder HTTP 409 y recargar. |
| Exposición de soportes | `public_id`, autorización, URL firmada con TTL de 300 s y secretos solo en backend. |

**Criterios de cierre:** disponibilidad igual o superior a 99,5 %, p95 biométrico menor a 200 ms, cero escrituras perdidas en pruebas de concurrencia, reconciliación de datos sin diferencias críticas y retiro formal de `legacy_php_app/` solo después de aprobación.

## 5. Pitch de un minuto

> Para esta sustentación articulamos dos frentes técnicos. Primero defendemos el sistema de horarios mediante BPMN y un modelo en tercera forma normal: la planeación valida instructor, ambiente, franja y RAP antes de publicar, evitando colisiones y manteniendo la trazabilidad de las novedades. Segundo presentamos la evolución del sistema de asistencia. No proponemos una reescritura masiva ni microservicios innecesarios; aplicamos una migración gradual de monolito a monolito modular con el patrón Strangler Fig. El Discovery delimita el MVP a QR, biometría y excusas, y nueve ADR definen la seguridad HMAC, el control biométrico, las evidencias firmadas y la concurrencia. De esta manera modernizamos por módulos, mantenemos rollback y protegemos la integridad de los datos durante toda la transición.

## 6. Lista de verificación previa

- [ ] Llevar los cuatro BPMN del 15 de agosto para la defensa del dominio Horarios.
- [ ] No identificar los diez `diagram_*.bpmn` del 22 de agosto como BPMN de asistencia: son de horarios.
- [ ] Explicar cuándo se usa XOR y cuándo sería correcto incorporar AND.
- [ ] Mostrar cómo las tablas y restricciones evitan duplicados, orfandad y solapamiento de horarios.
- [ ] Distinguir hechos implementados, ADRs aceptados y ADRs propuestos.
- [ ] Aclarar el contrato definitivo de biometría: captura cliente, comparación autorizada en backend.
- [ ] No usar `database/schema.sql` con `DROP TABLE ... CASCADE` en una base productiva.
- [ ] Preparar evidencia de feature flags, prueba de carrera HTTP 409, QR vencido y duplicado de asistencia antes de cerrar la migración.
