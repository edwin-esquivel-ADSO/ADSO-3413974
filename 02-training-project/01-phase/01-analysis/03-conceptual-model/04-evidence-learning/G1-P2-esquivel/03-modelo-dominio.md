# 03. Modelo de Dominio Conceptual

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** Edwin Alejandro Esquivel Bahamón (`edwin-esquivel-ADSO`)  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Enfoque del Modelo de Dominio (Rúbrica G1 · Criterio C3)

Conforme a las reglas de arbitraje de la guía (Sección 7.5), este modelo representa exclusivamente los **conceptos del negocio** del ecosistema Nuvora, utilizando atributos propios del dominio del centro comercial, **sin métodos de programación, sin llaves técnicas ni tipos de datos SQL**.

* **Fuente editable (Draw.io):** [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio)
* **Imagen vectorial (SVG):** [`03-modelo-dominio.svg`](./03-modelo-dominio.svg)

---

## 2. Catálogo de Clases Conceptuales (11 Clases del Negocio)

| # | Clase Conceptual | Rol en el Negocio Nuvora | Atributos de Negocio Representados |
| :---: | :--- | :--- | :--- |
| **1** | **`Usuario`** *(Superclase)* | Concepto general de persona autenticada en la plataforma. | `nombreCompleto`, `correoElectronico`, `estadoCuenta` |
| **2** | **`Visitante`** *(Hereda de Usuario)* | Consumidor final en San Pedro Plaza que consulta ofertas y reclama cupones. | `fechaRegistro`, `autorizaTratamientoDatos` |
| **3** | **`Locatario`** *(Hereda de Usuario)* | Administrador responsable de gestionar el perfil, carta y ofertas de su local. | `cargoEnLocal`, `telefonoContacto` |
| **4** | **`Cajero`** *(Hereda de Usuario)* | Operador en punto de venta encargado de validar y canjear cupones en caja. | `turnoOperacion`, `cajaAsignada` |
| **5** | **`LocalComercial`** | Establecimiento físico ubicado en el centro comercial San Pedro Plaza. | `nombreComercial`, `numeroLocal`, `horarioAtencion`, `estadoOperativo` |
| **6** | **`Categoria`** | Clasificación temática de los comercios (Comidas Rápidas, Heladería, etc.). | `nombreCategoria`, `iconoRepresentativo` |
| **7** | **`Producto`** | Plato, combo o artículo ofertado por un local con su precio base de carta. | `nombreProducto`, `descripcion`, `precioRegular` |
| **8** | **`Promocion`** | Campaña de descuento creada por el local sobre un producto con límite de cupos. | `tituloOferta`, `precioPromocional`, `cupoMaximo`, `fechaInicio`, `fechaFin`, `estadoPromocion` |
| **9** | **`FranjaHoraria`** *(Composición)* | Restricción opcional de días y horas para ofertas relámpago de horas valle. | `diaSemana`, `horaInicio`, `horaFin` |
| **10** | **`Cupon`** | Derecho temporal e irrepetible reclamado por un visitante para obtener descuento. | `codigoAlfanumerico`, `fechaEmision`, `fechaExpiracion`, `estadoCupon` |
| **11** | **`Redencion`** | Acto presencial de aplicar el cupón en el mostrador del local comercial. | `fechaHoraCanje`, `montoDescontado`, `metodoValidacion` |
| **12** | **`RegistroAuditoria`** | Evidencia histórica e inmutable de cada operación de canje realizada. | `accionRealizada`, `detalleOperacion`, `fechaHoraRegistro` |

---

## 3. Relaciones Clave, Generalización y Multiplicidades

1. **Generalización (Herencia):** `Visitante`, `Locatario` y `Cajero` heredan de la clase conceptual `Usuario` sus atributos comunes de identificación y acceso.
2. **Composición (`Promocion` $\blacklozenge$--- `FranjaHoraria`):** Una `Promocion` (`1`) puede estar restringida por cero o varias `FranjaHoraria` (`0..*`). Las franjas no tienen sentido de negocio fuera de la promoción que las contiene.
3. **Asociación Muchos a Muchos (`LocalComercial` `1..*` --- `1..*` `Categoria`):** Un local comercial pertenece al menos a una categoría y puede figurar en varias (ej. *Comidas Rápidas* y *Parrilla*).
4. **Ciclo del Cupón:** Un `Visitante` (`1`) reclama cero o muchos `Cupon` (`0..*`) originados por una `Promocion` (`1`). Cada `Cupon` (`1`) culmina en cero o una `Redencion` (`0..1`), la cual es ejecutada por un `Cajero` (`1`) y deja traza obligatoria en `RegistroAuditoria` (`1..*`).