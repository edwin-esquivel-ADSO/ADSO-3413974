# README de Entrega · Guía 1 · Modelo Conceptual

**Ruta de entrega en el fork:**  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/`

**Fecha de entrega:** Viernes 27 de noviembre de 2026 (Día 1: 24 nov · Día 2: 25 nov · Pulido de auditoría: 27 nov, antes del cierre del sábado 28 de noviembre a las 6:00 a. m.).  
**Criterios de evaluación y mínimos exigibles:** `Rubricas_G1.md` (Competencia 220501093 / RAPs 592375 y 592373).  

---

## 1. Datos de la Entrega

- **Producto:** P1 — Plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `edwin-esquivel-ADSO`
- **Caso de estudio:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)
- **Trabajo en equipo del año:** Sí (Equipo formativo Nuvora — ADSO Ficha 3413974. Los ajustes, selección metodológica, matriz de trazabilidad y formalización UML son de autoría individual de `edwin-esquivel-ADSO`).

---

## 2. Qué Reutilicé

A continuación se relacionan los insumos técnicos y documentos base del proyecto formativo alojados en el fork que sirvieron como punto de partida:

| Artefacto Reutilizado | Ruta Original en mi Fork (Semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| Informe preliminar de requisitos de software (SRS v1.0) | `03-execute/09-week/02-optional-activity/` (`SRS_MercaGO_Supermercado.pdf` y `Analisis_LaEsquina.xlsx`) | Equipo Nuvora |
| Especificación evolutiva y cronograma de análisis | `03-execute/10-week/02-optional-activity/` (`SRS_MercaGO_TiendaDeLaEsquina.docx` y `Cronograma weeks.md`) | Equipo Nuvora |
| Propuesta gráfica inicial, mockups y normativa del proyecto | `03-execute/14-week/02-optional-activity/` (`Mockup MercaGO.pdf`, `MercaGO_Digital.pptx` y `MercaGo_Normativa_Proyecto.docx`) | Equipo Nuvora |
| Versión consolidada previa al pivote de centro comercial | `03-execute/15-week/02-optional-activity/` (`SRS_MercaGO_TiendalaEsquina_v1.0 .docx`) | Equipo Nuvora |

---

## 3. Qué Ajusté

Se aplicaron 4 ajustes sustantivos, estructurales y verificables sobre los insumos previos para cumplir con el 100% de los criterios de la rúbrica oficial (`Rubricas_G1.md`):

| # | Artefacto | Qué cambié y por qué | Criterio de `Rubricas_G1.md` que Mejora | Enlace al commit |
| :-: | :--- | :--- | :--- | :---: |
| **1** | **Delimitación del Alcance y Especificación (SRS v2.0)** | **Pivote desde minimercado barrial hacia centro comercial:** Se eliminó la dispersión logística de domicilios urbanos e inventarios volátiles de tiendas barriales (orientación pedagógica curricular). Se formalizó el SRS v2.0 de Nuvora delimitado al Centro Comercial San Pedro Plaza con 20 RFs y 10 RNFs bajo métricas claras. | **C3 (Interpreta informe de requisitos - 15 pts):** Delimita un núcleo funcional estable y elimina la carga inmanejable de pasarelas de pago y logística. | [`e44a523`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/e44a523c2825d007b9cc3668a68f5d9c7f886fa0) |
| **2** | **Diagrama de Casos de Uso UML** | **Refactorización de nomenclatura, actores y topología sin cruces:** Se rediseñó el diagrama completo en `.drawio` y `.svg`. Se estandarizó la nomenclatura bajo la regla estricta `[Verbo] + [Objeto]`, se ubicaron los 4 actores (`Visitante`, `Locatario`, `Cajero`, `Superadministrador`) fuera de la frontera del sistema y se reorganizaron las columnas para eliminar cualquier cruce de líneas sobre los óvalos. | **C4 (Elabora diagramas de casos de uso - 40 pts):** Cumple con 12 casos de uso bien nombrados, 4 actores, frontera delimitada y cero cruces visuales. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) |
| **3** | **Modelado de Relaciones `«include»` y `«extend»`** | **Modelado formal de reglas de negocio y excepciones:** Se incorporaron dos relaciones `«include»` obligatorias (autenticación mandatoria en emisión de cupón y validación horaria en caja) y dos relaciones `«extend»` opcionales (filtro por presupuesto monetario y parametrización de franjas relámpago), cada una con justificación técnica de negocio. | **C4 (Relaciones con criterio - 40 pts):** Evita confusiones de notación y garantiza justificación conforme a la sección 7 de arbitraje. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) |
| **4** | **Matriz de Requisitos y Tabla ISO/IEC 25010** | **Cobertura del 100% de RFs y categorización de RNFs:** Se verificó la trazabilidad exacta de los 20 requisitos funcionales hacia los 12 casos de uso del diagrama y se tabularon los 10 requisitos no funcionales con atributos de calidad ISO/IEC 25010 y métricas de aceptación medibles. | **C3 (Interpreta informe de requisitos - 15 pts):** Garantiza cobertura total ($\ge 90\%$) y diferenciación clara entre RF y RNF. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) |

---

## 4. Qué Construí Nuevo

Artefactos y análisis desarrollados de forma individual para este Producto 1:

- **Caracterización de la solución (`01-caracterizacion-solucion.md`):** Análisis formal de los 4 aspectos exigidos (aplicación web responsiva adaptada para celulares con React y PostgreSQL, equipo de 3 desarrolladores, requisitos estables acotados a San Pedro Plaza y estudio de campo en Neiva).
- **Cuadro comparativo y selección de metodologías (`02-comparacion-metodologias.md`):** Evaluación comparativa entre Scrum, RUP y XP basada en 4 criterios derivados de la solución, con justificación de la adopción de Scrum con prácticas de pruebas e integración.
- **Plan de actividades de análisis (`03-plan-actividades-analisis.md`):** Cronograma de 6 actividades priorizadas, responsables, fechas de ejecución, entregables verificables y matriz de riesgos con control antifraude en base de datos.
- **Matriz de trazabilidad Requisito $\rightarrow$ Caso de Uso (`05-matriz-requisito-caso-de-uso.md`):** Trazabilidad del 100% de los 20 requisitos funcionales y clasificación de los 10 requisitos no funcionales.
- **Renderizado vectorial SVG (`04-diagrama-casos-de-uso.svg`) y fuente editable (`04-diagrama-casos-de-uso.drawio`):** Modelado gráfico de alta fidelidad que cumple con el requisito de fuente editable e imagen.

---

## 5. Artefactos Entregados (Checklist de Verificación)

- [x] Caracterización de la solución: [`01-caracterizacion-solucion.md`](./01-caracterizacion-solucion.md)
- [x] Comparación de metodologías y selección justificada: [`02-comparacion-metodologias.md`](./02-comparacion-metodologias.md)
- [x] Plan de actividades, cronograma y entregables: [`03-plan-actividades-analisis.md`](./03-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable Draw.io): [`04-diagrama-casos-de-uso.drawio`](./04-diagrama-casos-de-uso.drawio)
- [x] Diagrama de casos de uso (imagen vectorial SVG): [`04-diagrama-casos-de-uso.svg`](./04-diagrama-casos-de-uso.svg)
- [x] Matriz requisito $\rightarrow$ caso de uso: [`05-matriz-requisito-caso-de-uso.md`](./05-matriz-requisito-caso-de-uso.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está claramente identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `edwin-esquivel-ADSO`  
**Fecha:** 27 de noviembre de 2026  

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Asistente de IA (Antigravity)** | Apoyo en la estructuración de la documentación técnica en Markdown, formato XML para Draw.io y trazado vectorial SVG del diagrama UML. | Comprobé que cada caso de uso cumpliera la regla `[Verbo] + [Objeto]`, verifiqué que no existieran cruces ni ciclos en las relaciones `«include»` y `«extend»`, validé los 20 requisitos funcionales y 10 no funcionales contra el proyecto Nuvora y confirmé la coherencia del cronograma con la semana de evaluación. |

---

## 8. Autocontrol Antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1: 24 nov · Día 2: 25 nov · Pulido de auditoría: 27 nov).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.