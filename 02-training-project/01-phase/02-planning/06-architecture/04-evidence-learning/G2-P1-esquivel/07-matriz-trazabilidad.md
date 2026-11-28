# A7. Matriz Bidireccional de Trazabilidad (Análisis $\leftrightarrow$ Diseño)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Trazabilidad Hacia Adelante: 20 de 20 Requisitos Funcionales (100 % Cobertura)

| ID | Requisito Funcional (`G1-P1`) | Clase(s) de Diseño (`A2`) | Tabla(s) de Datos (`B2`) | Componente(s) (`A5`) | Decisión / Patrón Aplicado |
| :-: | :--- | :--- | :--- | :--- | :--- |
| **RF01** | Registro de visitantes y autorización | `Usuario`, `Visitante` | `roles`, `usuarios` | `ServicioAutenticacionSeguridad`, `AppWebVisitanteLocatario` | Herencia `Usuario`; **hash y sal** + campo `autoriza_datos` |
| **RF02** | Autenticación segura por rol | `Usuario`, `Visitante`, `Locatario`, `Cajero` *(y rol `ADMINISTRADOR`)* | `roles`, `usuarios` | `ServicioAutenticacionSeguridad` | Control `RBAC` en capa lógica + tabla `roles` (`4` roles) con `rol_id` |
| **RF03** | Restablecimiento de contraseña | `Usuario` | `usuarios`, `auditoria_logs` | `ServicioAutenticacionSeguridad` | Validación en servidor y traza en auditoría |
| **RF04** | Gestión de perfil del local | `Locatario`, `LocalComercial` | `locales` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Verificación de pertenencia `Locatario.localId` |
| **RF05** | Directorio por categorías | `LocalComercial`, `Categoria` | `locales`, `categorias`, `locales_categorias` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Relación `N:M` normalizada con `es_categoria_principal` |
| **RF06** | Menú digital con precios | `LocalComercial`, `Producto` | `locales`, `productos` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Separación en 3 capas (`ICatalogo`) |
| **RF07** | Filtro interactivo por presupuesto `$COP` | `Producto`, `Promocion` | `productos`, `promociones` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Índice B-Tree sobre `productos.precio_regular` (`NUMERIC`) |
| **RF08** | Búsqueda por palabra clave | `LocalComercial`, `Producto` | `locales`, `productos` | `ServicioCatalogoPromociones` | Consultas SQL parametrizadas sin saltos de capa |
| **RF09** | Creación de promociones comerciales | `Locatario`, `Producto`, `Promocion` | `promociones`, `productos`, `locales` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Restricciones `CHECK (precio_oferta > 0)` y fechas válidas |
| **RF10** | Franjas horarias relámpago (`CU-08`) | `Promocion`, `FranjaHoraria`, `IEstrategiaVigencia`, `VigenciaFranjaRelampago` | `promociones`, `horarios_promocion` | `ServicioCatalogoPromociones` | **Patrón Estrategia** (`IEstrategiaVigencia`) + composición (`ON DELETE CASCADE`) |
| **RF11** | Estados de promoción (`Borrador`, `Activa`, etc.) | `Promocion`, `VigenciaHorarioRegular` | `promociones` | `ServicioCatalogoPromociones` | `CHECK` de estados permitidos + reloj del servidor |
| **RF12** | Límite diario de cupos | `Promocion`, `Cupon` | `promociones`, `cupones` | `ServicioCatalogoPromociones`, `MotorCuponesCanje` | `CHECK (cupos_usados <= cupo_maximo)` atómico |
| **RF13** | Generación de código único de cupón | `Visitante`, `Promocion`, `Cupon` | `cupones`, `promociones`, `usuarios` | `MotorCuponesCanje`, `AppWebVisitanteLocatario` | Índice único `UNIQUE (codigo_unico)` aleatorio |
| **RF14** | Despliegue QR y temporizador de 2 horas | `Cupon` | `cupones` | `MotorCuponesCanje`, `AppWebVisitanteLocatario` | `CHECK (fecha_expiracion > fecha_emision)` |
| **RF15** | Billetera personal de cupones | `Visitante`, `Cupon` | `cupones`, `usuarios` | `MotorCuponesCanje`, `AppWebVisitanteLocatario` | Interfaz `IBilleteraCupones` filtrada por `usuario_id` |
| **RF16** | Pantalla ágil en caja (cámara + manual) | `Cajero`, `FachadaCanjeMostrador` | `usuarios` | `ValidadorCajaUI`, `MotorCuponesCanje` | **Patrón Fachada** (`ICanjeMostrador`) + `metodo_validacion` |
| **RF17** | Validación de local, estado y vigencia (`CU-11`) | `FachadaCanjeMostrador`, `Cajero`, `Cupon`, `Promocion`, `IEstrategiaVigencia` | `cupones`, `promociones`, `horarios_promocion`, `locales` | `MotorCuponesCanje`, `ServicioCatalogoPromociones` | **Fachada + Estrategia** contra reloj oficial del servidor |
| **RF18** | Marcación atómica de canje y aviso verde/rojo | `FachadaCanjeMostrador`, `Cupon`, `Redencion` | `cupones`, `redenciones` | `MotorCuponesCanje`, `ValidadorCajaUI` | Bloqueo `SELECT FOR UPDATE` + `redenciones.cupon_id UNIQUE` (`1:1`) |
| **RF19** | Analítica de conversión para locatario | `Locatario`, `Promocion`, `Cupon`, `Redencion` | `promociones`, `cupones`, `redenciones` | `ServicioCatalogoPromociones`, `AppWebVisitanteLocatario` | Consulta de solo lectura vía `ICatalogo` por `local_id` (sin reportes en entidades) |
| **RF20** | Registro inmutable de auditoría | `FachadaCanjeMostrador`, `Cajero`, `Redencion`, `RegistroAuditoria` | `redenciones`, `auditoria_logs`, `usuarios` | `MotorCuponesCanje`, `CapaAccesoDatosAuditoria` | Tabla `auditoria_logs` de solo inserción (`INSERT`) |

