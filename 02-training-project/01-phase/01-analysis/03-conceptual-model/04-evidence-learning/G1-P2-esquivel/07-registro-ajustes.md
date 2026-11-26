# 07. Registro de Ajustes y Segunda Verificación (Anexo D)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  

---

## 1. Registro de Hallazgos Corregidos (Rúbrica G1 · Criterio C7)

A continuación se documentan los **6 hallazgos reales** identificados durante la primera revisión cruzada sobre los artefactos de la Guía 1 (superando el mínimo de 5 ajustes exigido en la rúbrica), detallando el estado anterior, la corrección aplicada, su trazabilidad al commit y el resultado de la segunda verificación:

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes | Después | Enlace al commit | ¿Se verificó de nuevo? |
| :-: | :--- | :--- | :--- | :--- | :---: | :---: |
| **1** | **Criterio #8 (Topología sin cruces UML):** Dos líneas de asociación atravesaban otros casos de uso. | `G1-P1`: `04-diagrama-casos-de-uso.svg` y `.drawio` | La línea `Visitante -> CU-03` cortaba por la mitad el óvalo de `CU-02`, y `Locatario -> CU-12` atravesaba `CU-10`. | Se reorganizaron las 3 columnas subiendo `CU-03` frente a `Visitante` y `CU-12` arriba de `CU-10`. Verificado geométricamente: **0 cruces**. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Sí** *(2da verificación aprobada)* |
| **2** | **Criterio #9 (RNFs con métricas medibles):** Requisitos no funcionales listados en viñetas simples sin atributos de calidad. | `G1-P1`: `05-matriz-requisito-caso-de-uso.md` | Lista plana de `RNF01` a `RNF10` sin categorización estándar y con algunos términos técnicos en inglés difíciles de sustentar. | Tabla formal clasificada bajo atributos **ISO/IEC 25010** en español claro, cada uno con métrica medible ($\le 1.5\text{ s}$, $\ge 99.0\%$, $2\text{ horas}$). | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Sí** *(2da verificación aprobada)* |
| **3** | **Criterio #17 (Trazabilidad en README y privacidad):** Faltaba la columna `Enlace al commit` en Sección 3 y figuraban nombres personales completos. | `G1-P1`: `README.md` | Tabla de 4 columnas sin link al commit y firma con nombre completo de aprendices en repositorio público. | Agregada 5ta columna `Enlace al commit` apuntando a `e44a523`, firma unificada con usuario GitHub `edwin-esquivel-ADSO` y 4to ajuste documentado. | [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311) | **Sí** *(2da verificación aprobada)* |
| **4** | **Criterio #14 (Entidad asociativa N:M con atributos propios):** La tabla intermedia solo poseía llaves foráneas. | `G1-P2`: `04-modelo-entidad-relacion.md`, `.svg` y `.drawio` | `locales_categorias` únicamente contenía `(local_id, categoria_id)` sin atributos descriptivos propios. | Se incorporaron dos atributos propios de negocio: `es_categoria_principal` (`BOOLEAN`) y `fecha_asignacion` (`TIMESTAMP`). | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) | **Sí** *(2da verificación aprobada)* |
| **5** | **Criterio #13 (Validez XML y lectura de Pata de Gallo):** Comentarios XML inválidos en SVG y falta de glosario `PK/FK/UQ`. | `G1-P2`: `04-modelo-entidad-relacion.svg`, `.drawio` y `.md` | Comentarios XML con triple guion (`---`) que impedían renderizar el SVG, sin etiquetas numéricas sobre las líneas y sin explicación de `PK/FK/UQ/UUID`. | Limpiados todos los comentarios XML, agregadas cardinalidades explícitas (`1 : 0..*`, `1 : 1..*`, `1 : 0..1`) y añadido glosario en español. | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) | **Sí** *(2da verificación aprobada)* |
| **6** | **Criterio #4 (Sincronía de Diagramas de Actividades y Plantillas):** Rutas de flechas en `.drawio` sin puntos fijos y barras paralelas sin rótulo. | `G1-P2`: `01-diagrama-actividad-*.drawio`, `.svg` y `02-plantillas...md` | Draw.io auto-enrutaba flechas sobre cajas en `CU-07` y `CU-10`, las barras negras paralelas carecían de etiqueta explicativa y la plantilla de `CU-10` decía `Pantalla 3` en el texto del enlace hacia `Pantalla 4`. | Fijados puntos exactos de ruta (*waypoints*) en `.drawio` iguales al SVG, rotuladas las barras de bifurcación/unión paralela y corregida la etiqueta a `Pantalla 4`. | [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) *(y cierre Tanda 2)* | **Sí** *(2da verificación aprobada)* |

---

## 2. Conclusión de la Segunda Verificación

Tras ejecutar la segunda revisión sobre la totalidad de los archivos en `G1-P1-esquivel` y `G1-P2-esquivel`, se confirma que:
* Los **6 hallazgos quedaron corregidos** con evidencia en el repositorio.
* Todos los diagramas `.svg` y `.drawio` pasan validación XML estricta con **0 cruces de líneas sobre figuras**.
* Los **18 criterios** de la lista de chequeo obtuvieron estado **`Sí` (100% de conformidad)**.