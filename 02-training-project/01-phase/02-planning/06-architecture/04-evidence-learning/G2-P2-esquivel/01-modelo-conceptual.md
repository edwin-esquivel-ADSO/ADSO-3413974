# B1. Modelo Conceptual de Datos (Ajustado para Diseño)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 2:** Modelo de Datos y Verificación (`G2-P2`)  
**Origen reutilizado y ajustado:** [`G1-P2-esquivel/04-modelo-entidad-relacion.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/04-modelo-entidad-relacion.md)

---

## 1. Archivos del Diagrama Conceptual

* **Fuente editable (Draw.io):** [`01-modelo-conceptual.drawio`](./01-modelo-conceptual.drawio)
* **Imagen vectorial exportada (SVG):** [`01-modelo-conceptual.svg`](./01-modelo-conceptual.svg)

---

## 2. Selección y Justificación del Tipo de Base de Datos (Rúbrica G2 · Criterio B1)

Se selecciona una **base de datos relacional (PostgreSQL)** frente a alternativas no relacionales (documentales o clave-valor) por tres condiciones concretas del caso Nuvora:

1. **Integridad transaccional en canjes (`RNF04` y `RN-04`):** Al momento de redimir un cupón QR en mostrador, dos cajeros no pueden consumir el mismo código simultáneamente; un motor relacional ACID garantiza unicidad y bloqueo de fila en tiempo real.
2. **Estructura fija y altamente interconectada (`RF05`–`RF20`):** El negocio gira en torno a entidades bien definidas (`Rol`, `Usuario`, `LocalComercial`, `Categoria`, `Producto`, `Promocion`, `FranjaHoraria`, `Cupon`, `Redencion`, `RegistroAuditoria`) con relaciones obligatorias `1:N`, `N:M` y `1:1` que requieren llaves foráneas estrictas.
3. **Filtros y agregaciones monetarias (`RF07`, `RF19`):** Las consultas de presupuesto (`precio_oferta <= monto`) y estadísticas de conversión por local requieren precisión decimal exacta (`NUMERIC`) y cruces consistentes entre promociones, cupones y redenciones.

---

## 3. Catálogo de Entidades Conceptuales (10 Entidades + 1 Relación N:M)

Con respecto al diagrama previo de Guía 1 (`G1-P2/04-modelo-entidad-relacion.svg`), aquí se muestra el nivel conceptual puro con la relación `N:M` sin resolver aún en tabla intermedia, el verbo de negocio en cada unión y sus cardinalidades mínimas y máximas:

| # | Entidad Conceptual | Identificador | Atributos Conceptuales Clave | Requisitos |
| :---: | :--- | :--- | :--- | :---: |
| **1** | `Rol` | `id` | `nombre`, `descripcion` | `RF02` |
| **2** | `Usuario` | `id` | `nombre_completo`, `correo`, `hash_contrasena`, `sal_contrasena`, `estado_cuenta`, `autoriza_datos`, `fecha_registro` | `RF01`–`RF03`, `RNF02`, `RNF09` |
| **3** | `LocalComercial` | `id` | `nombre_comercial`, `numero_local`, `telefono_contacto`, `horario_atencion`, `logo_url`, `estado_operativo` | `RF04`, `RF05`, `RF08` |
| **4** | `Categoria` | `id` | `nombre_categoria`, `icono`, *(atributos del vínculo N:M: `es_categoria_principal`, `fecha_asignacion`)* | `RF05` |
| **5** | `Producto` | `id` | `nombre_producto`, `descripcion`, `precio_regular`, `foto_url`, `disponible` | `RF06`, `RF07`, `RF08` |
| **6** | `Promocion` | `id` | `titulo_oferta`, `precio_oferta`, `cupo_maximo`, `cupos_usados`, `fecha_inicio`, `fecha_fin`, `estado` | `RF09`, `RF11`, `RF12`, `RF19` |
| **7** | `FranjaHoraria` *(Débil)* | `id` | `dia_semana`, `hora_inicio`, `hora_fin` | `RF10`, `RF17` |
| **8** | `Cupon` | `id` | `codigo_unico`, `fecha_emision`, `fecha_expiracion`, `estado` | `RF13`–`RF15`, `RNF03` |
| **9** | `Redencion` | `id` | `fecha_hora_canje`, `monto_descontado`, `metodo_validacion` | `RF17`, `RF18`, `RNF04` |
| **10** | `RegistroAuditoria` | `id` | `accion`, `detalle`, `ip_origen`, `fecha_registro` | `RF20` |

---

## 4. Cómo Leer Cada Relación en Voz Alta (Verbos y Cardinalidades Mínima/Máxima)

> **Guía rápida:** el primer número es el **mínimo** (`0` opcional, `1` obligatorio) y el segundo es el **máximo** (`1` único, `*` muchos).

| Tipo | Relación (Origen $\rightarrow$ Verbo $\rightarrow$ Destino) | Cardinalidades | Lectura Sencilla del Negocio (Para Explicar) |
| :---: | :--- | :---: | :--- |
| `1:N` | `Rol` $\rightarrow$ **asigna** $\rightarrow$ `Usuario` | `1` a `0..*` | Un **Rol** asigna permisos a **cero o muchos Usuarios**, y cada usuario tiene un único rol. |
| `0..1:N` | `LocalComercial` $\rightarrow$ **agrupa empleados** $\rightarrow$ `Usuario` | `0..1` a `0..*` | Un **Local** agrupa **cero o muchos Usuarios** (locatarios/cajeros); un visitante no pertenece a ningún local (`0..1`). |
| `N:M` | `LocalComercial` $\leftrightarrow$ **pertenece a** $\leftrightarrow$ `Categoria` | `1..*` a `1..*` | Un **Local** pertenece al menos a **una o muchas Categorías**, y una categoría agrupa **uno o muchos Locales** (relación muchos a muchos). |
| `1:N` | `LocalComercial` $\rightarrow$ **ofrece** $\rightarrow$ `Producto` | `1` a `0..*` | Un **Local** ofrece **cero o muchos Productos** en su carta digital. |
| `1:N` | `LocalComercial` $\rightarrow$ **publica** $\rightarrow$ `Promocion` | `1` a `0..*` | Un **Local** publica **cero o muchas Promociones**. |
| `1:N` | `Producto` $\rightarrow$ **respalda** $\rightarrow$ `Promocion` | `1` a `0..*` | Un **Producto** respalda **cero o muchas Promociones** creadas en el tiempo. |
| `1:N` *(Débil)* | `Promocion` $\rightarrow$ **restringe con** $\rightarrow$ `FranjaHoraria` | `1` a `0..*` | Una **Promoción** se restringe con **cero o muchas Franjas Horarias** (entidad débil: no existe sin la promoción). |
| `1:N` | `Promocion` $\rightarrow$ **origina** $\rightarrow$ `Cupon` | `1` a `0..*` | Una **Promoción** origina **cero o muchos Cupones** generados por los clientes. |
| `1:N` | `Usuario` *(Visitante)* $\rightarrow$ **solicita** $\rightarrow$ `Cupon` | `1` a `0..*` | Un **Usuario visitante** solicita **cero o muchos Cupones** en su billetera. |
| `1:1` *(Parcial)* | `Cupon` $\rightarrow$ **culmina en** $\rightarrow$ `Redencion` | `1` a `0..1` | Un **Cupón** culmina en **cero o una sola Redención** (nunca puede redimirse dos veces). |
| `1:N` | `Usuario` *(Cajero)* $\rightarrow$ **ejecuta** $\rightarrow$ `Redencion` | `1` a `0..*` | Un **Cajero** ejecuta **cero o muchas Redenciones** durante su turno. |
| `1:N` | `LocalComercial` $\rightarrow$ **registra** $\rightarrow$ `Redencion` | `1` a `0..*` | Un **Local** registra **cero o muchas Redenciones** aplicadas en sus cajas. |
| `1:N` | `Usuario` $\rightarrow$ **genera** $\rightarrow$ `RegistroAuditoria` | `1` a `0..*` | Un **Usuario** genera **cero o muchos Registros de Auditoría** por sus acciones. |
| `0..1:N` | `Redencion` $\rightarrow$ **documenta** $\rightarrow$ `RegistroAuditoria` | `0..1` a `0..*` | Cada **Redención** documenta uno o varios eventos en `RegistroAuditoria` (y la bitácora también admite eventos sin redención). |
