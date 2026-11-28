# 05. Matriz de Trazabilidad: Requisito Funcional $\rightarrow$ Caso de Uso

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — SENA Regional Huila  
**Proyecto Formativo:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)  
**Autor:** `edwin-esquivel-ADSO` — Líder Técnico, Backend & Base de Datos  
**Equipo de Desarrollo:** Equipo formativo Nuvora (3 integrantes · ADSO Ficha 3413974)  
**Seguimiento Formativo:** Instructora Técnica y Curricular · Instructor de Planificación y Gestión Ágil  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 1:** Plan de Análisis y Casos de Uso (G1-P1)  

---

## 1. Catálogo Formal de Requisitos del Sistema Nuvora

Los requisitos presentados a continuación corresponden a la especificación de requisitos de Nuvora para el Centro Comercial San Pedro Plaza:

### A. Requisitos Funcionales (RF)

#### Módulo 1: Acceso, Usuarios y Seguridad
* **RF01:** El sistema debe permitir el registro de visitantes ingresando nombre completo, correo electrónico válido y contraseña (almacenada de forma segura con cifrado).
* **RF02:** El sistema debe autenticar a los usuarios mediante credenciales válidas, iniciando sesión de manera segura con el rol que le corresponda.
* **RF03:** El sistema debe permitir solicitar el restablecimiento de contraseña mediante un enlace temporal enviado al correo registrado.
* **RF04:** El sistema debe permitir al administrador del local comercial actualizar los datos públicos de su negocio (nombre comercial, número de local, teléfono de contacto, horario y logo).

#### Módulo 2: Directorio Interactivo y Filtro por Presupuesto
* **RF05:** El sistema debe mostrar el listado organizado de comercios de San Pedro Plaza clasificados por categorías (Comidas Rápidas, Cafetería, Calzado, Ropa, etc.).
* **RF06:** El sistema debe permitir al visitante ver el menú o productos de cada local con foto, nombre, descripción y precio regular.
* **RF07:** El sistema debe ofrecer una opción interactiva donde el visitante ingresa cuánto dinero tiene en pesos ($COP) y el sistema le muestra los platos y combos que le alcanzan, ordenados de menor a mayor precio.
* **RF08:** El sistema debe permitir buscar locales y comidas escribiendo palabras clave (por ejemplo: "hamburguesa", "café", "almuerzo").

#### Módulo 3: Creación de Promociones y Horarios (Locatario)
* **RF09:** El sistema debe permitir al dueño del local crear promociones indicando: título de la oferta, producto asociado, precio regular, precio con descuento, fecha de inicio y fecha de finalización.
* **RF10:** El sistema debe permitir al dueño del local asignar días y horas específicas para promociones relámpago en horas valle (por ejemplo: martes a jueves de 2:30 p.m. a 5:30 p.m.).
* **RF11:** El sistema debe permitir al dueño del local cambiar el estado de su promoción entre Borrador, Activa y Pausada, y el sistema la marcará como Vencida cuando pase la fecha límite.
* **RF12:** El sistema debe permitir al dueño del local fijar un límite de cupos disponibles por promoción (por ejemplo: 30 cupones al día), pasando a estado Agotada cuando se alcance el tope.

#### Módulo 4: Generación y Billetera de Cupones QR (Visitante)
* **RF13:** Cuando un visitante registrado solicita una promoción activa, el sistema debe generar un código alfanumérico aleatorio único (por ejemplo: `SPP-7F2A9B`), asociando el usuario, la promoción y la hora de emisión.
* **RF14:** El sistema debe mostrar en la pantalla del celular el código QR del cupón, con un contador de tiempo regresivo visible (máximo 2 horas para redimir).
* **RF15:** El sistema debe ofrecer al visitante una sección personal ("Mis Cupones") organizada en tres pestañas: Activos, Canjeados y Vencidos.

#### Módulo 5: Validación y Canje en Punto de Venta (Cajero)
* **RF16:** El sistema debe proveer al cajero una pantalla sencilla y rápida para celular o computador de caja, con botón para activar la cámara y un teclado numérico de respaldo.
* **RF17:** Al escanear el QR o escribir el código, el sistema debe comprobar en el servidor: que el cupón exista, que pertenezca al local del cajero, que esté en estado Emitido y que esté dentro del horario válido.
* **RF18:** Si el cupón cumple las condiciones, el sistema lo marcará como canjeado de inmediato en la base de datos y mostrará un aviso verde en pantalla con los datos del pedido; en caso contrario, mostrará un aviso rojo indicando el motivo de rechazo.

#### Módulo 6: Métricas Comerciales y Auditoría
* **RF19:** El sistema debe mostrar al dueño del local un panel con el total de vistas, cupones generados, cupones canjeados y porcentaje de efectividad de sus ofertas.
* **RF20:** Toda redención debe guardar un registro inmutable en la base de datos con: código de cupón, cajero que atendió, dirección de red, fecha/hora exacta y valor descontado.

