# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P2 (modelo de datos y verificación — B1 a B7)** |
| Usuario de GitHub del autor | `edwin-esquivel-ADSO` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md) y [`G1-P2-esquivel/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/08-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `edwin-esquivel-ADSO` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base del año (proyecto formativo Nuvora / MercaGO) se trabajó en equipo de **3 personas** de la Ficha `3413974`. |
| ¿Qué parte del SRS es tuya? | El diseño del modelo de datos relacional, las reglas de unicidad e integridad referencial (`RN-01` a `RN-07`), el esquema de auditoría inmutable y la estructuración técnica de requisitos en `G1-P1`/`G1-P2`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** Todos los artefactos `B1` a `B7` de esta carpeta (`G2-P2-esquivel`) son de diseño, normalización, codificación SQL y verificación individual de `edwin-esquivel-ADSO`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **B1. Modelo conceptual** | [`01-modelo-conceptual.md`](./01-modelo-conceptual.md), [`.drawio`](./01-modelo-conceptual.drawio), [`.svg`](./01-modelo-conceptual.svg) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/04-modelo-entidad-relacion.md` (MER base de G1) | Se llevó a vista conceptual pura con `N:M` explícita (`LocalComercial` $\leftrightarrow$ `Categoria`), verbos en cada relación, cardinalidades mín/máx legibles, justificación relacional PostgreSQL y trazabilidad por entidad. |
| **B2. Modelo lógico relacional** | [`02-modelo-logico.md`](./02-modelo-logico.md), [`.drawio`](./02-modelo-logico.drawio), [`.svg`](./02-modelo-logico.svg) | `G1-P2-esquivel/04-modelo-entidad-relacion.drawio` (base de 11 entidades) | Se añadieron tipos SQL exactos, PK/FK/UQ en las 11 tablas, cuadro de 6 reglas de transformación (`N:M`, `1:N`, `1:1` vía `UNIQUE`, entidad débil y generalización de `Usuario`) y notación Pata de Gallo + números explícitos. |
| **B3. Evidencia de normalización** | [`03-normalizacion.md`](./03-normalizacion.md) | **Nuevo** | Se normalizaron 2 estructuras propias (`directorio_local_0fn` con llave compuesta a `2FN/3FN` y `redencion_mostrador_0fn` por transitividad a `3FN`) con dependencias funcionales y antes/después. |
| **B4. Diccionario de datos** | [`04-diccionario-datos.md`](./04-diccionario-datos.md) | **Nuevo** | Documentación del 100 % de las 11 tablas y todas sus columnas (`snake_case`, tipo, tamaño, restricciones y dominio) idéntica al modelo y script SQL. |
| **B5. Script SQL y ejecución** | [`05-script-creacion-nuvora.sql`](./05-script-creacion-nuvora.sql) y [`05-evidencia-ejecucion-sql.md`](./05-evidencia-ejecucion-sql.md) | **Nuevo** | DDL completo ANSI/PostgreSQL con 11 tablas, 15 FKs con `ON DELETE`, 6 `UNIQUE`, 15 `CHECK`, 3 índices y log real de ejecución sin errores con prueba de bloqueo a doble redención. |
| **B6. Políticas de seguridad y roles** | [`06-politicas-seguridad-roles.md`](./06-politicas-seguridad-roles.md) | `G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md` (`RNF02`, `RNF04`, `RNF09`) | Se concretaron 9 políticas (integridad, confidencialidad, disponibilidad), **hash y sal**, TLS, respaldo diario/restauración mensual, Ley 1581 y matriz de 4 roles $\times$ 11 tablas. |
| **B7. Lista de chequeo y hallazgos** | [`07-lista-chequeo-hallazgos.md`](./07-lista-chequeo-hallazgos.md) | `G1-P2-esquivel/06-lista-chequeo-validacion.md` (enfoque de chequeo previo en G1) | Se diseñó instrumento específico para Guía 2 con **24 criterios medibles** con severidad aplicados a `G2-P1` y `G2-P2`, evidencias por criterio y 7 hallazgos reales corregidos. |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Partí del MER de 11 entidades construido en `G1-P2-esquivel/04-modelo-entidad-relacion.*`, los requisitos `RF01`–`RF20` y `RNF01`–`RNF10` definidos en `G1-P1-esquivel/`, y las decisiones de diseño de clases de `G2-P1-esquivel/` (`A1`–`A7`) para garantizar continuidad exacta entre análisis, arquitectura y datos.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Separé claramente el nivel conceptual (`B1`, con verbos y relación `N:M` explícita) del nivel lógico (`B2`, con cuadro de transformación, Pata de Gallo y números en cada unión); además unifiqué nombres y tipos exactos entre diagrama lógico, diccionario y DDL ejecutable.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Elaboré desde cero la normalización paso a paso `0FN → 3FN` de dos tablas propias, el diccionario completo de las 11 tablas, el script DDL ejecutable con su log real de pruebas de integridad en motor SQL, las 9 políticas de seguridad con matriz de 4 roles y la lista de chequeo de 24 criterios aplicada a P1 y P2.

## 4. Autoverificación de mínimos

**Producto 2 (G2-P2):**
- [x] B1 Modelo conceptual: ≥ 6 entidades, cardinalidades, ≥ 1 N:M y ≥ 1 1:N (10 entidades con verbos y lecturas explícitas)
- [x] B2 Modelo lógico: ≥ 8 tablas con PK/FK y cuadro de reglas de transformación (11 tablas + 6 reglas aplicadas)
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (una con llave compuesta y una con dependencia transitiva)
- [x] B4 Diccionario de datos completo (100 % de las 11 tablas y todas sus columnas)
- [x] B5 Script SQL ejecutado sin errores (evidencia adjunta en `05-evidencia-ejecucion-sql.md`) y `ON DELETE` en ≥ 3 FK (`15` FKs, `6` `UNIQUE` y `15` `CHECK`)
- [x] B6 ≥ 6 políticas de seguridad (9 políticas con **hash y sal** en contraseñas, TLS, Ley 1581 y respaldo) y matriz de ≥ 3 roles (4 roles $\times$ 11 tablas)
- [x] B7 Lista de chequeo de ≥ 20 criterios (24 criterios con severidad), diligenciada sobre P1 y P2, con evidencia y 7 hallazgos corregidos

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| **Día 1 · Jueves 26 de noviembre de 2026** | [`2b36b76`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/2b36b76) — `docs(G2-P2): modelo conceptual, modelo logico 3FN y normalizacion paso a paso Nuvora` (entrega de B1, B2 y B3 con diagramas `.drawio` y `.svg`). |
| **Día 2 · Viernes 27 de noviembre de 2026** | [`476d570`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/476d570) — `docs(G2-P2): diccionario de datos, script SQL ejecutado, seguridad, lista chequeo y README` + corrección de anclajes en `locales -> redenciones`, orden de capas SVG, rol `ADMINISTRADOR` y `ON DELETE RESTRICT` en auditoría. |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Asistente de IA (Antigravity)** | Apoyo en redacción técnica de documentos Markdown, generación de diagramas `.drawio`/`.svg` y revisión de sentencias DDL ANSI SQL. | Revisé visualmente en Draw.io las cardinalidades y símbolos Pata de Gallo de `01-modelo-conceptual` y `02-modelo-logico`, verifiqué la lectura verbal de cada relación, ejecuté personalmente el script SQL comprobando las restricciones `UNIQUE`/`CHECK`, y validé el cuadro de normalización `0FN → 3FN`. |

## 7. Enlaces

* **Informe de análisis / SRS del caso:** [`G1-P2-esquivel/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/08-informe-analisis.md)
* **Carpeta de esta entrega en GitHub:** `https://github.com/edwin-esquivel-ADSO/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-esquivel`
* **Carpeta relacionada P1:** [`G2-P1-esquivel/README.md`](../G2-P1-esquivel/README.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `edwin-esquivel-ADSO` · Fecha: `27 de noviembre de 2026`
