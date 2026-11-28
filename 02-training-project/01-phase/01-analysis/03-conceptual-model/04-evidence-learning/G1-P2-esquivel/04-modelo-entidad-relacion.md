# 04. Modelo Entidad-Relación (MER)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Notación Declarada y Diagrama (Rúbrica G1 · Criterio C4)

* **Notación Declarada:** **Pata de Gallo (Crow's Foot)**.
  * **`||`**: Uno y solo uno (participación total obligatoria).
  * **`|o`**: Cero o uno (participación opcional/parcial).
  * **`|<`**: Uno o muchos (participación total obligatoria).
  * **`o<`**: Cero o muchos (participación opcional/parcial).
* **Glosario de Siglas de la Tabla (Para Explicación Oral):**
  * **`PK` (Llave Primaria):** Es el identificador único e irrepetible de cada fila de la tabla (como el número de cédula de ese dato).
  * **`FK` (Llave Foránea):** Es el campo que conecta una tabla con el `id` de otra tabla para saber a quién pertenece (por ejemplo, `local_id` en `productos` indica de qué local es ese plato).
  * **`UQ` (Valor Único):** Restricción que prohíbe repetir el mismo dato en dos filas (ej. dos usuarios no pueden usar el mismo `correo`, ni dos cupones el mismo `codigo_unico`).
  * **`UUID`:** Es un identificador único largo generado automáticamente para que nadie pueda adivinar códigos o registros en orden (`1, 2, 3...`).
* **Fuente editable (Draw.io):** [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio)
* **Imagen vectorial (SVG):** [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg)

---

## 2. Resolución de Requisitos Estructurales de la Rúbrica

1. **Relación Muchos a Muchos (N:M) resuelta con Entidad Asociativa con Atributos Propios:**  
   Un local comercial (`locales`) puede pertenecer a múltiples categorías (`categorias`) simultáneamente (ej. *Comidas Rápidas* y *Restaurantes*), y una categoría agrupa varios locales. Esta relación N:M se resuelve mediante la entidad asociativa **`locales_categorias`**, que incorpora llave primaria compuesta (`local_id`, `categoria_id`) y dos atributos propios de negocio:
   * `es_categoria_principal` (`BOOLEAN`): indica la categoría principal del establecimiento en el directorio.
   * `fecha_asignacion` (`TIMESTAMP`): registra cuándo fue clasificado el local en dicha categoría.
2. **Entidad Débil:**  
   La entidad **`horarios_promocion`** es una entidad débil con **participación total y dependencia existencial** respecto a `promociones` (`promocion_id NOT NULL`). Si una promoción se elimina, sus franjas horarias pierden todo sentido y dejan de existir.
3. **Soporte Total a los Requisitos de Datos del SRS:**  
   * **Filtro de presupuesto (`RF07`):** Soportado mediante `productos.precio_regular` y `promociones.precio_oferta`.
   * **Control de duplicidad de redención (`RN-04`):** Garantizado por la restricción `UNIQUE` sobre `cupones.codigo_unico` y `redenciones.cupon_id` (relación `1` a `0..1`).
   * **Trazabilidad de auditoría (`RF20`):** Soportada por `auditoria_logs` vinculada a `usuarios` y `redenciones`.

---

## 3. Catálogo de Entidades y Cardinalidades (11 Entidades)

| # | Entidad | Tipo | Llaves (PK / FK) | Cardinalidad y Participación Clave |
| :---: | :--- | :---: | :--- | :--- |
| **1** | `roles` | Fuerte | PK: `id` | `1` rol tiene `0..*` (`o<`) `usuarios` (participación opcional del lado de usuarios). |
| **2** | `usuarios` | Fuerte | PK: `id`, FK: `rol_id`, `local_id` | `1` usuario visitante reclama `0..*` `cupones`; `0..1` local agrupa `0..*` empleados. |
| **3** | `locales` | Fuerte | PK: `id` | `1` local ofrece `0..*` `productos` y publica `0..*` `promociones`. |
| **4** | `categorias` | Fuerte | PK: `id` | `1` categoría agrupa `1..*` registros de `locales_categorias`. |
| **5** | `locales_categorias` | **Asociativa (N:M)** | PK/FK: `local_id`, `categoria_id` | Resuelve la relación N:M entre `locales` y `categorias` con atributos propios. |
| **6** | `productos` | Fuerte | PK: `id`, FK: `local_id` | `1` producto puede estar incluido en `0..*` `promociones`. |
| **7** | `promociones` | Fuerte | PK: `id`, FK: `local_id`, `producto_id` | `1` promoción origina `0..*` `cupones`. |
| **8** | `horarios_promocion` | **Débil** | PK: `id`, FK: `promocion_id` | `1` promoción tiene `0..*` franjas horarias (dependencia existencial total). |
| **9** | `cupones` | Fuerte | PK: `id`, FK: `promocion_id`, `usuario_id` | `1` cupón culmina en `0..1` (`o|`) `redenciones`. |
| **10** | `redenciones` | Fuerte | PK: `id`, FK/UQ: `cupon_id`, FK: `cajero_id`, `local_id` | `1` cajero ejecuta `0..*` `redenciones`. |
| **11** | `auditoria_logs` | Fuerte | PK: `id`, FK: `usuario_id`, `redencion_id` | `0..1` redención genera `0..*` logs de auditoría. |