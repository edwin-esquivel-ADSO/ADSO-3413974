# A5. Vista de Componentes y Mapeo de Interfaces

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Archivos del Diagrama de Componentes

* **Fuente editable (Draw.io):** [`05-vista-componentes.drawio`](./05-vista-componentes.drawio)
* **Imagen vectorial exportada (SVG):** [`05-vista-componentes.svg`](./05-vista-componentes.svg)

---

## 2. Descomposición Modular (6 Componentes — Rúbrica G2 · Criterio 5)

El sistema se organiza en **6 componentes desacoplados** distribuidos estrictamente entre las 3 capas definidas en [`04-arquitectura-software.md`](./04-arquitectura-software.md). Las interfaces de presentación nunca acceden directamente a `CapaAccesoDatosAuditoria`; toda operación pasa por las interfaces provistas de la Capa de Lógica de Negocio.

| # | Componente | Capa | Interfaz que Provee | Interfaz que Requiere | Clases de `A2` que Agrupa | Requisitos que Atiende |
| :-: | :--- | :--- | :--- | :--- | :--- | :---: |
| **1** | **`AppWebVisitanteLocatario`** | Presentación *(Next.js / React)* | *(Interfaz de usuario Web/Móvil)* | `IAutorizacion`, `ICatalogo`, `IBilleteraCupones`, `IGestionPromociones` | Vistas de directorio, filtro `$COP`, billetera QR y panel comercial | `RF01`–`RF15`, `RF19`, `RNF05`, `RNF10` |
| **2** | **`ValidadorCajaUI`** | Presentación *(Next.js / React)* | *(Interfaz rápida mostrador)* | `IAutorizacion`, `ICanjeMostrador` | Vista de escáner cámara y teclado manual en punto de venta | `RF16`, `RF18`, `RNF01`, `RNF05`, `RNF08` |
| **3** | **`ServicioAutenticacionSeguridad`** | Lógica de Negocio *(Node.js / TS)* | `IAutorizacion`, `IGestionUsuarios` | `IDatosNuvora`, `IAuditoria` | `Usuario`, `Visitante`, `Locatario`, `Cajero` | `RF01`, `RF02`, `RF03`, `RNF02`, `RNF09` |
| **4** | **`ServicioCatalogoPromociones`** | Lógica de Negocio *(Node.js / TS)* | `ICatalogo`, `IGestionPromociones`, `IEstrategiaVigencia` | `IDatosNuvora` | `LocalComercial`, `Categoria`, `Producto`, `Promocion`, `FranjaHoraria`, `IEstrategiaVigencia`, `VigenciaHorarioRegular`, `VigenciaFranjaRelampago` | `RF04`–`RF12`, `RF19`, `RNF07` |
| **5** | **`MotorCuponesCanje`** | Lógica de Negocio *(Node.js / TS)* | `IBilleteraCupones`, `ICanjeMostrador` | `IDatosNuvora`, `IAuditoria`, `IEstrategiaVigencia` | `Cupon`, `Redencion`, `FachadaCanjeMostrador` | `RF13`–`RF18`, `RNF01`, `RNF03`, `RNF04` |
| **6** | **`CapaAccesoDatosAuditoria`** | Persistencia *(PostgreSQL 3FN)* | `IDatosNuvora`, `IAuditoria` | Motor relacional PostgreSQL | `RegistroAuditoria` y repositorios SQL de las 11 tablas (`roles` a `auditoria_logs`) | `RF20`, `RNF04`, `RNF06`, `RNF07` |

---

## 3. Reglas de Dependencia Verificadas

1. **Dirección de dependencias correcta:** Quien consume apunta (`-->`) hacia el componente que provee la interfaz (por ejemplo, `ValidadorCajaUI` depende de `MotorCuponesCanje` mediante `ICanjeMostrador`).
2. **Cero acoplamiento circular:** Las dependencias fluyen siempre en sentido descendente (Presentación $\rightarrow$ Lógica de Negocio $\rightarrow$ Acceso a Datos), excepto el consumo transversal de `IEstrategiaVigencia` entre `MotorCuponesCanje` y `ServicioCatalogoPromociones` sin ciclos mutuos.
3. **Cobertura del 100 % de las 16 clases de `A2`:** Cada clase o interfaz del diagrama de clases pertenece a un único componente bien delimitado.
