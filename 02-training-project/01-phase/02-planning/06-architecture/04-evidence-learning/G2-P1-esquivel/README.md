# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P1 (artefactos de diseño — A1 a A7)** |
| Usuario de GitHub del autor | `edwin-esquivel-ADSO` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/05-matriz-requisito-caso-de-uso.md) y [`G1-P2-esquivel/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/08-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `edwin-esquivel-ADSO` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base del año (proyecto formativo Nuvora / MercaGO) se trabajó en equipo de **3 personas** de la Ficha `3413974`. |
| ¿Qué parte del SRS es tuya? | La delimitación técnica de arquitectura en 3 capas, las reglas de negocio críticas (`RN-01` a `RN-07`), el diseño del esquema relacional, la seguridad de cupones/sesiones, la auditoría en caja y la consolidación de los 20 RF y 10 RNF en `G1-P1`/`G1-P2`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** Todos los artefactos `A1` a `A7` de esta carpeta (`G2-P1-esquivel`) son de diseño y autoría individual de `edwin-esquivel-ADSO`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **A1. Ficha de interpretación y plataforma** | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-esquivel/01-caracterizacion-solucion.md` y `05-matriz-requisito-caso-de-uso.md`; antecedente `03-execute/09-week/02-optional-activity/SRS_MercaGO_Supermercado.pdf` | Se extrajeron los 20 RF, 10 RNF ISO/IEC 25010, actores y restricciones, añadiendo justificación con 3 condiciones reales del caso para TypeScript/Node.js y PostgreSQL. |
| **A2. Diagrama de clases** | [`02-diagrama-clases.md`](./02-diagrama-clases.md), [`.drawio`](./02-diagrama-clases.drawio), [`.svg`](./02-diagrama-clases.svg) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/03-modelo-dominio.md` (12 clases conceptuales) | Se evolucionaron las 12 clases conceptuales a **16 clases/interfaces de diseño** con visibilidad (`-`/`+`), atributos tipados, métodos con parámetros, herencia `Usuario`, composición `Promocion`–`FranjaHoraria` e interfaz polimórfica `IEstrategiaVigencia`. |
| **A3. Patrones de diseño GoF** | [`03-patrones-diseno.md`](./03-patrones-diseno.md) | **Nuevo** | Se incorporaron 2 patrones distintos de Singleton (**Estrategia** y **Fachada**) reflejados en `A2` para resolver horarios relámpago (`CU-08`) y validación atómica en caja (`CU-10`/`CU-11`). |
| **A4. Arquitectura del software** | [`04-arquitectura-software.md`](./04-arquitectura-software.md), [`.drawio`](./04-arquitectura-software.drawio), [`.svg`](./04-arquitectura-software.svg) | `G1-P1-esquivel/01-caracterizacion-solucion.md` (`RNF07`) + antecedente visual `03-execute/14-week/02-optional-activity/Mockup MercaGO.pdf` | Se formalizó el diagrama estricto de 3 capas sin saltos, comunicación `HTTPS :443` y `TCP/TLS :5432`, más tabla de 5 RNF con alternativas descartadas. |
| **A5. Vista de componentes** | [`05-vista-componentes.md`](./05-vista-componentes.md), [`.drawio`](./05-vista-componentes.drawio), [`.svg`](./05-vista-componentes.svg) | **Nuevo** | Se diseñaron 6 componentes desacoplados con interfaces provistas y requeridas nombradas y mapeo exacto a las 16 clases y 20 RF. |
| **A6. Vista de despliegue** | [`06-vista-despliegue.md`](./06-vista-despliegue.md), [`.drawio`](./06-vista-despliegue.drawio), [`.svg`](./06-vista-despliegue.svg) | **Nuevo** | Se modelaron 4 nodos (`Cliente`, `Aplicación`, `Datos en subred privada`, `Respaldo cifrado`) con protocolos/puertos y respaldo a `RNF01`, `RNF02`, `RNF04` y `RNF06`. |
| **A7. Matriz de trazabilidad** | [`07-matriz-trazabilidad.md`](./07-matriz-trazabilidad.md) | `G1-P2-esquivel/09-matriz-trazabilidad.md` (base de requisitos y tablas) | Se adaptó al cruce bidireccional Análisis $\leftrightarrow$ Diseño cubriendo 20/20 RF, 10/10 RNF, 16/16 clases y 11/11 tablas sin elementos huérfanos. |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Reutilicé la especificación completa de requisitos (`20 RF` y `10 RNF`), actores (`Visitante`, `Locatario`, `Cajero`) y reglas de negocio (`RN-01` a `RN-07`) de `G1-P1-esquivel/`, junto con las 12 clases conceptuales del modelo de dominio de `G1-P2-esquivel/` y los antecedentes iniciales de `03-execute/` (`09-week` y `14-week`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Transformé las clases conceptuales del dominio en clases de diseño OO con visibilidad, tipos de datos y firmas de métodos; justifiqué la plataforma TypeScript/Node.js y PostgreSQL con condiciones reales de San Pedro Plaza; y reubiqué todas las rutas y multiplicidades en `.drawio` y `.svg` para lograr cero cruces de líneas.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Construí desde cero la aplicación de los dos patrones GoF (`Estrategia` y `Fachada`), el diagrama y tabla de decisiones arquitectónicas frente a los RNF, la vista de 6 componentes con interfaces provistas/requeridas, la vista de despliegue en 4 nodos con puertos y seguridad en red, y la matriz bidireccional `A7`.

## 4. Autoverificación de mínimos

**Producto 1 (G2-P1):**
- [x] A1 Ficha de interpretación: ≥ 8 RF y ≥ 3 RNF con ID; plataforma justificada (20 RF y 10 RNF cubiertos)
- [x] A2 Diagrama de clases: ≥ 8 clases, tipos, métodos, multiplicidades, ≥ 1 composición/agregación y ≥ 1 herencia o interfaz (con ≥ 2 implementaciones)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (Estrategia y Fachada, ninguno es Singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF → decisión (5 RNF con alternativas descartadas)
- [x] A5 Vista de componentes: ≥ 5 componentes con interfaces (6 componentes con interfaces provistas/requeridas)
- [x] A6 Vista de despliegue: ≥ 3 nodos con artefactos y protocolos (4 nodos con puertos `443`, `5432` y `22`)
- [x] A7 Matriz de trazabilidad análisis → diseño (100 % bidireccional)
- [x] Fuente editable (`.drawio`) e imagen exportada (`.svg`) de cada diagrama

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| **Día 1 · Jueves 26 de noviembre de 2026** | `89f1956` — `docs(G2-P1): ficha plataforma, diagrama de clases, patrones GoF y arquitectura Nuvora` (entrega de A1, A2, A3 y A4 con diagramas `.drawio` y `.svg` sin cruces). |
| **Día 2 · Viernes 27 de noviembre de 2026** | Entrega de Tanda 2 (`A5` Vista de componentes, `A6` Vista de despliegue, `A7` Matriz de trazabilidad bidireccional y este `README.md` diligenciado). |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Asistente de IA (Antigravity)** | Apoyo en redacción técnica en Markdown, estructuración de archivos `.drawio`/`.svg` y armado de tablas de trazabilidad. | Revisé manualmente todos los `.drawio` y `.svg` en Draw.io, pedí corregir superposiciones de líneas y añadir las 28 multiplicidades visibles en `02-diagrama-clases.drawio`, completar las subcajas de `04-arquitectura-software.drawio` y ampliar canales/separar etiquetas en `05-vista-componentes` y `06-vista-despliegue`, además de validar la explicación oral de los patrones Estrategia y Fachada. |

## 7. Enlaces e Índice de Decisiones (A1–A7)

* **Informe de análisis / SRS del caso:** [`G1-P2-esquivel/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-esquivel/08-informe-analisis.md)
* **Carpeta de esta entrega en GitHub:** `https://github.com/edwin-esquivel-ADSO/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-esquivel`
* **Índice rápido de artefactos y decisión principal:**
  1. [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md): TypeScript/Node.js + PostgreSQL por tipado OO, transacciones ACID y baja latencia en mostrador.
  2. [`02-diagrama-clases.md`](./02-diagrama-clases.md) ([`.drawio`](./02-diagrama-clases.drawio) · [`.svg`](./02-diagrama-clases.svg)): 16 clases/interfaces con herencia `Usuario`, composición `Promocion`–`FranjaHoraria` y polimorfismo en `IEstrategiaVigencia`.
  3. [`03-patrones-diseno.md`](./03-patrones-diseno.md): Patrón *Estrategia* para horarios regulares/relámpago y *Fachada* para orquestar el canje en caja en $\le 1.5\text{ s}$.
  4. [`04-arquitectura-software.md`](./04-arquitectura-software.md) ([`.drawio`](./04-arquitectura-software.drawio) · [`.svg`](./04-arquitectura-software.svg)): 3 capas estrictas sin saltos (`HTTPS :443` y `TCP/TLS :5432`) con bloqueo de fila en BD.
  5. [`05-vista-componentes.md`](./05-vista-componentes.md) ([`.drawio`](./05-vista-componentes.drawio) · [`.svg`](./05-vista-componentes.svg)): 6 componentes con contratos provistos/requeridos sin dependencias circulares.
  6. [`06-vista-despliegue.md`](./06-vista-despliegue.md) ([`.drawio`](./06-vista-despliegue.drawio) · [`.svg`](./06-vista-despliegue.svg)): 4 nodos con base de datos aislada en subred privada y nodo de respaldo diario cifrado (`SFTP :22`).
  7. [`07-matriz-trazabilidad.md`](./07-matriz-trazabilidad.md): cobertura bidireccional de 20/20 RF, 10/10 RNF, 16/16 clases y 11/11 tablas.

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `edwin-esquivel-ADSO` · Fecha: `27 de noviembre de 2026`
