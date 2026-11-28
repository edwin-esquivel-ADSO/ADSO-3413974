# A1. Ficha de Interpretación del Análisis y Plataforma Tecnológica

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)  
**Insumo base en el fork:** [`G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md) y [`G1-P2-esquivel/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/08-informe-analisis.md)

---

## 1. Interpretación del Informe de Análisis (Requisitos, Actores y Restricciones)

### 1.1 Requisitos Funcionales Seleccionados para el Diseño (20 de 20 RF del SRS)

Aunque el mínimo exigible de la rúbrica es de 8 requisitos funcionales, este diseño cubre el **100 % de los 20 RF** definidos en la Guía 1 para garantizar trazabilidad completa:

| ID | Módulo | Descripción Corta del Requisito | Caso de Uso Origen (`G1-P1`) | Prioridad de Diseño |
| :---: | :--- | :--- | :--- | :---: |
| **RF01** | Acceso y Seguridad | Registro de visitantes con nombre, correo único y contraseña almacenada de forma segura (`hash y sal`). | `CU-01` | Alta |
| **RF02** | Acceso y Seguridad | Autenticación de usuarios por credenciales y asignación de sesión según su rol (`Visitante`, `Locatario`, `Cajero`, `Administrador`). | `CU-02` | Crítica |
| **RF03** | Acceso y Seguridad | Solicitud de restablecimiento de contraseña mediante enlace temporal enviado al correo registrado. | `CU-02` | Media |
| **RF04** | Acceso y Seguridad | Actualización del perfil público del local comercial (nombre, número de local, teléfono, horario y logo). | `CU-09` | Media |
| **RF05** | Directorio y Presupuesto | Listado organizado de comercios clasificados en una o varias categorías del centro comercial. | `CU-03` | Alta |
| **RF06** | Directorio y Presupuesto | Visualización del menú o catálogo de productos de cada local con foto, descripción y precio regular. | `CU-03` | Alta |
| **RF07** | Directorio y Presupuesto | Filtro interactivo donde el visitante ingresa un presupuesto en `$COP` y ve combos alcanzables ordenados de menor a mayor precio. | `CU-04` | Crítica |
| **RF08** | Directorio y Presupuesto | Búsqueda de locales y productos mediante palabras clave. | `CU-03` | Media |
| **RF09** | Promociones Locatario | Creación de promociones indicando producto, título, precio regular, precio promocional y vigencia de fechas. | `CU-07` | Crítica |
| **RF10** | Promociones Locatario | Parametrización opcional de días y franjas horarias específicas para ofertas relámpago en horas valle. | `CU-08` | Alta |
| **RF11** | Promociones Locatario | Cambio de estado de promoción (`Borrador`, `Activa`, `Pausada`) y vencimiento automático por fecha límite. | `CU-07` | Alta |
| **RF12** | Promociones Locatario | Límite máximo de cupos por promoción, pasando a estado `Agotada` cuando se completa el tope. | `CU-07` | Crítica |
| **RF13** | Billetera y Cupones QR | Generación de código alfanumérico aleatorio único (ej. `SPP-7F2A9B`) asociado a usuario, promoción y reloj del servidor. | `CU-05` | Crítica |
| **RF14** | Billetera y Cupones QR | Despliegue en móvil del código QR del cupón junto con contador regresivo máximo de 2 horas para redimir. | `CU-05` | Alta |
| **RF15** | Billetera y Cupones QR | Billetera personal («Mis Cupones») clasificada en pestañas: `Activos`, `Canjeados` y `Vencidos`. | `CU-06` | Alta |
| **RF16** | Validación en Caja | Pantalla ágil para el cajero con lectura por cámara QR y campo manual alfanumérico de respaldo. | `CU-10` | Crítica |
| **RF17** | Validación en Caja | Comprobación en servidor de existencia, pertenencia al local del cajero, estado `Emitido` y vigencia horaria. | `CU-10`, `CU-11` | Crítica |
| **RF18** | Validación en Caja | Marcación atómica del cupón como `Redimido` e impresión visual verde (aprobado) o roja (motivo exacto de rechazo). | `CU-10` | Crítica |
| **RF19** | Analítica y Auditoría | Panel comercial del locatario con cupones emitidos, redimidos y tasa de conversión de sus promociones. | `CU-12` | Media |
| **RF20** | Analítica y Auditoría | Registro inmutable en auditoría de cada canje con cupón, cajero, dirección de red, fecha exacta y ahorro generado. | `CU-12` | Alta |