---

## 2. Trazabilidad de Requisitos No Funcionales (10 de 10 RNF)

| ID | Atributo (ISO/IEC 25010) | Componente(s) / Nodo(s) | Decisión de Arquitectura y Datos |
| :-: | :--- | :--- | :--- |
| **RNF01** | Desempeño ($\le 1.5\text{ s}$) | `ValidadorCajaUI`, `MotorCuponesCanje`, Nodo Aplicación | `FachadaCanjeMostrador` en 1 transacción + índices en `cupones(codigo_unico)` |
| **RNF02** | Seguridad (`hash y sal` + TLS) | `ServicioAutenticacionSeguridad`, Nodos Cliente/App/BD | Contraseñas con **hash y sal**, tráfico `HTTPS :443` y `TCP/TLS :5432` |
| **RNF03** | Integridad de cupones | `MotorCuponesCanje` (`Cupon`) | Código aleatorio `UNIQUE` con vencimiento estricto de 2 horas |
| **RNF04** | Fiabilidad (concurrencia) | `MotorCuponesCanje`, `CapaAccesoDatosAuditoria`, Nodo Datos | `SELECT ... FOR UPDATE` + `redenciones.cupon_id UNIQUE` (`0` dobles canjes) |
| **RNF05** | Usabilidad móvil | `AppWebVisitanteLocatario`, `ValidadorCajaUI` | Web responsiva Next.js con controles táctiles $\ge 48\text{ px}$ |
| **RNF06** | Disponibilidad ($\ge 99.0\%$) | Nodo Aplicación, Nodo Datos, Nodo Respaldo | Pool persistente + respaldo diario cifrado (`SFTP :22`) y prueba de restauración |
| **RNF07** | Mantenibilidad (3 capas) | Los 6 componentes de `A5` | 3 capas sin saltos + **Patrón Estrategia** (`IEstrategiaVigencia`) + **Fachada** |
| **RNF08** | Tolerancia a fallos | `ValidadorCajaUI`, `MotorCuponesCanje` | Manejo controlado de reintentos HTTP sin perder sesión del cajero |
| **RNF09** | Cumplimiento legal (Ley 1581) | `ServicioAutenticacionSeguridad` (`Visitante`) | Columna booleana obligatoria `usuarios.autoriza_datos NOT NULL` |
| **RNF10** | Compatibilidad navegadores | `AppWebVisitanteLocatario`, `ValidadorCajaUI` | Estándares HTML5/React responsivos compatibles en Chrome, Firefox, Safari y Edge |

---

## 3. Verificación Hacia Atrás (Cero Clases ni Tablas Huérfanas)

* **16 de 16 clases e interfaces de `A2` verificadas:** `Usuario` (`RF01`–`RF03`), `Visitante` (`RF01`, `RF13`, `RF15`), `Cajero` (`RF16`–`RF18`, `RF20`), `Locatario` (`RF04`, `RF09`–`RF12`, `RF19`), `LocalComercial` (`RF04`, `RF05`, `RF08`), `Categoria` (`RF05`), `Producto` (`RF06`–`RF09`), `Promocion` (`RF09`–`RF13`, `RF19`), `FranjaHoraria` (`RF10`, `RF17`), `Cupon` (`RF12`–`RF18`), `Redencion` (`RF18`–`RF20`), `RegistroAuditoria` (`RF20`), `IEstrategiaVigencia` (`RF10`, `RF17`), `VigenciaHorarioRegular` (`RF11`), `VigenciaFranjaRelampago` (`RF10`) y `FachadaCanjeMostrador` (`RF16`–`RF20`). **Ninguna clase queda sin requisito.**
* **11 de 11 tablas de `B2` verificadas:** `roles` (`RF01`–`RF02`), `usuarios` (`RF01`–`RF03`, `RF13`, `RF15`, `RF20`), `locales` (`RF04`–`RF05`, `RF09`, `RF17`), `categorias` (`RF05`), `locales_categorias` (`RF05`), `productos` (`RF06`–`RF09`), `promociones` (`RF09`–`RF13`, `RF19`), `horarios_promocion` (`RF10`, `RF17`), `cupones` (`RF12`–`RF18`), `redenciones` (`RF18`–`RF20`) y `auditoria_logs` (`RF03`, `RF20`). **Ninguna tabla queda sin requisito.**
