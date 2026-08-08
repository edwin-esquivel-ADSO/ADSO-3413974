# Auditoría General del MVP — Sistema de Gestión de Horarios SENA

> **Rol de análisis:** Aprendiz SENA  
> **Fuente de la Verdad:** Manual del Sistema Integrado de Gestión y Autocontrol (SIGA - Articulación MIPG DO-M-001) y Proceso de Gestión de Formación Profesional Integral (GFPI) del SENA.  
> **Objeto de evaluación:** Mockup navegable del Sistema de Horarios SENA ([code-sena.github.io/design-software-mockup](https://code-sena.github.io/design-software-mockup/))

---

## Resumen Ejecutivo

El prototipo analizado busca digitalizar y optimizar la planeación, publicación y seguimiento de horarios en los Centros de Formación Profesional del SENA. Si bien el mockup presenta una interfaz visual moderna (basada en un *Design System* consistente con tokens de diseño, tablas interactivas y modales responsivos), desde la **visión del Aprendiz SENA** y bajo el contraste riguroso del **Manual SIGA / MIPG (DO-M-001)**, se evidencian inconsistencias operativas, desconexión de flujos de trabajo críticos e insuficiencias en la representación de la realidad académica del SENA.

Este documento consolida una crítica constructiva y técnica de **todas las 53 pantallas del prototipo**, destacando las fallas de experiencia de usuario (UX), los vacíos de lógica de negocio (Gaps) y proponiendo soluciones integrales alineadas a la normatividad institucional.

---

## Marco Normativo y Fuente de la Verdad: SIGA - MIPG (DO-M-001) y GFPI

Para fundamentar las sugerencias y críticas, se toma como referencia el **Sistema Integrado de Gestión y Autocontrol (SIGA)** articulado con el **Modelo Integrado de Planeación y Gestión (MIPG)**:

1. **Dimensión de Gestión con Valores para el Resultado (MIPG):** Exige la optimización de los trámites y la transparencia hacia el ciudadano/aprendiz. Un sistema de horarios no solo coordina espacios físicamente, sino que garantiza el derecho del aprendiz a la formación profesional trazable.
2. **Proceso de Gestión de Formación Profesional Integral (GFPI):**
   - **Diseño Curricular:** Cadena jerárquica estricta: *Línea Tecnológica → Red Tecnológica → Red de Conocimiento → Programa de Formación → Competencia → Resultado de Aprendizaje (RAP)*.
   - **Ejecución de la Formación:** Basada en la *Planeación Pedagógica*, las *Guías de Aprendizaje* y las *Actividades del Proyecto Formativo*.
   - **Juicios de Evaluación:** Registro del logro de RAPs (*Aprobado / No Aprobado*) en la plataforma oficial (SofiaPlus / ZAJUNA).
   - **Continuidad del Servicio e Incapacidades/Excusas:** Procedimiento SIGA para la gestión del talento humano docente. La inasistencia o indisponibilidad de un instructor exige notificación inmediata a la Coordinación Académica para activar plan de contingencia (remplazo o reprogramación oficial).

---

## Análisis de Sugerencias Clave del Aprendiz

### Avance Curricular Transparente y Basado en Sesiones/RAPs (Instructor y Aprendiz)

> **Deficiencia actual en el Mockup:**  
> En el módulo de *Seguimiento de Ficha* (Pantallas 23 y 24), el campo `Avance Curricular (%)` es un simple **campo de texto/número manual** en el que el instructor escribe libremente un porcentaje (ej. `65%`). En las pantallas del Aprendiz (Pantallas 25 y 27), el aprendiz **no tiene ninguna visibilidad** de su progreso en el programa de formación.

**Propuesta de Solución desde la Óptica del Aprendiz:**

- **En el Panel del Instructor (`/instructor/seguimiento`):** El avance curricular **NO debe ser digitado manualmente**. Debe ser un indicador **calculado automáticamente** por el sistema en función de:
  1. **Horas Ejecutadas vs. Horas Totales:** Sesiones de clase impartidas y validadas por asistencia.
  2. **Resultados de Aprendizaje (RAPs) Evaluados:** Número de RAPs asociados a las actividades desarrolladas en la ficha que ya cuentan con juicio evaluativo emitido.
  3. **Visualización por Ficha:** Desglose del avance por fases del proyecto (*Análisis, Diseño, Desarrollo, Evaluación*).
- **En el Panel del Aprendiz (`/mi-horario` y `/mi-avance`):** Se debe crear un módulo de **"Mi Avance Curricular"** donde el aprendiz pueda visualizar:
  - Porcentaje global de cumplimiento del programa (Lógica: RAPs aprobados / RAPs totales del programa).
  - Estado detallado por **Competencias y RAPs**: RAPs aprobados, RAPs en ejecución (según horario vigente) y RAPs pendientes.
  - Trazabilidad de sesiones asistidas frente a la intensidad horaria exigida por la reglamentación SENA (cumplimiento del 80%+ de asistencia requerida para no incurrir en deserción por inasistencia).

---

### Flujo Completo e Integrado para Excepciones/Excusas del Instructor

> **Deficiencia actual en el Mockup:**  
> En la pantalla *Mi Disponibilidad del Instructor* (Pantallas 21 y 22), el instructor registra bloqueos puntualizados (incapacidad médica, capacitación, comisión). Sin embargo, **el sistema guarda este registro de manera aislada**. No genera ninguna solicitud, aviso ni notificación para la Coordinación Académica. Tampoco actualiza el motor de horarios ni refleja en el dashboard del coordinador que esa ficha se quedará sin instructor en esas fechas.

**Propuesta de Solución e Integración en SIGA:**

- **Circuito de Aprobación y Contingencia:**
  1. **Registro:** El instructor radica la excusa/excepción adjuntando soporte (soporte médico EPS, memorando de comisión, etc.).
  2. **Notificación Automática a Coordinación:** La novedad ingresa de forma inmediata a una **Bandeja de Novedades de Instructores** en el Dashboard del Coordinador Académico (`#/`).
  3. **Evaluación e Impacto en Horarios:** El sistema le indica automáticamente al coordinador qué fichas y sesiones resultan afectadas por la inasistencia.
  4. **Plan de Contingencia (Asignación de Sustituto o Reprogramación):** El coordinador puede:
     - Asignar un *Instructor de Remplazo* disponible.
     - Reprogramar las horas de la sesión a una fecha posterior.
     - Aprobar trabajo independiente / guía de aprendizaje asincrónica.
  5. **Notificación al Aprendiz:** Una vez aprobada la novedad por Coordinación, el sistema envía una **Alerta/Notificación al Aprendiz** informando la cancelación, cambio de ambiente o asignación del instructor sustituto para la clase.

---

# Auth, App Shell y Estados del Sistema (Pantallas 01 – 06)

## Funcionalidades incompletas
- **Login (`#/login`):** Falta autenticación multifactor (MFA) requerida por políticas de seguridad de la información SIGA (ISO 27001).
- **Recuperar contraseña (`#/forgot-password`):** No indica canales de mesa de ayuda del centro ni tiempo de vigencia del enlace de recuperación.
- **Panel de Notificaciones (`?overlay=notifications`):** Notificaciones estáticas sin acciones directas (*deep links*) para resolver la alerta desde la misma notificación.

## Errores encontrados
- **App Shell (`#/review/app-shell`):** No visualiza el Centro de Formación ni la Sede en la barra de estado superior; el usuario no puede confirmar en qué sede está operando.
- **Estados Globales (`#/system-states`):** Los mensajes de error 403, 404, 500 y sesión expirada son genéricos y no orientan al usuario final sobre cómo proceder.

## Campos faltantes y lógica de negocio
- **Login:** No soporta inicio de sesión único (SSO) con MiSena / SoySena / Microsoft 365 institucional.
- **Nueva contraseña (`#/reset-password`):** Falta indicador visual de complejidad de contraseña según política SIGA (mínimo 8 caracteres, mayúsculas, símbolos).
- **Panel de Notificaciones:** No permite filtrar por tipo (*Académica, Horarios, Bienestar, Administrativa*) ni responder/marcar como leída.

## Mejoras recomendadas
- **Login:** Permitir SSO con plataformas institucionales del SENA.
- **Recuperar contraseña:** Añadir verificación por token SMS/Correo y enlace directo al soporte del centro de formación.
- **App Shell:** Mostrar nombre del Centro de Formación, Sede y Ficha activa (para aprendices) en la barra superior.
- **Estados Globales:** Personalizar errores con enlaces directos para solicitar ayuda al Administrador de Soporte del Centro.

---

# Coordinador Académico

## Funcionalidades incompletas
- **Horarios (modal "Agregar sesión"):** no permite eliminar sesiones desde la tabla.
- **Horarios (modal "Agregar sesión"):** no permite publicar el horario; queda bloqueado por "instructor doble asignado" sin indicar cómo resolverlo.
- **Instructores (dentro de Horarios):** el apartado no se despliega como sección independiente.
- **Dashboard / Inicio (`#/?as=coordinator`):** No muestra las novedades de instructores (excusas/incapacidades) ni alertas de inasistencia acumulada de fichas.
- **Horarios — Lista (`#/horarios`):** Falta filtro por Jornada (Diurna, Nocturna, 24/7) y por Fase del Proyecto Formativo.
- **Detalle de Horario (`#/horarios/sch-03`):** No permite exportar el horario en formatos estándar institucionales (PDF firmado o iCal/Google Calendar).
- **Modal Confirmar Publicación (`?modal=publish`):** No genera constancia digital ni notifica automáticamente a los aprendices afectados al publicar un horario.
- **Panel de Conflictos (`#/horarios/sch-02/conflictos`):** No detecta cruces de transporte para instructores que viajan entre sedes distantes en franjas consecutivas.
- **Modal Resolver Conflicto (`?modal=resolve`):** La resolución es completamente manual sin sugerencias automatizadas del sistema (*Smart Assistant*).
- **Disponibilidad (`#/disponibilidad`):** Muestra disponibilidad de ambientes pero no el listado consolidado de disponibilidad horaria de instructores (GAP G2).
- **Detalle de Ambiente (`#/disponibilidad/ambientes/env-01`):** No registra el estado de mantenimiento ni el inventario de equipos tecnológicos (PC, videobeam, software instalado).

## Errores encontrados
- **Horarios (parte superior):** hay botones que no responden al presionarlos.
- **Horarios (modal "Agregar sesión"):** al presionar "Editar" se abre el modal con el título "Agregar sesión" en vez de mostrar los datos para editar.
- **Horarios (modal "Agregar sesión"):** aparece una alerta de instructor duplicado que no debería mostrarse.
- **Instructores:** el botón no funciona.
- **Instructores:** el botón "Consultar" no funciona.
- **Instructores:** la barra de paginación (Anterior / 1 2 3 / Siguiente) no funciona en ninguna de sus partes.
- **Fichas:** el filtro no funciona.

## Campos faltantes y lógica de negocio
- **Modal Agregar/Editar Sesión (`?modal=session`):** **GRAVE** — No permite asociar la sesión a un *Resultado de Aprendizaje (RAP)* específico ni a una *Actividad de Aprendizaje*. Según GFPI, cada sesión debe estar vinculada a un RAP para garantizar la trazabilidad pedagógica.
- **Crear/Editar Horario (`#/horarios/nuevo`):** No valida el cupo del ambiente asignado vs. la cantidad de aprendices matriculados en la ficha. Puede asignarse un aula para 20 personas a una ficha de 35 aprendices.
- **Dashboard:** Falta una *Bandeja de Novedades de Instructores* que reciba automáticamente las excepciones registradas por instructores y muestre las fichas/sesiones afectadas.
- **Panel de Conflictos:** Falta regla de validación geográfica: tiempo mínimo de traslado entre sedes para un mismo instructor en franjas consecutivas.
- **Fichas — Lista (`#/fichas`):** No diferencia entre Etapa Lectiva y Etapa Productiva en la vista primaria. Falta columna y filtro por Etapa de Formación (*Inducción, Lectiva, Productiva, Graduada*).
- **Detalle de Ficha (`#/fichas/fic-01`):** No muestra el listado de aprendices matriculados ni el vocero de ficha designado. Falta pestaña "Aprendices" con estado de matrícula y datos de contacto del Vocero de Ficha y Líder de Bienestar.

## Mejoras recomendadas
- **Horarios (modal "Agregar sesión"):** ajustar el responsive del formulario.
- **Horarios (modal "Agregar sesión"):** revisar el mensaje y la lógica de bloqueo al publicar.
- **Horarios (modal "Agregar sesión"):** el campo Instructor no debería poder cambiarse al editar una sesión existente, para evitar la alerta de duplicado.
- **Instructores:** reubicar el apartado para que no dependa de "Ambientes".
- **Dashboard:** Integrar la *Bandeja de Novedades de Instructores* y métricas de fichas con riesgo de incumplimiento de horas.
- **Horarios — Lista:** Incluir filtros avanzados por programa de formación y versión de diseño curricular.
- **Detalle de Horario:** Añadir botón de exportación masiva y sincronización automática con calendarios de aprendices e instructores.
- **Crear/Editar Horario:** Incorporar alerta automática cuando el cupo del ambiente sea menor que el número de aprendices de la ficha.
- **Modal Agregar Sesión:** Obligar la selección del RAP que se ejecutará en la sesión para garantizar la trazabilidad pedagógica GFPI.
- **Modal Confirmar Publicación:** Al publicar, disparar notificación push y correo a todos los aprendices inscritos en la ficha.
- **Panel de Conflictos:** Incluir regla de validación geográfica de tiempo de traslado entre sedes.
- **Modal Resolver Conflicto:** Proponer alternativas automáticas de instructores o ambientes libres en esa misma franja horaria.
- **Detalle de Ambiente:** Vincular con el inventario SIGA del ambiente para saber si el laboratorio cuenta con las herramientas necesarias para la clase.

---

# Instructor

## Funcionalidades incompletas
- **Seguimiento:** se aplica de forma manual; debería aplicarse de forma automática.
- **Seguimiento de Ficha (`#/instructor/seguimiento`):** Muestra el porcentaje de avance como un valor plano estático. El permiso requiere elevación (GAP B3).
- **Mi Disponibilidad (`#/instructor/mi-disponibilidad`):** **DESCONECTADO** — El registro de excepciones (incapacidades, comisiones) no fluye hacia Coordinación Académica ni modifica la programación de horarios.

## Errores encontrados
- **Mi horario:** los botones de semana anterior / siguiente no funcionan.
- **Disponibilidad (nueva excepción):** el ícono del botón aparece duplicado ("++").
- **Seguimiento:** el filtro no funciona correctamente.
- **General (botones de agregar):** el ícono duplicado ("++") se repite en casi todos los botones de agregar de esta sección.

## Campos faltantes y lógica de negocio
- **Seguimiento / Modal Registrar Seguimiento (`?modal=tracking`):** Permite escribir un porcentaje de avance curricular arbitrario (ej. `65%`). **El avance debe calcularse automáticamente** a partir de las sesiones realizadas, el registro de asistencia y los RAPs evaluados — no digitarse manualmente.
- **Modal Crear Excepción (`?modal=exception`):** No solicita el cargue obligatorio de soportes en PDF (incapacidad EPS o citación). Según la gestión documental SIGA, debe exigirse adjuntar el archivo de soporte (PDF/JPG).
- **Mi Disponibilidad:** El registro debe convertirse en una *Solicitud de Novedad Docente* con estado (`Pendiente`, `Aprobada`, `Rechazada`) y flujo de aprobación hacia Coordinación.

## Mejoras recomendadas
- **Mi horario:** ajustar el responsive del detalle de cada sesión y la información que muestra.
- **Disponibilidad (formulario de nueva excepción):** corregir la posición de los cuadros de información, que se ven mal ubicados.
- **Seguimiento:** Reemplazar el valor plano de avance por un tablero interactivo de indicadores automáticos de asistencia y RAPs evaluados.
- **Modal Crear Excepción:** Exigir adjuntar el archivo de soporte (PDF/JPG) cumpliendo con la gestión documental SIGA.

---

# Aprendiz

## Funcionalidades incompletas
- **Notificaciones:** el detalle solo muestra el motivo del cambio, sin más contexto.
- **Mi Horario (`#/mi-horario`):** Vista acotada en formato de lista. No ofrece vista en formato de Calendario Semanal (*Grid*) como la del instructor (GAP B2).
- **Panel del Aprendiz en general:** **No existe ningún módulo de "Mi Avance Curricular"** donde el aprendiz pueda visualizar su progreso en el programa de formación (RAPs aprobados, en ejecución y pendientes).

## Errores encontrados
- No se reportaron errores funcionales puntuales para este rol.

## Campos faltantes y lógica de negocio
- **Mi Horario:** Falta alternancia entre vista Lista y vista Calendario Semanal. Falta botón para sincronizar con Google Calendar / Outlook.
- **Notificaciones — Lista (`#/notificaciones`):** No diferencia notificaciones de cambios urgentes de horario vs. anuncios generales. Falta clasificación con códigos de color de urgencia (ej. *Rojo: Clase cancelada o cambio de ambiente urgente*).
- **Detalle de Clase (`#/mi-horario/sesiones/ses-01`):** No muestra los materiales de formación, enlace al aula virtual (ZAJUNA/Teams) ni la Guía de Aprendizaje asociada a la sesión.
- **Detalle de Notificación (`#/notificaciones/not-01`):** No permite interactuar (ej. "Confirmar lectura" o "Ver horario modificado"). Falta botón de acción directa.
- **Falta módulo completo "Mi Avance Curricular" (`#/aprendiz/mi-ruta`):** El aprendiz necesita visualizar:
  - Porcentaje global de cumplimiento del programa (RAPs aprobados / RAPs totales).
  - Estado detallado por Competencias y RAPs.
  - Trazabilidad de sesiones asistidas frente a la intensidad horaria exigida (80%+ de asistencia).

## Mejoras recomendadas
- **Mi horario:** rediseñar con un formato más visual y práctico, similar al del instructor. Proveer alternancia entre vista Lista y vista Calendario Semanal.
- **Notificaciones:** hacer el detalle más intuitivo y completo, generado de forma automática. Clasificar con códigos de color de urgencia.
- **Detalle de Clase:** Incluir enlace al Aula Virtual ZAJUNA, enlace a la sesión remota (si es virtual) y enlace a la Guía de Aprendizaje.
- **Detalle de Notificación:** Agregar botón de acción directa (*"Ver cambio en Mi Horario"* o *"Solicitar justificación de inasistencia"*).
- **Nuevo módulo "Mi Ruta de Formación":** Crear una pantalla navegable que muestre un mapa visual tipo árbol o barra de progreso por Fases (*Análisis, Diseño, Desarrollo, Evaluación*), destacando los RAPs logrados, las horas acumuladas y el porcentaje exacto de avance hacia la certificación.

---

# Director del Centro

## Funcionalidades incompletas
- **Usuarios:** no existe opción de editar un usuario ya creado, solo de añadirlo.
- **Indicadores:** "Ver todos los indicadores por ficha" y "Ver más" no funcionan.
- **Catálogo / Parámetros:** no queda claro por qué "Catálogo" no tiene permiso habilitado; parece haber duplicidad con "Parámetros".
- **Panel de Indicadores (`#/admin/indicadores`):** Mide asistencia y avance sin correlacionar con índices de deserción reales ni metas del Plan de Acción SIGA.
- **Drill-Down de KPI (`#/admin/indicadores/track-01/attendance`):** Los umbrales de asistencia son fijos y no toman en cuenta la modalidad de la ficha (Presencial vs. Virtual).
- **Crear/Editar Usuario (`?modal=user`):** No valida el correo institucional `@soy.sena.edu.co` o `@sena.edu.co`.
- **Modal Asignar/Revocar Rol (`?modal=role`):** Permite asignar roles sin exigir la justificación o número de acto administrativo (resolución).

## Errores encontrados
- **Indicadores:** el filtro no funciona.
- **Usuarios:** el filtro no funciona.
- **Usuarios (añadir usuario):** el ícono del botón aparece duplicado ("++").
- **Datos de referencia:** los botones "Mi centro", "Catálogos" y "Parámetros" no funcionan; su contenido aparece disperso hacia abajo en vez de organizado.
- **Datos de referencia:** "Guardar" y "+ Nueva sede" no funcionan.
- **Datos de referencia:** los botones de la parte inferior no funcionan.
- **Parametrización (Currículum académico, Jornada y franjas):** los botones de guardar/editar no son consistentes en los formularios.

## Campos faltantes y lógica de negocio
- **Usuarios — Lista (`#/admin/usuarios`):** No permite filtrar por ficha asociada en el caso de los aprendices. Faltan filtros por Tipo de Documento, Ficha de Formación y Estado de Matrícula.
- **Detalle de Usuario (`#/admin/usuarios/usr-02`):** No muestra el historial de accesos ni las fichas en las que el usuario está inscrito o imparte formación.
- **Modal Asignar/Revocar Rol:** Debe exigir número de resolución o memorando de asignación para roles administrativos (cumplimiento auditoría SIGA).
- **Datos de Referencia (`#/admin/datos-referencia`):** Interfaz técnica poco amigable para usuarios no administradores.
- **Panel de Indicadores:** Falta integrar tablero de control de deserción temprana con alertas para el equipo de Bienestar al Aprendiz.
- **Drill-Down de KPI:** Ajustar umbrales normativos según la modalidad (ej. mayor tolerancia en encuentros síncronos virtuales).
- **Crear/Editar Usuario:** Debe forzar la sintaxis de correo institucional según el dominio correspondiente al rol.

## Mejoras recomendadas
- **Indicadores:** mostrar simultáneamente la barra de seguimiento (izquierda) y las tablas de riesgo crítico (derecha).
- **Datos de referencia:** ordenar visualmente la sección en vez de mostrar todo disperso. Agrupar los catálogos por dominios funcionales claros (*Académico, Infraestructura, Usuarios*).
- **Parametrización (Currículum académico):** ajustar el responsive de los 6 campos (líneas, redes tecnológicas, etc.).
- **Parametrización (general):** revisar guardar, editar y responsive en el resto de formularios.
- **Catálogo / Parámetros:** definir claramente la diferencia y los permisos entre ambos.
- **Detalle de Usuario:** Incluir pestaña con el historial académico/laboral del usuario dentro de la plataforma.

---

# Administrador de Soporte

## Funcionalidades incompletas
- **Auditoría:** "Ver payload" funciona, pero la información que muestra está incompleta.
- **Auditoría (`#/backoffice/auditoria`):** Sin API REST expuesta (GAP B1). Muestra logs estáticos. No permite filtrar por dirección IP, usuario ni entidad afectada.
- **Documentos — Lista (`#/backoffice/documentos`):** No implementa firma digital ni tabla de retención documental (TRD) según SIGA.
- **Plantillas de Documento (`#/backoffice/documentos/plantillas`):** No garantiza los formatos oficiales institucionales aprobados por la Oficina de Comunicaciones del SENA.
- **Parametrización / Catálogos (`#/backoffice/parametrizacion`):** Estructura duplicada con la pantalla 35 (Datos de Referencia del Director). Debe unificarse en una sola ruta.

## Errores encontrados
- **Documentos:** ningún botón funciona, incluyendo "Generar documento".
- **Plantillas:** no funciona la vista previa, ni la descarga, ni la edición; ningún botón responde.
- **Plantillas:** al seleccionar una plantilla, el estado se mezcla incorrectamente con el de "Documentos".
- **Auditoría:** el filtro no funciona.
- **Auditoría:** "Cargar más" no funciona.
- **Parametrización (Nueva competencia):** al crearla, el sistema redirige por error a la sección de Programa.

## Campos faltantes y lógica de negocio
- **Auditoría:** Presentación cruda del JSON de la traza de auditoría, poco legible para auditores SIGA. Falta visor estructurado de objetos con resaltado de cambios (*Diff viewer*).
- **Auditoría:** Falta búsqueda por rango de tiempo y nivel de severidad (*INFO, WARN, ERROR*).
- **Detalle de Documento + Versiones (`#/backoffice/documentos/doc-01`):** No diferencia borradores de documentos oficiales publicados. Falta incorporar marcas de agua (*Borrador, Oficial, Anulado*).
- **Modal Generar Documento (`?modal=generate`):** No indica el tiempo estimado de generación ni la cola de procesamiento.
- **Editor/Preview de Plantilla (`#/backoffice/documentos/plantillas/tpl-01/editar`):** Riesgo de seguridad por inyección de código sin sanitización en el editor HTML/Markdown.
- **CRUD Catálogo/Parámetro (`?modal=crud`):** No valida dependencias (ej. eliminar un catálogo en uso por otras tablas). Falta validación de integridad referencial.
- **Editar Catálogo/Parámetro (`?modal=reference`):** No mantiene historial de cambios de versión del parámetro. Falta auditoría de quién modificó y cuándo.

## Mejoras recomendadas
- **Parametrización:** aplicar las mismas correcciones definidas para Parametrización del Director del Centro.
- **Auditoría:** Implementar visor de logs estándar con búsqueda por rango de tiempo y nivel de severidad.
- **Auditoría (Modal Detalle):** Formatear el JSON en un visor estructurado con resaltado de cambios (*Diff viewer*).
- **Documentos:** Integrar metadatos de TRD e integración con el sistema de gestión documental institucional.
- **Plantillas:** Cargar plantillas oficiales estandarizadas del Manual de Imagen Corporativa SENA. Usar un editor WYSIWYG restringido.
- **Detalle de Documento:** Incorporar marcas de agua (*Borrador, Oficial, Anulado*) en la vista previa.
- **Modal Generar Documento:** Mostrar barra de progreso en tiempo real durante la generación de reportes masivos.
- **Parametrización / Catálogos:** Unificar el hub de parametrización en una sola ruta de administración general para evitar duplicidad UX.
- **CRUD Catálogo:** Incluir validación de integridad referencial antes de permitir la desactivación o eliminación.
- **Editar Catálogo:** Registrar auditoría de quién modificó el parámetro y la fecha/hora exacta del cambio.

---

# Parametrización Global (Pantallas 46 – 53)

## Campos faltantes y lógica de negocio
- **Currículo Académico (`#/admin/parametrizacion/curriculo`):** Excelente alineación taxonómica (Línea → Red Tecnológica → Red Conocimiento → Programa → Competencia → RAP), pero falta gestionar la versión del programa de formación. Debe permitir clonar programas para crear nuevas versiones del diseño curricular (*Versionamiento GFPI*).
- **Jornadas / Franjas Horarias (`#/admin/parametrizacion/jornadas`):** No contempla la franja trasnochadora (jornada 24 horas o madrugadas) para centros agropecuarios/industriales. Debe permitir franjas flexibles y nocturnas especiales.
- **Tipos de Ambiente e Inventario (`#/admin/parametrizacion/ambientes`):** No mapea la capacidad de conectividad (ancho de banda) ni características de accesibilidad para aprendices con discapacidad. Falta añadir atributos de *Accesibilidad Reducida / Inclusiva* (RAMPA, Braille) y capacidad de red.
- **Catálogos de Monitoreo (`#/admin/parametrizacion/monitoreo`):** Alertas desconectadas del Comité de Evaluación y Seguimiento al Aprendiz. Debe disparar automáticamente la citación a Comité cuando la alerta alcance el nivel `CRÍTICO`.
- **Estados de Actores (`#/admin/parametrizacion/estados`):** No refleja los estados oficiales del reglamento del aprendiz (*Aplazado, Retirado Voluntario, Sancionado, Cancelado*). Debe reemplazar la lista genérica por la totalidad de estados de matrícula normativos del sistema SOFIAPLUS / SENA (Acuerdo 007/2012).
- **Geografía Institucional (`#/admin/parametrizacion/geografia`):** No contempla subsedes ni aulas móviles (Aulas Bus SENA / Navegantes). Debe incluir tipos de sedes especiales (*Sede Principal, Subsede, Aula Móvil, Convenio Marco*).
- **RBAC — Roles y Permisos (`#/admin/parametrizacion/rbac`):** Falta el rol de *Coordinador de Formación / Bienestar* y *Líder de Investigación (SENNOVA)*. Debe crear roles específicos para Bienestar al Aprendiz, Voceros de Ficha y Gestores SENNOVA.
- **Hub de Parametrización (`#/admin/parametrizacion`):** Buena organización por tarjetas, pero carece de un buscador global de parámetros.

---

# Responsive
- **Coordinador Académico — Horarios (modal "Agregar sesión"):** el formulario se desordena en pantallas pequeñas.
- **Instructor — Mi horario y Disponibilidad:** el detalle de sesión y los cuadros del formulario de disponibilidad quedan mal ubicados.
- **Director del Centro — Parametrización (Currículum académico):** problemas de responsive en los 6 campos del formulario.
- Pendiente revisar de forma sistemática el resto de pantallas con el mismo patrón visual.

---

# Navegación
- **Administrador de Soporte — Parametrización (Nueva competencia):** redirige por error a la sección de Programa en vez de mantenerse en Parametrización.
- **Coordinador Académico — Instructores:** no lleva a un apartado propio; permanece anidado debajo de "Ambientes".
- **Administrador de Soporte — Plantillas:** seleccionar una plantilla altera el estado de "Documentos" en vez de mantenerse independiente.

---

# Notificaciones
- **Aprendiz — Notificaciones:** el detalle es limitado, solo muestra el motivo del cambio.
- Falta una opción para marcar notificaciones como revisadas y guardarlas en un histórico consultable, en vez de que sigan apareciendo como pendientes.

---

# Discrepancias Consolidadas vs. SIGA / MIPG / Normativa SENA

- **Progreso Académico:** Digitación libre y manual de `% Avance Curricular` por el instructor en el seguimiento. El SIGA exige cálculo automático transparente basado en horas ejecutadas y RAPs aprobados en el Juicio Evaluativo. **Impacto Alto:** Inconsistencia entre lo reportado en horarios y el historial académico real en SofiaPlus/ZAJUNA.
- **Novedades Docentes:** Excepciones del instructor se guardan como registro estático sin flujo de aprobación. Procedimiento de continuidad del servicio SIGA exige aprobación por Coordinación y plan de contingencia obligatorio. **Impacto Crítico:** Desprotección de las fichas que se quedan sin clase sin previo aviso ni reprogramación oficial.
- **Planeación Pedagógica:** Las sesiones del horario solo asocian la Competencia. GFPI exige asociar cada sesión a un *Resultado de Aprendizaje (RAP)* y a la *Actividad del Proyecto*. **Impacto Alto:** Pérdida de la trazabilidad pedagógica de la formación profesional integral.
- **Panel del Aprendiz:** Vista limitada en lista de clases sin indicador de progreso ni materiales. Dimensión MIPG Transparencia exige que el aprendiz cuente con acceso integral a su ruta de formación y avance. **Impacto Medio-Alto:** Desorientación del aprendiz respecto al cumplimiento de su programa de formación.
- **Novedades de Matrícula:** Estados de aprendiz genéricos (*En formación, Retirado, Certificado*). Reglamento del Aprendiz (Acuerdo 007/2012) requiere estados normativos (*Aplazamiento, Traslado, Reingreso, Cancelación*). **Impacto Alto:** Imposibilidad de tramitar comités de seguimiento y novedades académicas desde la plataforma.

---

# Recomendaciones de Mejora Arquitectónica y UX/UI

1. **Implementar el Módulo "Mi Ruta de Formación" para el Aprendiz:**
   - Crear una nueva pantalla navegable (`#/aprendiz/mi-ruta`) que muestre un mapa visual tipo árbol o barra de progreso por Fases (*Análisis, Diseño, Desarrollo, Evaluación*), destacando los RAPs logrados, las horas acumuladas y el porcentaje exacto de avance hacia la certificación.
2. **Crear la Bandeja Única de Novedades e Incidencias para Coordinación Académica:**
   - Diseñar un panel centralizado donde el Coordinador apruebe excusas de instructores, asigne remplazos inmediatos y reprograme sesiones afectadas con un solo clic.
3. **Validación Automática en Tiempo Real de Reglas de Negocio:**
   - Restringir la publicación de horarios que tengan cruces de ambiente, exceso de cupo, instructores con excusa aprobada en la franja o sesiones sin RAP asignado.
4. **Sincronización Abierta e Integración:**
   - Permitir la exportación de horarios hacia formatos estándar (`.ics` para Google Calendar / Apple / Outlook) y generar códigos QR de validación en los ambientes de formación para control de asistencia presencial.

---

# Observaciones Generales
- El ícono duplicado ("++") en botones de agregar se repite en Instructor y Director del Centro.
- La falta de opción "Editar" en flujos de creación se repite en más de una sección (Usuarios, Plantillas).
- Los filtros no funcionan de forma consistente en casi todos los roles (Coordinador, Instructor, Director, Administrador de Soporte).

---
*Documento elaborado como insumo de retroalimentación de aprendices para la optimización del Sistema de Gestión de Horarios SENA.*