### 1.2 Requisitos No Funcionales (10 de 10 RNF del SRS)

| ID | Categoría (ISO/IEC 25010) | Descripción | Métrica Exigible |
| :---: | :--- | :--- | :--- |
| **RNF01** | Eficiencia de Desempeño | Tiempo de respuesta del servidor al validar y redimir un cupón en caja. | $\le 1.5\text{ segundos}$ |
| **RNF02** | Seguridad (Confidencialidad) | Protección de contraseñas con **hash y sal** y cifrado de tráfico web por TLS/HTTPS. | $100\%$ de contraseñas con hash y sal; $100\%$ tráfico TLS |
| **RNF03** | Seguridad (Integridad) | Códigos alfanuméricos aleatorios irrepetibles con vigencia máxima de 2 horas desde emisión. | $0$ códigos secuenciales predecibles |
| **RNF04** | Fiabilidad (Concurrencia) | Control de concurrencia transaccional en base de datos al canjear un cupón en mostrador. | $0$ redenciones duplicadas simultáneas |
| **RNF05** | Usabilidad | Diseño web responsivo móvil con controles táctiles amplios para visitantes y cajeros. | Botones $\ge 48\text{ px}$ en móviles |
| **RNF06** | Fiabilidad (Disponibilidad) | Disponibilidad continua durante el horario comercial de San Pedro Plaza. | $\ge 99.0\%$ de 8:00 a. m. a 10:00 p. m. |
| **RNF07** | Mantenibilidad | Separación estricta de capas (Presentación, Lógica de Negocio, Datos). | $3$ capas sin lógica de negocio en la interfaz |
| **RNF08** | Fiabilidad (Tolerancia a fallos) | Recuperación visual limpia ante cortes breves de red en punto de venta. | Reintento en pantalla sin perder sesión |
| **RNF09** | Cumplimiento Legal | Consentimiento explícito de datos personales (Ley 1581 de 2012 — Habeas Data Colombia). | $100\%$ de usuarios registrados con autorización booleana |
| **RNF10** | Compatibilidad | Ejecución uniforme en Chrome, Firefox, Safari y Edge vigentes. | $100\%$ funcional en los 4 navegadores |

### 1.3 Actores y Restricciones del Caso

* **Actores operativos (heredan de `Usuario`):**
  1. **Visitante:** Consumidor en el centro comercial que consulta el catálogo, filtra por presupuesto, solicita cupones QR y revisa su billetera.
  2. **Locatario:** Administrador autorizado de un local comercial que actualiza el perfil del negocio, publica productos/promociones con franjas horarias y revisa métricas.
  3. **Cajero:** Operador de mostrador asignado a un único local comercial que valida y redime cupones en tiempo real.
* **Actor administrativo y de auditoría (4.º rol en catálogo `roles`):**
  4. **Administrador (`ADMINISTRADOR` / Superadministrador en `G1-P1`):** Gestor del centro comercial encargado de supervisar catálogo, cuentas y bitácora inmutable de auditoría (`CU-12`, `RF20`, matriz de seguridad `G2-P2/B6`).
