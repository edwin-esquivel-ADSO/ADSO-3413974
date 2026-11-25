# 01. Diagramas de Actividades de Casos de Uso Críticos

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** Edwin Alejandro Esquivel Bahamón (`edwin-esquivel-ADSO`)  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Diagrama de Actividades 1: `CU-07 · Registrar promoción comercial con cupos`

Este diagrama detalla el proceso mediante el cual el administrador del local configura una promoción comercial, incluyendo la bifurcación condicional para añadir franjas horarias de ofertas relámpago (`CU-08`), la validación de consistencia de negocio y la decisión de guardar como borrador o publicar en catálogo.

* **Fuente editable (Draw.io):** [`01-diagrama-actividad-cu07-promocion.drawio`](./01-diagrama-actividad-cu07-promocion.drawio)
* **Imagen vectorial (SVG):** [`01-diagrama-actividad-cu07-promocion.svg`](./01-diagrama-actividad-cu07-promocion.svg)

### Reglas y Ramas Cubiertas (Coherencia con Plantilla CU-07):
* **Carriles por actor:** `Locatario (Administrador de Local)` y `Sistema Nuvora`.
* **Guardas entre corchetes:** `[Sí]` / `[No]` en oferta relámpago; `[Válido]` / `[No válido]` en validación de negocio; `[Sí / Publicar]` / `[No / Borrador]` en publicación.
* **Nota sobre concurrencia:** Este flujo es ejecutado por un único locatario de forma secuencial en su panel de administración, por lo que no requiere nodos de bifurcación ni unión paralela de procesos.

---

## 2. Diagrama de Actividades 2: `CU-10 · Redimir cupón de descuento en caja`

Este diagrama representa el corazón transaccional de Nuvora: el flujo completo desde que el visitante muestra el QR en mostrador hasta que el cajero valida y entrega el pedido en menos de 1.5 segundos.

* **Fuente editable (Draw.io):** [`01-diagrama-actividad-cu10-redencion.drawio`](./01-diagrama-actividad-cu10-redencion.drawio)
* **Imagen vectorial (SVG):** [`01-diagrama-actividad-cu10-redencion.svg`](./01-diagrama-actividad-cu10-redencion.svg)

### Reglas, Ramas y Concurrencia Cubiertas (Coherencia con Plantilla CU-10):
* **Carriles por actor:** `Visitante`, `Cajero (Mostrador)` y `Sistema Nuvora`.
* **Flujo Alterno:** Si la cámara del mostrador no logra enfocar o leer el QR (`[Falla cámara]`), el cajero ingresa el código alfanumérico manualmente en el campo de respaldo.
* **Excepción:** Si el cupón incumple alguna condición (`[No válido]`: ya fue redimido, expiró la ventana de 2 horas o pertenece a otro local), el sistema libera el bloqueo, muestra la pantalla roja con el motivo exacto y el cajero informa al cliente que el descuento no aplica.
* **Bifurcación y Unión Paralela:** Cuando el cupón supera todas las validaciones (`[Válido y vigente]`), el servidor ejecuta de manera simultánea dentro de la misma operación segura:
  1. **Rama A:** Marcar el cupón como `REDIMIDO` y crear el registro de redención.
  2. **Rama B:** Guardar el registro inmutable en la bitácora de auditoría (cajero, hora exacta y descuento).
  Una vez completadas ambas ramas en la barra de unión, se muestra la pantalla verde de aprobación en caja.