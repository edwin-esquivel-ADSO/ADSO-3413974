# README de Entrega · Guía 1 · Modelo Conceptual

**Ruta de entrega en el fork:**  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/`

**Fecha de entrega:** Viernes 27 de noviembre de 2026 (Día 1: 25 nov · Día 2: 26 nov · Pulido de auditoría: 27 nov, antes del cierre del sábado 28 de noviembre a las 6:00 a. m.).  
**Criterios de evaluación y mínimos exigibles:** `Rubricas_G1.md` (Competencia 220501093 / RAPs 592373 y 592374).  

---

## 1. Datos de la Entrega

- **Producto:** P2 — Modelo de análisis y verificación
- **Usuario de GitHub del autor:** `edwin-esquivel-ADSO`
- **Caso de estudio:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)
- **Trabajo en equipo del año:** Sí (Equipo formativo Nuvora — ADSO Ficha 3413974. El diseño del modelo de dominio, el ajuste del MER con atributos asociativos, las plantillas extendidas, los diagramas de actividades, la lista de chequeo, el informe de análisis, el registro de ajustes y la matriz de trazabilidad de esta carpeta son de autoría individual de `edwin-esquivel-ADSO`).

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| Plan de análisis, diagrama de casos de uso y matriz de requisitos (G1-P1) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/` | Individual |
| Primeros bocetos visuales y propuesta gráfica del proyecto (Semana 14) | `03-execute/14-week/02-optional-activity/Mockup MercaGO.pdf` y `MercaGO_Digital.pptx` | Equipo Nuvora |
| Especificación inicial de requisitos comerciales del año (Semana 09, base previa al pivote hacia San Pedro Plaza) | `03-execute/09-week/02-optional-activity/SRS_MercaGO_Supermercado.pdf` | Equipo Nuvora |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit | Criterio de `Rubricas_G1.md` que Mejora |
| :-: | :--- | :--- | :---: | :--- |
| **1** | **Modelo Entidad-Relación (`04-modelo-entidad-relacion.*`)** | Se resolvió la relación muchos a muchos entre `locales` y `categorias` incorporando atributos propios (`es_categoria_principal` y `fecha_asignacion`) en `locales_categorias`, se marcó `horarios_promocion` como entidad débil, se limpiaron comentarios XML del SVG y se añadieron cardinalidades numéricas y glosario `PK/FK/UQ/UUID`. | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) | **C4 (Modelo Entidad-Relación)** y **C7 (Registro de ajustes)** |
| **2** | **Diagramas de Actividades (`01-diagrama-actividad-*.drawio` y `.svg`)** | Se fijaron los puntos exactos de ruta (*waypoints*) en ambos archivos `.drawio` para coincidir con el SVG sin cruces sobre figuras, y se rotularon las barras negras paralelas en `CU-10` con su nota explicativa. | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) | **C1 (Diagramas de Actividades)** y **C7 (Registro de ajustes)** |
| **3** | **Plantillas Extendidas y Modelo de Dominio (`02-` y `03-`)** | Se reescribieron los 3 casos críticos bajo formato Anexo A asegurando lenguaje puro de negocio (cero SQL ni detalles de implementación), se ajustó el enlace a `Pantalla 4` y se depuró el modelo de dominio con 12 clases sin métodos ni llaves técnicas. | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) | **C2 (Plantillas extendidas)** y **C3 (Modelo de dominio)** |
| **4** | **Artefactos Base G1-P1 vinculados** | Se corrigieron los 2 cruces geométricos en el diagrama de casos de uso y se tabularon los 10 RNFs bajo ISO/IEC 25010 para garantizar consistencia total al trazar la matriz Anexo C. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/54513113002b51108c19667647af2a83ffd0ea92) | **C6 (Lista de Chequeo)** y **C8 (Informe y Trazabilidad)** |
| **5** | **Prototipos, Verificación, Informe y Trazabilidad (`05-` a `09-` y `README.md`)** | Entrega del Día 2 con 4 mockups `.svg`, lista de chequeo de 18 criterios, registro de 6 hallazgos verificados, informe de análisis consolidado y matriz Anexo C con cobertura del 100 % (20/20 RFs). | [`fe87898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/fe87898bf28b5dd5a6d0eee869da79566240d040) | **C5 (Prototipo)**, **C6 (Chequeo)**, **C7 (Ajustes)** y **C8 (Informe/Matriz)** |

---

## 4. Qué Construí Nuevo

- **2 Diagramas de Actividades críticos (`01-diagramas-actividades.md`, `.drawio` y `.svg`):** Flujos completos de creación de promoción (`CU-07`) y redención en caja con bifurcación y unión paralela (`CU-10`).
- **3 Plantillas Extendidas Anexo A (`02-plantillas-extendidas-casos-uso.md`):** Especificación de `CU-05`, `CU-07` y `CU-10` con flujos alternos y excepciones sincronizadas.
- **Modelo de Dominio Conceptual (`03-modelo-dominio.md`, `.drawio` y `.svg`):** 12 clases conceptuales del negocio con generalización (`Usuario`) y composición (`FranjaHoraria`).
- **Modelo Entidad-Relación en Pata de Gallo (`04-modelo-entidad-relacion.md`, `.drawio` y `.svg`):** 11 entidades, entidad asociativa con atributos propios y entidad débil.
- **Prototipos Iniciales (`05-prototipos-iniciales.md` + 4 mockups `.svg`):** 4 pantallas rotuladas cubriendo Visitante, Locatario y Cajero.
- **Lista de Chequeo Anexo B (`06-lista-chequeo-validacion.md`):** 18 criterios verificables con primera y segunda verificación.
- **Registro de Ajustes Anexo D (`07-registro-ajustes.md`):** 6 hallazgos reales corregidos con antes/después y enlace a commit.
- **Informe de Análisis Anexo E (`08-informe-analisis.md`):** Consolidado técnico de 1–2 páginas con interpretación, enlaces, resultados y ajustes.
- **Matriz de Trazabilidad Anexo C (`09-matriz-trazabilidad.md`):** Cobertura del 100% (20 de 20 RFs) de extremo a extremo.

---

## 5. Artefactos Entregados

**Producto 2**

- [x] Diagramas de actividades (2 diagramas con `.drawio`, `.svg` y descripción): [`01-diagramas-actividades.md`](./01-diagramas-actividades.md) · [`CU-07 .drawio`](./01-diagrama-actividad-cu07-promocion.drawio) · [`CU-07 .svg`](./01-diagrama-actividad-cu07-promocion.svg) · [`CU-10 .drawio`](./01-diagrama-actividad-cu10-redencion.drawio) · [`CU-10 .svg`](./01-diagrama-actividad-cu10-redencion.svg)
- [x] Plantillas extendidas de casos de uso (3 plantillas Anexo A): [`02-plantillas-extendidas-casos-uso.md`](./02-plantillas-extendidas-casos-uso.md)
- [x] Modelo de dominio (12 clases conceptuales, `.drawio` y `.svg`): [`03-modelo-dominio.md`](./03-modelo-dominio.md) · [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio) · [`03-modelo-dominio.svg`](./03-modelo-dominio.svg)
- [x] Modelo entidad-relación (11 entidades Pata de Gallo, `.drawio` y `.svg`): [`04-modelo-entidad-relacion.md`](./04-modelo-entidad-relacion.md) · [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio) · [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg)
- [x] Prototipo inicial (4 pantallas rotuladas en `.svg`): [`05-prototipos-iniciales.md`](./05-prototipos-iniciales.md) · [`Pantalla 1`](./05-mockup-pantalla1-directorio-presupuesto.svg) · [`Pantalla 2`](./05-mockup-pantalla2-billetera-cupon-qr.svg) · [`Pantalla 3`](./05-mockup-pantalla3-creacion-promocion.svg) · [`Pantalla 4`](./05-mockup-pantalla4-validador-caja.svg)
- [x] Lista de chequeo diligenciada (18 criterios verificables, Anexo B): [`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación (6 hallazgos, Anexo D): [`07-registro-ajustes.md`](./07-registro-ajustes.md)
- [x] Informe de análisis (Anexo E): [`08-informe-analisis.md`](./08-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C · 100%): [`09-matriz-trazabilidad.md`](./09-matriz-trazabilidad.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma (usuario de GitHub y fecha):** `edwin-esquivel-ADSO` · 27 de noviembre de 2026

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Asistente de IA (Antigravity)** | Apoyo en la redacción estructurada en Markdown, generación de archivos editables `.drawio`, gráficos vectoriales `.svg` para diagramas y mockups, y armado de tablas de verificación. | Revisé visualmente cada `.drawio` y `.svg` para asegurar coincidencia exacta sin cruces de líneas, confirmé que las plantillas y el dominio no tuvieran código técnico ni SQL, verifiqué las reglas de Pata de Gallo y atributos propios en `locales_categorias`, y validé personalmente la explicación de `PK`, `FK`, `UQ`, `UUID` y barras paralelas para la sustentación oral. |

---

## 8. Autocontrol Antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1: 25 nov · Día 2: 26 nov · Pulido de auditoría: 27 nov).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.