---

### B. Requisitos No Funcionales (RNF — Clasificados bajo Estándar de Calidad ISO/IEC 25010)

Para garantizar una evaluación clara y verificable del software, los requisitos no funcionales se organizan por categoría de calidad y con su criterio numérico de aceptación:

| ID | Atributo de Calidad (ISO/IEC 25010) | Descripción del Requisito No Funcional | Métrica / Criterio de Aceptación |
| :---: | :--- | :--- | :--- |
| **RNF01** | **Eficiencia de Desempeño** | Velocidad de respuesta en la pantalla del cajero al escanear o digitar el código del cupón. | $\le 1.5\text{ segundos}$ en red móvil o Wi-Fi estándar. |
| **RNF02** | **Seguridad (Confidencialidad)** | Almacenamiento de contraseñas cifradas en la base de datos y conexión web protegida mediante protocolo seguro HTTPS. | $100\%$ de contraseñas cifradas (cero texto plano). |
| **RNF03** | **Seguridad (Integridad de Cupones)** | Generación de códigos alfanuméricos aleatorios e irrepetibles para impedir que un usuario adivine cupones ajenos. | Códigos aleatorios únicos con vigencia máxima de $2\text{ horas}$. |
| **RNF04** | **Fiabilidad (Control de Concurrencia)** | Bloqueo del registro del cupón en la base de datos al momento del canje para impedir que el mismo cupón se use dos veces al mismo tiempo. | $0$ redenciones duplicadas ante intentos simultáneos. |
| **RNF05** | **Usabilidad** | Diseño visual adaptado para pantallas de teléfonos celulares comunes, con botones grandes y claros para visitantes y cajeros. | $100\%$ operable en celulares táctiles (botones $\ge 48\text{ px}$). |
| **RNF06** | **Fiabilidad (Disponibilidad)** | Funcionamiento continuo de la plataforma durante el horario de atención del centro comercial San Pedro Plaza. | $\ge 99.0\%$ de disponibilidad entre 8:00 a.m. y 10:00 p.m. |
| **RNF07** | **Mantenibilidad** | Organización del código fuente en capas separadas (interfaz visual, lógica del servidor y base de datos). | $3$ capas desacopladas sin lógica de negocio en la vista. |
| **RNF08** | **Fiabilidad (Tolerancia a Fallos)** | Si falla temporalmente el internet en caja, la pantalla muestra una alerta clara y permite reintentar sin perder la vista. | $100\%$ de recuperación sin recargar la página ni cerrar sesión. |
| **RNF09** | **Cumplimiento Legal** | Tratamiento de nombres y correos de los visitantes cumpliendo la Ley 1581 de 2012 (Habeas Data Colombia) con autorización explícita al registrarse. | $100\%$ de registros con casilla de autorización aceptada. |
| **RNF10** | **Compatibilidad** | Funcionamiento correcto y uniforme en los navegadores web modernos más usados (Chrome, Firefox, Safari y Edge). | $100\%$ de compatibilidad en versiones actuales de los 4 navegadores. |

---

## 2. Matriz de Trazabilidad: Requisito Funcional $\rightarrow$ Caso de Uso (Rúbrica G1 · Criterio C3)

Esta matriz relaciona cada requisito funcional con los casos de uso modelados en el diagrama UML, verificando una cobertura del **100% de los requisitos**:

