# 02. Plantillas Extendidas de Casos de Uso Críticos (Anexo A)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** Edwin Alejandro Esquivel Bahamón (`edwin-esquivel-ADSO`)  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

> *Nota de modelado conceptual:* Conforme a la Sección 7 de `Rubricas_G1.md`, las plantillas describen exclusivamente las intenciones del negocio y las interacciones actor-sistema, sin incluir nombres de tablas, sentencias de base de datos ni detalles tecnológicos de implementación.

---

## Plantilla 1 · `CU-05 · Generar cupón de descuento QR`

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | **CU-05 · Generar cupón de descuento QR** |
| **Requisitos que atiende** | RF13, RF14 |
| **Actor primario / secundarios** | Primario: Visitante / Secundarios: Ninguno |
| **Objetivo del actor** | Obtener un código de descuento único y temporal en su celular para presentarlo y hacerlo efectivo en la caja del local comercial. |
| **Precondiciones** | • El visitante ha iniciado sesión previamente en el sistema (`CU-02`).<br>• El visitante visualiza una promoción comercial en estado Activa dentro del catálogo de San Pedro Plaza. |
| **Disparador** | El visitante presiona la opción *«Obtener Cupón de Descuento»* sobre una promoción activa. |
| **Flujo principal** | 1. El visitante selecciona la promoción de su interés y solicita generar su cupón.<br>2. El sistema comprueba que la promoción esté Activa, dentro de su fecha y franja horaria vigente, y que aún tenga cupos disponibles.<br>3. El sistema verifica que el visitante no tenga ya un cupón activo emitido para esa misma promoción en las últimas 24 horas.<br>4. El sistema calcula la fecha de vencimiento aplicando el tiempo de gracia máximo de 2 horas (sin superar la fecha fin de la promoción).<br>5. El sistema genera un código alfanumérico aleatorio único en estado Emitido y lo asocia a la cuenta del visitante y a la promoción.<br>6. El sistema descuenta una unidad de los cupos disponibles de la promoción.<br>7. El sistema muestra en la pantalla del visitante el código QR, el código alfanumérico de respaldo y el reloj en cuenta regresiva. |
| **Flujos alternos** | **6a. Se alcanza el último cupo disponible:** Si el cupón emitido corresponde al último cupo configurado por el local, el sistema entrega el cupón al visitante y cambia el estado de la promoción a Agotada para futuros visitantes. |
| **Excepciones** | **2a. Promoción fuera de horario o expirada:** Si el reloj oficial indica que la promoción venció o está fuera de su franja horaria relámpago, el sistema rechaza la solicitud e informa el próximo horario disponible.<br>**2b. Cupos agotados:** Si no quedan cupos disponibles, el sistema informa que la oferta se agotó y sugiere otras opciones dentro del mismo presupuesto.<br>**3a. Límite diario por visitante superado (RN-01):** Si el visitante ya reclamó un cupón de esa misma promoción en las últimas 24 horas, el sistema impide emitir uno nuevo y lo redirige a su billetera personal (`CU-06`). |
| **Postcondiciones** | El cupón queda registrado en estado Emitido asociado al visitante, visible en su billetera digital con su temporizador de 2 horas activo. |
| **Reglas de negocio** | RN-01 (Límite de 1 cupón por promoción cada 24 horas), RN-02 (Vigencia de 2 horas de gracia), RN-05 (Validación de horario con el reloj del servidor). |
| **Pantalla del prototipo** | [`05-prototipos-iniciales.md · Pantalla 2: Billetera y Cupón QR`](./05-prototipos-iniciales.md#pantalla-2--cu-05-y-cu-06--billetera-digital-y-cup%C3%B3n-qr) |

---

## Plantilla 2 · `CU-07 · Registrar promoción comercial con cupos`

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | **CU-07 · Registrar promoción comercial con cupos** |
| **Requisitos que atiende** | RF09, RF10, RF11, RF12 |
| **Actor primario / secundarios** | Primario: Locatario / Secundarios: Ninguno |
| **Objetivo del actor** | Crear y publicar una oferta comercial con límite de cupos y opcionalmente con franjas horarias específicas para atraer compradores en horas de baja afluencia. |
| **Precondiciones** | • El locatario ha iniciado sesión con su cuenta autorizada de administrador de local.<br>• El local comercial ya tiene registrado al menos un producto o combo en su carta digital. |
| **Disparador** | El locatario selecciona la opción *«Nueva Promoción»* en su panel administrativo. |
| **Flujo principal** | 1. El locatario selecciona el producto o combo de su carta que desea poner en oferta.<br>2. El locatario ingresa el título de la promoción, el precio promocional, el límite máximo de cupos y las fechas de inicio y fin.<br>3. El sistema consulta si la promoción tendrá franjas horarias especiales (oferta relámpago).<br>4. El locatario elige configurar oferta relámpago e indica los días de la semana y horas válidas (extensión `CU-08`).<br>5. El locatario confirma el envío eligiendo publicar la promoción de inmediato.<br>6. El sistema valida que el precio promocional sea menor al precio regular, que la fecha final sea posterior a la inicial y que el cupo sea mayor a cero.<br>7. El sistema registra la promoción en estado Activa junto con sus franjas horarias y la hace visible de inmediato en el directorio de San Pedro Plaza. |
| **Flujos alternos** | **4a. Promoción de horario general (sin oferta relámpago):** Si el locatario decide no activar franjas horarias, la promoción queda habilitada durante todo el horario regular de atención del local entre las fechas elegidas.<br>**5a. Guardar como borrador sin publicar:** Si el locatario elige guardar sin publicar todavía, el sistema almacena la promoción y sus horarios en estado Borrador sin mostrarla aún a los visitantes. |
| **Excepciones** | **6a. Datos inválidos o incoherentes:** Si el precio de oferta es mayor o igual al precio regular, el cupo es cero o negativo, o la fecha de finalización es anterior a la de inicio, el sistema detiene el guardado, resalta los campos erróneos y solicita corregirlos antes de continuar. |
| **Postcondiciones** | La promoción queda guardada en estado Activa (visible al público) o Borrador (oculta en edición) con su límite de cupos y horarios asociados. |
| **Reglas de negocio** | RN-03 (Respeto a cupones emitidos si luego se pausa la promoción), RN-05 (Validación horaria contra servidor). |
| **Pantalla del prototipo** | [`05-prototipos-iniciales.md · Pantalla 3: Gestión de Promoción Locatario`](./05-prototipos-iniciales.md#pantalla-3--cu-07--creaci%C3%B3n-de-promoci%C3%B3n-locatario) |

---

## Plantilla 3 · `CU-10 · Redimir cupón de descuento en caja`

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | **CU-10 · Redimir cupón de descuento en caja** |
| **Requisitos que atiende** | RF16, RF17, RF18 |
| **Actor primario / secundarios** | Primario: Cajero / Secundarios: Visitante |
| **Objetivo del actor** | Verificar en mostrador la autenticidad de un cupón digital presentado por un cliente y marcarlo como utilizado para aplicar el descuento al momento del cobro físico. |
| **Precondiciones** | • El cajero ha iniciado sesión en la pantalla operativa de punto de venta asignada a su local comercial.<br>• El visitante se presenta en la caja física del local con un cupón digital en su celular. |
| **Disparador** | El visitante muestra su código QR en mostrador y el cajero abre el validador de caja. |
| **Flujo principal** | 1. El cajero activa la cámara desde su interfaz de caja y escanea el código QR mostrado por el visitante.<br>2. El sistema bloquea temporalmente el cupón para evitar que sea procesado en dos cajas al mismo tiempo.<br>3. El sistema ejecuta la validación obligatoria de pertenencia y vigencia (`CU-11`): comprueba que el cupón exista, pertenezca al mismo local del cajero, esté en estado Emitido y esté dentro de la fecha y franja horaria oficial.<br>4. El sistema confirma que todas las comprobaciones son exitosas.<br>5. De forma simultánea, el sistema actualiza el cupón a estado Redimido generando el registro de redención y guarda el evento inmutable en la bitácora de auditoría con los datos del cajero, fecha exacta y monto descontado.<br>6. El sistema muestra un aviso grande en color verde indicando el nombre del visitante, el combo a entregar y el valor final con descuento.<br>7. El cajero aplica el descuento, realiza el cobro físico en caja y entrega el pedido al visitante. |
| **Flujos alternos** | **1a. Falla en la lectura de cámara (ingreso manual):** Si la cámara no logra enfocar o leer el código QR en la pantalla del visitante, el cajero digita manualmente el código alfanumérico visible debajo del QR en el campo numérico de respaldo y continúa en el paso 2. |
| **Excepciones** | **4a. Cupón inválido, expirado, ya redimido o de otro local:** Si alguna comprobación falla, el sistema libera el bloqueo sin modificar el estado del cupón, despliega un aviso rojo con el motivo exacto (*«Ya utilizado»*, *«Cupón expirado»* o *«No corresponde a este local»*) y el cajero informa al visitante que el descuento no puede aplicarse. |
| **Postcondiciones** | El cupón pasa definitivamente a estado Redimido (sin posibilidad de segundo uso) y queda registrada la redención y su traza en la bitácora de auditoría del local. |
| **Reglas de negocio** | RN-04 (Unicidad y bloqueo preventivo de doble redención), RN-05 (Hora oficial del servidor), RN-07 (Pertenencia estricta al local del cajero). |
| **Pantalla del prototipo** | [`05-prototipos-iniciales.md · Pantalla 4: Validador de Caja`](./05-prototipos-iniciales.md#pantalla-4--cu-10--validador-de-caja-cajero) |