* **Restricciones del caso:**
  * **Alcance funcional delimitado:** No existen domicilios ni pasarelas de cobro electrónico; el descuento se aplica presencialmente en caja.
  * **Infraestructura acotada:** Equipo formativo de 3 integrantes con presupuesto mínimo; requiere despliegue web ligero sin necesidad de aplicaciones móviles nativas separadas por tienda (iOS/Android).
  * **Integridad horaria:** Todo control de expiración y franjas relámpago depende exclusivamente del reloj oficial del servidor (`RN-05`), nunca del reloj del teléfono del visitante.

---

## 2. Selección y Justificación de Plataforma Tecnológica

| Componente | Tecnología Seleccionada | Justificación Concreta Basada en las Condiciones de Nuvora |
| :--- | :--- | :--- |
| **Lenguaje Orientado a Objetos y Runtime** | **TypeScript** sobre **Node.js** (con **React / Next.js** en presentación) | **1. Orientación a objetos y tipado estricto (`RNF07`):** TypeScript aporta interfaces explícitas (`IEstrategiaVigencia`), clases abstractas (`Usuario`), visibilidad (`private`, `protected`, `public`) y verificación en compilación antes de producción.<br>**2. Ecosistema único cliente-servidor para equipo de 3 (`G1-P1`):** Usar TypeScript tanto en la interfaz móvil/web como en la lógica del servidor reduce la curva de aprendizaje y acelera la entrega dentro del cronograma formativo.<br>**3. Baja latencia en operaciones de entrada/salida (`RNF01`):** El modelo asíncrono de Node.js atiende consultas concurrentes de validación QR en mostrador por debajo de $1.5\text{ segundos}$ sin consumo excesivo de memoria en un servidor pequeño. |
| **Tipo y Motor de Base de Datos** | **Base de Datos Relacional — PostgreSQL** | **1. Transacciones ACID y bloqueo de fila (`RNF04`, `RN-04`):** El canje de un cupón exige `SELECT ... FOR UPDATE` / restricciones `UNIQUE` para impedir que dos cajeros rediman el mismo código simultáneamente.<br>**2. Relaciones estructuradas y fijas (`B1`/`B2`):** El negocio posee 11 entidades fuertemente relacionadas (`locales`, `categorias`, `locales_categorias`, `productos`, `promociones`, `horarios_promocion`, `cupones`, `redenciones`, `auditoria_logs`) que requieren integridad referencial estricta.<br>**3. Consultas con filtros monetarios e integridad (`RF07`, `RF10`):** Las comparaciones sobre `NUMERIC(10,2)` (`precio_oferta <= presupuesto`), llaves compuestas y restricciones `CHECK` garantizan datos consistentes sin depender de código frágil en aplicación. |

---

## 3. Lista de Entregables de Diseño (`G2-P1-esquivel`)

1. **A1 (`01-ficha-interpretacion-plataforma.md`):** Ficha de interpretación del análisis y plataforma tecnológica.
2. **A2 (`02-diagrama-clases.md`, `.drawio` y `.svg`):** Diagrama de clases de diseño orientado a objetos con visibilidad, tipos, métodos, herencia, composición e interfaces polimórficas.
3. **A3 (`03-patrones-diseno.md`):** Especificación de 2 patrones GoF aplicados en el diagrama (`Estrategia` y `Fachada`).
4. **A4 (`04-arquitectura-software.md`, `.drawio` y `.svg`):** Arquitectura en 3 capas, comunicación y decisiones frente a los RNF.
5. **A5 (`05-vista-componentes.md`, `.drawio` y `.svg`):** Vista de componentes con interfaces provistas, requeridas, dependencias y mapeo a clases/requisitos.
6. **A6 (`06-vista-despliegue.md`, `.drawio` y `.svg`):** Vista de despliegue con nodos, artefactos, protocolos/puertos y respaldo a RNF.
7. **A7 (`07-matriz-trazabilidad.md`):** Matriz bidireccional Análisis $\leftrightarrow$ Diseño cubriendo 100 % de los RF y RNF.