| ID Requisito | Descripción del Requisito | Caso de Uso UML que lo Atiende | Cobertura | Justificación Técnica de Trazabilidad |
| :---: | :--- | :--- | :---: | :--- |
| **RF01** | Registro de visitantes con contraseña protegida | **CU-01:** Registrar usuario visitante | **100%** | CU-01 captura los datos del usuario, valida el correo y guarda la clave cifrada en la base de datos. |
| **RF02** | Inicio de sesión seguro | **CU-02:** Iniciar sesión en el sistema | **100%** | CU-02 comprueba las credenciales e inicia la sesión según el rol correspondiente. |
| **RF03** | Recuperación de contraseña | **CU-02:** Iniciar sesión en el sistema | **100%** | Gestionado como flujo alternativo de recuperación de acceso dentro del inicio de sesión. |
| **RF04** | Modificación del perfil público del local | **CU-09:** Gestionar perfil de local comercial | **100%** | CU-09 permite al locatario actualizar horarios, teléfono, número de local y logo comercial. |
| **RF05** | Catálogo general de locales y categorías | **CU-03:** Consultar catálogo de locales y productos | **100%** | CU-03 consulta los locales de San Pedro Plaza organizados por tipos de comercio. |
| **RF06** | Menú digital con fotos y precios regulares | **CU-03:** Consultar catálogo de locales y productos | **100%** | CU-03 muestra los platos, combos, descripciones y precios de cada establecimiento. |
| **RF07** | Filtro interactivo por presupuesto monetario | **CU-04:** Filtrar opciones por presupuesto monetario | **100%** | CU-04 extiende a CU-03 buscando las comidas cuyo precio sea menor o igual al dinero ingresado. |
| **RF08** | Búsqueda por texto libre de comidas | **CU-03:** Consultar catálogo de locales y productos | **100%** | CU-03 permite filtrar al instante escribiendo palabras como "hamburguesa" o "combo". |
| **RF09** | Creación de promociones comerciales | **CU-07:** Registrar promoción comercial con cupos | **100%** | CU-07 permite crear ofertas asignando descuento, producto, precio y fechas de inicio y fin. |
| **RF10** | Configuración de franjas de ofertas relámpago | **CU-08:** Parametrizar franja horaria relámpago | **100%** | CU-08 extiende a CU-07 añadiendo días y horas específicas para promociones en horas valle. |
| **RF11** | Control de estados de la promoción | **CU-07:** Registrar promoción comercial con cupos | **100%** | CU-07 permite activar, pausar o dejar en borrador, y el sistema la vence automáticamente al caducar. |
| **RF12** | Límite de cupos de cupones | **CU-07:** Registrar promoción comercial con cupos | **100%** | CU-07 define la cantidad máxima de cupones por día y la pasa a Agotada al completarse el tope. |
| **RF13** | Creación de código aleatorio de cupón | **CU-05:** Generar cupón de descuento QR | **100%** | CU-05 genera el código único asociando al usuario, la promoción y la hora del servidor. |
| **RF14** | Muestra de código QR y reloj regresivo | **CU-05:** Generar cupón de descuento QR | **100%** | CU-05 dibuja el código QR en el celular y muestra el contador de 2 horas para redimir. |
| **RF15** | Billetera digital ("Mis Cupones") | **CU-06:** Gestionar billetera de cupones | **100%** | CU-06 organiza los cupones del usuario en pestañas de Activos, Canjeados y Vencidos. |
| **RF16** | Pantalla de atención rápida para el cajero | **CU-10:** Redimir cupón de descuento en caja | **100%** | CU-10 provee la pantalla con lector de cámara y teclado numérico para digitar el código. |
| **RF17** | Comprobación de validez en el servidor | **CU-10:** Redimir cupón de descuento en caja | **100%** | CU-10 realiza las comprobaciones de validez conectando con el servidor en menos de 1.5 segundos. |
| **RF18** | Canje inmediato y aviso en pantalla | **CU-10:** Redimir cupón de descuento en caja | **100%** | CU-10 actualiza el cupón a canjeado en la base de datos y muestra el aviso verde o rojo. |
| **RF19** | Panel de estadísticas del local | **CU-12:** Consultar analítica de conversión y auditoría | **100%** | CU-12 muestra al locatario cuántas personas vieron su promo, cuántas pidieron cupón y cuántas compraron. |
| **RF20** | Registro inmutable de auditoría | **CU-12:** Consultar analítica de conversión y auditoría | **100%** | CU-12 guarda el registro de cada canje con fecha, cajero, local y descuento otorgado. |

**Cobertura Total:** **20 de 20 Requisitos Funcionales cubiertos (100%)**  
*Mínimo exigido en la rúbrica: $\ge 90\%$.*

---

## 3. Justificación de Relaciones Estructurales UML (Rúbrica G1 · Criterio C4)

Siguiendo las reglas de la rúbrica oficial (Sección 7):

1. **Relación `«include»` (CU-05: Generar cupón de descuento QR $\rightarrow$ CU-02: Iniciar sesión en el sistema):**  
   * *Justificación:* Para poder generar un cupón de descuento es **obligatorio que el usuario haya iniciado sesión**, ya que el sistema necesita vincular el código al usuario registrado y verificar la regla de negocio de máximo 1 cupón por día.
2. **Relación `«include»` (CU-10: Redimir cupón de descuento en caja $\rightarrow$ CU-11: Validar pertenencia de local y vigencia horaria):**  
   * *Justificación:* Ningún cajero puede entregar un pedido con descuento sin que el sistema **compruebe obligatoriamente** que el cupón pertenezca a ese restaurante y que la hora oficial coincida con el horario de la promoción.
3. **Relación `«extend»` (CU-04: Filtrar opciones por presupuesto monetario $\rightarrow$ CU-03: Consultar catálogo de locales y productos):**  
   * *Justificación:* El filtro por presupuesto es una función **opcional** que solo se activa si el visitante decide escribir un monto de dinero para que el sistema le recomiende platos económicos.
4. **Relación `«extend»` (CU-08: Parametrizar franja horaria relámpago $\rightarrow$ CU-07: Registrar promoción comercial con cupos):**  
   * *Justificación:* Asignar horarios especiales es una función **opcional** que solo se usa cuando el dueño del local quiere crear una oferta relámpago para horas valle; las promociones normales de todo el día no la requieren.