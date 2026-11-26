# 06. Lista de Chequeo de Validación del Análisis (Anexo B)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Propósito de la Verificación (Rúbrica G1 · Criterio C6)

Se aplicaron **18 criterios verificables** (superando el mínimo de 15 exigidos e incluyendo 5 criterios de cobertura y trazabilidad) sobre los artefactos de análisis del Producto 1 (`G1-P1-esquivel`) y Producto 2 (`G1-P2-esquivel`).  
La tabla registra el resultado inicial de la primera inspección (donde se detectaron **6 hallazgos de mejora**) y el estado definitivo tras aplicar los ajustes en la **segunda verificación**.

---

## 2. Lista de Chequeo Diligenciada (Primera y Segunda Verificación)

| # | Criterio verificable (responde sí o no) | Artefacto | 1ra Verif. | 2da Verif. | Evidencia (enlace o cita) | Hallazgo / Resultado |
| :-: | :--- | :--- | :---: | :---: | :--- | :--- |
| **1** | **Cobertura:** Cada uno de los 20 requisitos funcionales del proyecto aparece mapeado en al menos un caso de uso | Matriz G1-P1 | Sí | **Sí** | [`G1-P1 · 05-matriz-requisito-caso-de-uso.md`](../G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md) | 20 de 20 RFs cubiertos (100%). |
| **2** | **Cobertura:** Los casos de uso críticos (`CU-05`, `CU-07`, `CU-10`) tienen plantilla extendida completa con flujo alterno y excepción | Plantillas | Sí | **Sí** | [`02-plantillas-extendidas-casos-uso.md`](./02-plantillas-extendidas-casos-uso.md) | 3 plantillas diligenciadas con 7 pasos c/u. |
| **3** | **Trazabilidad:** Todo concepto de negocio usado en las plantillas extendidas existe en el modelo de dominio | Dominio | Sí | **Sí** | [`03-modelo-dominio.md`](./03-modelo-dominio.md) | 12 clases conceptuales cubren cada actor, producto, promoción, cupón y redención. |
| **4** | **Trazabilidad:** Cada rama alterna y de excepción de los diagramas de actividades aparece en la plantilla del mismo caso | Actividades y Plantillas | **No** | **Sí** | [`01-diagramas-actividades.md`](./01-diagramas-actividades.md) y [`02-plantillas-extendidas-casos-uso.md`](./02-plantillas-extendidas-casos-uso.md) | **Hallazgo 6:** Faltaban etiquetas en las barras paralelas de `CU-10` y ajuste de enlace a `Pantalla 4`. Corregido en 2da verificación. |
| **5** | **Trazabilidad:** Toda pantalla del prototipo está rotulada explícitamente con el caso de uso que atiende | Prototipos | Sí | **Sí** | [`05-prototipos-iniciales.md`](./05-prototipos-iniciales.md) | 4 pantallas rotuladas (`CU-03/04`, `CU-05/06`, `CU-07/08`, `CU-10/11`). |
| **6** | **Cobertura:** Al menos el 90% de los requisitos funcionales están trazados hasta clase de dominio, entidad del MER y pantalla crítica | Matriz Anexo C | Sí | **Sí** | [`09-matriz-trazabilidad.md`](./09-matriz-trazabilidad.md) | 20 de 20 RFs trazados de extremo a extremo (100%). |
| **7** | El diagrama de casos de uso cuenta con al menos 8 casos nombrados como `Verbo + Objeto` y 2 o más actores fuera de la frontera | Casos de Uso | Sí | **Sí** | [`G1-P1 · 04-diagrama-casos-de-uso.svg`](../G1-P1-esquivel/04-diagrama-casos-de-uso.svg) | 12 casos de uso `Verbo + Objeto` y 4 actores externos. |
| **8** | En el diagrama de casos de uso ninguna línea de asociación cruza por encima de otro óvalo y las relaciones `«include»`/`«extend»` están justificadas | Casos de Uso | **No** | **Sí** | Commit [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Hallazgo 1:** Inicialmente 2 líneas cortaban `CU-02` y `CU-10`. Corregido (0 cruces). |
| **9** | Los requisitos no funcionales se distinguen de los funcionales y cuentan con atributos de calidad y métricas medibles | Matriz G1-P1 | **No** | **Sí** | Commit [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Hallazgo 2:** Estaban en viñetas simples. Tabulados bajo estándar ISO/IEC 25010. |
| **10** | Los 2 diagramas de actividades muestran inicio, fin, carriles por actor y guardas entre corchetes `[ ]` en todas sus salidas | Actividades | Sí | **Sí** | [`CU-07 .svg`](./01-diagrama-actividad-cu07-promocion.svg) y [`CU-10 .svg`](./01-diagrama-actividad-cu10-redencion.svg) | Todas las decisiones tienen todas sus guardas y rutas fijas en `.drawio`. |
| **11** | Las plantillas extendidas omiten detalles técnicos de implementación (nombres de tablas, SQL, endpoints o frameworks) | Plantillas | Sí | **Sí** | [`02-plantillas-extendidas-casos-uso.md`](./02-plantillas-extendidas-casos-uso.md) | Verificado: 0 términos técnicos de SQL/código en las plantillas. |
| **12** | El modelo de dominio tiene 8 o más clases conceptuales, atributos de negocio sin métodos y al menos una generalización o composición | Dominio | Sí | **Sí** | [`03-modelo-dominio.svg`](./03-modelo-dominio.svg) | 12 clases, sin métodos, con generalización (`Usuario`) y composición (`FranjaHoraria`). |
| **13** | El MER declara su notación (Pata de Gallo), tiene 6 o más entidades, identificadores y cardinalidades explícitas | MER | **No** | **Sí** | [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg) | **Hallazgo 5:** Faltaban etiquetas numéricas junto a Pata de Gallo y error `--` en comentario XML. Corregido. |
| **14** | Toda relación N:M en el MER está resuelta mediante una entidad asociativa con atributos propios de negocio | MER | **No** | **Sí** | [`04-modelo-entidad-relacion.md`](./04-modelo-entidad-relacion.md) | **Hallazgo 4:** `locales_categorias` no tenía atributos propios. Se agregaron `es_categoria_principal` y `fecha_asignacion`. |
| **15** | El MER representa al menos una entidad débil con dependencia existencial clara | MER | Sí | **Sí** | [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg) | `horarios_promocion` modelada con doble borde dependiente de `promociones`. |
| **16** | Todo diagrama entregado cuenta con archivo fuente editable (`.drawio`) además de su imagen vectorial (`.svg`) válida | Repositorio | Sí | **Sí** | Carpetas `G1-P1` y `G1-P2` | Todos los UML y MER tienen `.drawio` y `.svg` validados en XML. |
| **17** | La sección 3 de cada `README.md` incluye la columna `Enlace al commit`, declaración de IA y respeta privacidad sin datos personales | READMEs | **No** | **Sí** | Commit [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Hallazgo 3:** Faltaba la columna de commit y había nombres completos en P1. Corregido. |
| **18** | El historial de entregas registra commits propios en al menos 2 días calendario distintos por carpeta de producto | GitHub Fork | Sí | **Sí** | Historial GitHub (`24`, `25` y `26` nov) | P1 cerrado en 2 días (`e44a523`, `5451311`); P2 en 2 días (`cc70898` + Tanda 2). |

---

## 3. Resumen Cuantitativo de Verificación

* **Criterios evaluados:** 18 criterios verificables (6 de cobertura/trazabilidad + 12 de calidad y notación).
* **Resultado 1ra Verificación:** 12 cumplidos / **6 hallazgos detectados** (criterios #4, #8, #9, #13, #14 y #17).
* **Resultado 2da Verificación (post-ajustes):** **18 de 18 criterios cumplidos (100%)**.