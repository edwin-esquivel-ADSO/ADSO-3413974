# A3. Patrones de Diseño GoF Aplicados

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Criterio de Selección (Rúbrica G2 · Criterio 3)

La rúbrica exige incorporar **al menos 2 patrones de diseño GoF distintos** reflejados directamente en el diagrama de clases ([`02-diagrama-clases.svg`](./02-diagrama-clases.svg)), de los cuales **al menos uno debe ser distinto de Singleton**. Para Nuvora se seleccionaron dos patrones de comportamiento y estructura que resuelven problemas reales del centro comercial (ninguno es Singleton):

1. **Patrón Estrategia (*Strategy*)** — Comportamiento
2. **Patrón Fachada (*Facade*)** — Estructural

---

## 2. Resumen Comparativo de Patrones Aplicados

| Patrón GoF | Problema Concreto del Caso Nuvora | Por qué Ese Patrón | Clases e Interfaces que lo Implementan | Mejora en Mantenibilidad y Calidad |
| :--- | :--- | :--- | :--- | :--- |
| **1. Estrategia (*Strategy*)** | En San Pedro Plaza conviven **dos modalidades de promociones** con reglas distintas de validación temporal (`CU-07` vs. extensión `CU-08`): promociones regulares válidas todo el día entre `fechaInicio` y `fechaFin`, y ofertas relámpago restringidas además a días y horas valle específicas (`FranjaHoraria`, ej. martes a jueves de 2:30 p. m. a 5:30 p. m.). Si esa lógica se codifica con múltiples condicionales `if/else` dentro de `Promocion` o del servicio de canje, cada nueva regla comercial (por ejemplo, ofertas exclusivas para fines de semana o festivos) obliga a modificar el núcleo crítico de redención. | Permite encapsular cada algoritmo de validación horaria en su propia clase intercambiable detrás de una única interfaz polimórfica (`IEstrategiaVigencia`), desacoplando **qué** evalúa la vigencia de **cómo** se verifica cada modalidad. | • `IEstrategiaVigencia` *(interfaz común)*<br>• `VigenciaHorarioRegular` *(implementación 1)*<br>• `VigenciaFranjaRelampago` *(implementación 2)*<br>• `Promocion` y `FachadaCanjeMostrador` *(clientes)* | Para añadir en el futuro una regla como *«Oferta de Fin de Semana»* o *«Hora Feliz Nocturna»*, basta con crear una nueva clase que implemente `IEstrategiaVigencia` **sin tocar** `Promocion`, `Cupon` ni `FachadaCanjeMostrador` (principio Abierto/Cerrado y polimorfismo real). |
| **2. Fachada (*Facade*)** | El flujo crítico de canje en mostrador (`CU-10` + `CU-11` + `RF20`) requiere ejecutar **cinco pasos coordinados en menos de 1.5 segundos (`RNF01`)** sin exponer la complejidad al controlador o a la pantalla del cajero: (1) consultar el `Cupon` por código, (2) verificar que el `Cajero` pertenezca al mismo `LocalComercial` de la `Promocion`, (3) delegar la validación horaria a `IEstrategiaVigencia` usando la hora del servidor, (4) marcar el `Cupon` como redimido generando la `Redencion` bajo bloqueo transaccional (`RNF04`), y (5) registrar el evento inmutable en `RegistroAuditoria`. | Provee un punto de entrada único, simple y de alto nivel (`FachadaCanjeMostrador.procesarCanje(...)`) que coordina todas las entidades del subsistema de redención sin que la capa de presentación conozca el orden interno de validaciones ni dependa directamente de múltiples clases de dominio. | • `FachadaCanjeMostrador` *(clase fachada)*<br>• Subsistema coordinado: `Cajero`, `Cupon`, `Promocion`, `IEstrategiaVigencia`, `Redencion`, `RegistroAuditoria` | Reduce drásticamente el acoplamiento de los controladores web con el dominio: si cambia el orden de auditoría o se añade una regla antifraude adicional en caja, el cambio queda contenido dentro de `FachadaCanjeMostrador` sin romper la interfaz de punto de venta. |

---

## 3. Verificación en el Diagrama de Clases (`A2`)

* **Estrategia en [`02-diagrama-clases.svg`](./02-diagrama-clases.svg):** Visible mediante la interfaz `<<interface>> IEstrategiaVigencia`, las dos flechas de realización (`<|..`) desde `VigenciaHorarioRegular` y `VigenciaFranjaRelampago`, y la dependencia desde `Promocion` / `FachadaCanjeMostrador`.
* **Fachada en [`02-diagrama-clases.svg`](./02-diagrama-clases.svg):** Visible mediante `FachadaCanjeMostrador` enlazando por asociación/dependencia dirigida hacia `Cajero`, `Cupon`, `IEstrategiaVigencia`, `Redencion` y `RegistroAuditoria`, centralizando el caso de uso crítico `CU-10`.
