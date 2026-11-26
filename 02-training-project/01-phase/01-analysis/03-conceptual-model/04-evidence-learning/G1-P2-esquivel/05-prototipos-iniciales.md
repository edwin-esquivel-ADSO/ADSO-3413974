# 05. Prototipos Iniciales de Interfaz de Usuario

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Cobertura de Pantallas Clave (Rúbrica G1 · Criterio C5)

Para dar cumplimiento al criterio C5 (mínimo 3 pantallas rotuladas con su caso de uso, sin pantallas huérfanas), se diseñaron **4 pantallas clave** que cubren los flujos principales de los tres roles operativos de Nuvora (**Visitante**, **Locatario** y **Cajero**).

| Pantalla | Casos de Uso que Atiende | Archivo Visual (SVG) | Descripción Funcional |
| :---: | :--- | :--- | :--- |
| **1** | **CU-03 y CU-04** *(Catálogo y Filtro)* | [`05-mockup-pantalla1-directorio-presupuesto.svg`](./05-mockup-pantalla1-directorio-presupuesto.svg) | Pantalla móvil para el visitante con buscador, filtro de presupuesto en pesos colombianos y listado ordenado por precio. |
| **2** | **CU-05 y CU-06** *(Cupones y Billetera)* | [`05-mockup-pantalla2-billetera-cupon-qr.svg`](./05-mockup-pantalla2-billetera-cupon-qr.svg) | Billetera personal con pestañas (Activos, Canjeados, Vencidos), código QR dinámico, código de respaldo y reloj regresivo de 2 horas. |
| **3** | **CU-07 y CU-08** *(Promoción Locatario)* | [`05-mockup-pantalla3-creacion-promocion.svg`](./05-mockup-pantalla3-creacion-promocion.svg) | Panel web para el administrador del local donde configura descuento, límite de cupos, franjas de oferta relámpago y publicación o borrador. |
| **4** | **CU-10 y CU-11** *(Caja Mostrador)* | [`05-mockup-pantalla4-validador-caja.svg`](./05-mockup-pantalla4-validador-caja.svg) | Interfaz de validación rápida en mostrador con cámara, campo manual de respaldo y respuestas visuales en verde (aprobado) o rojo (motivo de rechazo). |

---

## Pantalla 1 · CU-03 y CU-04 · Directorio y Filtro de Presupuesto

* **Archivo:** [`05-mockup-pantalla1-directorio-presupuesto.svg`](./05-mockup-pantalla1-directorio-presupuesto.svg)
* **Objetivo:** Permitir que un visitante que camina por San Pedro Plaza ingrese su presupuesto disponible (ej. `$18.000 COP`) y encuentre de inmediato qué platos o combos puede comprar sin recorrer toda la plazoleta.

---

## Pantalla 2 · CU-05 y CU-06 · Billetera Digital y Cupón QR

* **Archivo:** [`05-mockup-pantalla2-billetera-cupon-qr.svg`](./05-mockup-pantalla2-billetera-cupon-qr.svg)
* **Objetivo:** Entregar al visitante autenticado su código QR único y un reloj regresivo con el tiempo restante (ventana máxima de 2 horas) para acercarse a reclamar su descuento en caja.

---

## Pantalla 3 · CU-07 · Creación de Promoción Locatario

* **Archivo:** [`05-mockup-pantalla3-creacion-promocion.svg`](./05-mockup-pantalla3-creacion-promocion.svg)
* **Objetivo:** Facilitar al administrador del establecimiento publicar promociones normales o activar la extensión `CU-08` para horarios valle (martes a jueves de 2:30 p. m. a 5:30 p. m.) con límite diario de cupos.

---

## Pantalla 4 · CU-10 · Validador de Caja Cajero

* **Archivo:** [`05-mockup-pantalla4-validador-caja.svg`](./05-mockup-pantalla4-validador-caja.svg)
* **Objetivo:** Garantizar que el cajero pueda validar el descuento en menos de 1.5 segundos (con cámara o código manual si falla la lectura) recibiendo confirmación visual inequívoca en pantalla verde o rechazo detallado en pantalla roja.