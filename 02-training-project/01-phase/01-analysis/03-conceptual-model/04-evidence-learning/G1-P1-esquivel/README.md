# README de Entrega · Guía 1 · Modelo Conceptual

**Ruta de entrega en el fork:**  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/`

**Fecha de entrega:** Martes 24 de noviembre de 2026 (Día 1 de commits antes del cierre del sábado 28 de noviembre a las 6:00 a. m.).  
**Criterios de evaluación y mínimos exigibles:** `Rubricas_G1.md` (Competencia 220501093 / RAPs 592375 y 592373).  

---

## 1. Datos de la Entrega

- **Producto:** P1 — Plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `edwin-esquivel-ADSO`
- **Caso de estudio:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)
- **Trabajo en equipo del año:** Sí (Equipo formativo ADSO Ficha 3413974: Edwin Esquivel, Jose Covaleda, Paula Claros. Los ajustes, selección metodológica, matriz de trazabilidad y formalización UML son de autoría individual de `edwin-esquivel-ADSO`).

---

## 2. Qué Reutilicé

A continuación se relacionan los insumos técnicos y documentos base del proyecto formativo alojados en el fork que sirvieron como punto de partida:

| Artefacto Reutilizado | Ruta Original en mi Fork (Semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| Informe preliminar de requisitos de software (SRS v1.0) | `03-execute/09-week/02-optional-activity/` (Semana de Requisitos) | Equipo Nuvora |
| Bocetos preliminares de casos de uso y módulos comerciales | `03-execute/15-week/02-optional-activity/` | Equipo Nuvora |
| Diagramas de flujo de procesos comerciales iniciales | `03-execute/16-week/02-optional-activity/` | Equipo Nuvora |
| Guía de estilos y primeros wireframes de interfaz en Figma | `03-execute/17-week/02-optional-activity/` | Paula Claros / Equipo |

---

## 3. Qué Ajusté

Se aplicaron 3 ajustes sustantivos, estructurales y verificables sobre los insumos previos para cumplir con el 100% de los criterios de la rúbrica oficial (`Rubricas_G1.md`):

| # | Artefacto | Qué cambié y por qué | Criterio de `Rubricas_G1.md` que Mejora |
| :-: | :--- | :--- | :--- |
| **1** | **Delimitación del Alcance y Especificación (SRS v2.0)** | **Pivote desde minimercado barrial hacia centro comercial:** Se eliminó la dispersión logística de domicilios urbanos e inventarios volátiles de tiendas barriales (orientación pedagógica de la Instructora Karol Correa). Se formalizó el SRS v2.0 de Nuvora delimitado al Centro Comercial San Pedro Plaza con 20 RFs, 10 RNFs y estudio de campo simulado en Neiva (35 encuestas y 6 entrevistas). | **C3 (Interpreta informe de requisitos - 15 pts):** Delimita un núcleo funcional estable y elimina la carga inmanejable de pasarelas de pago y logística. |
| **2** | **Diagrama de Casos de Uso UML** | **Refactorización de nomenclatura, actores y frontera:** Se rediseñó el diagrama completo en `.drawio` y `.svg`. Se estandarizó la nomenclatura bajo la regla estricta `[Verbo] + [Objeto]` (ej. `CU-05: Generar cupón de descuento QR`), se ubicaron los 4 actores (`Visitante`, `Locatario`, `Cajero`, `Superadministrador`) fuera de la frontera del sistema y se eliminaron casos redundantes. | **C4 (Elabora diagramas de casos de uso - 40 pts):** Cumple con 10 casos de uso bien nombrados, 4 actores y frontera delimitada sin ciclos. |
| **3** | **Modelado de Relaciones `<<include>>` y `<<extend>>`** | **Modelado formal de reglas de negocio y excepciones:** Se incorporaron dos relaciones `<<include>>` obligatorias (autenticación mandatoria en emisión de cupón y validación atómica horaria en caja) y dos relaciones `<<extend>>` opcionales (filtro por presupuesto monetario y parametrización de franjas relámpago), cada una con justificación técnica de negocio. | **C4 (Relaciones con criterio - 40 pts):** Evita confusiones de notación y garantiza justificación conforme a la sección 7 de arbitraje. |

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

**Firma:** `edwin-esquivel-ADSO` (Edwin Alejandro Esquivel Bahamón)  
**Fecha:** 24 de noviembre de 2026  

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Antigravity / Gemini 3.8 & Claude 3.5 Sonnet** | Apoyo en la estructuración de la documentación técnica en Markdown, redacción del XML para Draw.io y optimización del código SVG vectorial del diagrama UML. | Comprobé que cada caso de uso cumpliera la regla `[Verbo] + [Objeto]`, verifiqué que no existieran ciclos en las relaciones `<<include>>` ni `<<extend>>`, validé los 20 requisitos funcionales y 10 no funcionales contra el SRS v2.0 de Nuvora y verifiqué la coherencia del cronograma con la semana de sustentación. |

---

## 8. Autocontrol Antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1 de commits programado).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] La carpeta contiene todos los artefactos obligatorios sin omitir ninguno.