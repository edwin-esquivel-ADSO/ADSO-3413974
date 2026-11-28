# B2. Modelo Lógico Relacional y Cuadro de Reglas de Transformación

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 2:** Modelo de Datos y Verificación (`G2-P2`)

---

## 1. Archivos del Diagrama Lógico Relacional

* **Fuente editable (Draw.io):** [`02-modelo-logico.drawio`](./02-modelo-logico.drawio)
* **Imagen vectorial exportada (SVG):** [`02-modelo-logico.svg`](./02-modelo-logico.svg)

> **Notación del diagrama:** Pata de Gallo (*Crow's Foot*) acompañada de números explícitos en cada extremo (`||` = `1`, `|o` = `0..1`, `o<` = `0..*`). Tanto el archivo `.drawio` como el `.svg` muestran ambos indicadores en cada línea.

---

## 2. Cuadro de Reglas de Transformación Aplicadas (Conceptual B1 $\rightarrow$ Lógico B2)

| # | Regla de Transformación | Aplicación Concreta en el Caso Nuvora | Resultado en el Modelo Lógico Relacional |
| :-: | :--- | :--- | :--- |
| **1** | **Relación Muchos a Muchos (`N:M`) $\rightarrow$ Tabla intermedia** | Un `LocalComercial` puede pertenecer a varias `Categoria` y una `Categoria` agrupa varios locales (`RF05`). Además, la relación trae atributos propios de negocio. | Tabla intermedia **`locales_categorias`** con PK compuesta (`local_id`, `categoria_id`), FK hacia `locales` y `categorias`, más columnas `es_categoria_principal` y `fecha_asignacion`. |
| **2** | **Relación Uno a Muchos (`1:N`) $\rightarrow$ FK en el lado «muchos»** | Un local ofrece múltiples productos y publica múltiples promociones; una promoción origina muchos cupones y puede tener múltiples franjas horarias; un usuario reclama muchos cupones. | `productos.local_id`, `promociones.local_id`, `promociones.producto_id`, `horarios_promocion.promocion_id`, `cupones.promocion_id`, `cupones.usuario_id`, `redenciones.cajero_id`, `redenciones.local_id` y `auditoria_logs.usuario_id`. |
| **3** | **Relación Uno a Uno (`1:1`) $\rightarrow$ FK con restricción `UNIQUE`** | Un cupón emitido culmina en cero o una única redención física en caja (`RN-04`, impedir doble canje). | En **`redenciones`**, la columna `cupon_id` es `FK` hacia `cupones(id)` con restricción **`UNIQUE`**, garantizando a nivel de motor que un cupón solo se canjee una vez. |
| **4** | **Entidad Débil $\rightarrow$ FK obligatoria con borrado en cascada** | `FranjaHoraria` depende existencialmente de `Promocion` (`CU-08`): sin promoción, los horarios carecen de sentido. | Tabla **`horarios_promocion`** con `promocion_id NOT NULL` y regla referencial **`ON DELETE CASCADE`**. |
| **5** | **Generalización (`Usuario` $\rightarrow$ `Visitante`, `Locatario`, `Cajero`) + rol `ADMINISTRADOR` $\rightarrow$ Tabla única con rol** | En `A2` (`G2-P1`), `Usuario` generaliza los tres perfiles operativos transaccionales, compartiendo credenciales (`correo`, `hash_contrasena`, `sal_contrasena`, `estado_cuenta`) junto con el 4.º rol administrativo/auditor (`ADMINISTRADOR`). | Se consolidan en **`usuarios`** vinculada mediante `rol_id` a **`roles`** (`4` roles) y llave foránea opcional `local_id` (`NULL` para Visitante y Administrador, asignada para Locatario y Cajero), evitando fragmentar la autenticación (`RF02`). |
| **6** | **Atributos compuestos o multivaluados potenciales (`0FN` $\rightarrow$ `1FN`)** | Durante el análisis inicial un local podía listarse con etiquetas de categorías separadas por coma y los horarios en un texto plano. | Separados atómicamente en las tablas normalizadas **`locales_categorias`** y **`horarios_promocion`** (detallado en [`03-normalizacion.md`](./03-normalizacion.md)). |

---

## 3. Catálogo de las 11 Tablas y Lectura Explícita de Cardinalidades Lógicas

| # | Tabla | PK | Llaves Foráneas (FK) y Unicidad (`UQ`) | Cómo se Lee la Cardinalidad Lógica (Origen $\leftrightarrow$ Destino) |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `roles` | `id` (`INTEGER`) | `UQ`: `nombre` | **1 a Muchos (`1` $\rightarrow$ `0..*`):** `1` rol tiene `0..*` `usuarios` (`usuarios.rol_id`). |
| **2** | `locales` | `id` (`VARCHAR(36)`) | `UQ`: `numero_local` | **0..1 a Muchos (`0..1` $\rightarrow$ `0..*`):** `0..1` local agrupa `0..*` empleados en `usuarios`; **1 a Muchos (`1` $\rightarrow$ `0..*`)** hacia `productos`, `promociones`, `locales_categorias` y `redenciones`. |
| **3** | `usuarios` | `id` (`VARCHAR(36)`) | `FK`: `rol_id` $\rightarrow$ `roles(id)`, `local_id` $\rightarrow$ `locales(id)`; `UQ`: `correo` | **1 a Muchos (`1` $\rightarrow$ `0..*`):** `1` usuario reclama `0..*` `cupones`, ejecuta `0..*` `redenciones` (si es cajero) y registra `0..*` `auditoria_logs`. |
| **4** | `categorias` | `id` (`INTEGER`) | `UQ`: `nombre_categoria` | **1 a Muchos (`1` $\rightarrow$ `0..*`):** `1` categoría aparece `0..*` veces en la tabla intermedia `locales_categorias`. |
| **5** | `locales_categorias` | `(local_id, categoria_id)` | `FK`: `local_id` $\rightarrow$ `locales(id)`, `categoria_id` $\rightarrow$ `categorias(id)` | **Resuelve N:M:** une `1` local con muchas categorías y `1` categoría con muchos locales mediante PK compuesta. |
| **6** | `productos` | `id` (`VARCHAR(36)`) | `FK`: `local_id` $\rightarrow$ `locales(id)` | **1 a Muchos (`1` $\rightarrow$ `0..*`):** `1` producto puede respaldar `0..*` `promociones`. |
| **7** | `promociones` | `id` (`VARCHAR(36)`) | `FK`: `local_id` $\rightarrow$ `locales(id)`, `producto_id` $\rightarrow$ `productos(id)` | **1 a Muchos (`1` $\rightarrow$ `0..*`):** `1` promoción origina `0..*` `cupones` y contiene `0..*` `horarios_promocion`. |
| **8** | `horarios_promocion` | `id` (`VARCHAR(36)`) | `FK`: `promocion_id` $\rightarrow$ `promociones(id)` (`ON DELETE CASCADE`) | **1 a Muchos Dependiente (`1` $\rightarrow$ `0..*`):** cada fila pertenece obligatoriamente a `1` promoción; si esta se borra, sus horarios desaparecen. |
| **9** | `cupones` | `id` (`VARCHAR(36)`) | `FK`: `promocion_id`, `usuario_id`; `UQ`: `codigo_unico` | **1 a 0..1 (`1` $\rightarrow$ `0..1`):** `1` cupón tiene como máximo `1` redención en `redenciones` (garantizado por `cupon_id UNIQUE`). |
| **10** | `redenciones` | `id` (`VARCHAR(36)`) | `FK + UQ`: `cupon_id` $\rightarrow$ `cupones(id)`; `FK`: `cajero_id`, `local_id` | **Relación 1:1 con `cupones`** (`cupon_id` único) y **0..1 a Muchos (`0..1` $\rightarrow$ `0..*`)** hacia `auditoria_logs`. |
| **11** | `auditoria_logs` | `id` (`VARCHAR(36)`) | `FK`: `usuario_id`, `redencion_id` (`NULL`) | **Muchos a 1 (`0..*` $\rightarrow$ `1`):** registra cada operación atribuida a `1` usuario y opcionalmente (`0..1`) a `1` redención. |
