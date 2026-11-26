# 08. Informe de Análisis Conceptual y Verificación (Anexo E)

**Programa de Formación:** Tecnología en Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — SENA Regional Huila  
**Proyecto Formativo:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas (Caso Piloto: San Pedro Plaza, Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Fecha:** 26 de noviembre de 2026  

---

## 1. Requisitos Interpretados del Sistema Nuvora

El análisis parte del estudio de campo realizado en el **Centro Comercial San Pedro Plaza** de Neiva (35 visitantes, 4 locatarios y 2 cajeros), el cual reveló que el 88.6% de los volantes físicos son desechados, el 82.9% de los visitantes desconoce las promociones del día y el 77.1% elige dónde comer según un presupuesto fijo. Siguiendo las directrices pedagógicas de delimitación de alcance, se excluyeron servicios de mensajería urbana y pasarelas bancarias en línea, concentrando el software en el canje presencial dentro del local.

Se interpretaron y modelaron **20 Requisitos Funcionales (RF01–RF20)** agrupados en seis módulos clave:
1. **Acceso y Usuarios (`RF01–RF04`):** Registro de visitantes con clave protegida, inicio de sesión por rol, recuperación de acceso y gestión del perfil del local.
2. **Directorio y Filtro por Presupuesto (`RF05–RF08`):** Catálogo por categorías, carta digital con precios, búsqueda por texto y algoritmo para filtrar comidas según el presupuesto en pesos colombianos ($COP).
3. **Motor de Promociones y Horarios (`RF09–RF12`):** Creación de ofertas con límite diario de cupos, gestión de estados (`Borrador`, `Activa`, `Pausada`, `Vencida`, `Agotada`) y franjas horarias para ofertas relámpago en horas valle.
4. **Cupones QR Dinámicos (`RF13–RF15`):** Generación de códigos alfanuméricos aleatorios únicos (máximo 1 cupón por promoción cada 24 horas), renderizado QR con cuenta regresiva de 2 horas y billetera personal.
5. **Validación en Punto de Venta (`RF16–RF18`):** Lectura por cámara o ingreso manual de respaldo en mostrador, validación contra reloj oficial del servidor y bloqueo inmediato del registro para impedir doble redención.
6. **Métricas y Auditoría (`RF19–RF20`):** Panel de conversión (cupones emitidos vs. canjeados) y bitácora inmutable de redenciones.

Complementariamente, se establecieron **10 Requisitos No Funcionales (RNF01–RNF10)** clasificados bajo atributos de calidad **ISO/IEC 25010** con métricas verificables: respuesta en caja $\le 1.5\text{ segundos}$, disponibilidad $\ge 99.0\%$ en horario del mall, 0 redenciones duplicadas simultáneas, diseño adaptable para celulares, cifrado de contraseñas y cumplimiento de la Ley 1581 de 2012 (Habeas Data).

---

## 2. Enlaces a los Modelos de Análisis Construidos

Todos los artefactos conceptuales mantienen coherencia entre sí y cuentan con su archivo editable y representación visual:

* **Casos de Uso UML (12 casos, 4 actores externos, 2 `«include»`, 2 `«extend»`):**  
  [`G1-P1 · 04-diagrama-casos-de-uso.svg`](../G1-P1-esquivel/04-diagrama-casos-de-uso.svg) · [`.drawio`](../G1-P1-esquivel/04-diagrama-casos-de-uso.drawio)
* **Diagramas de Actividades (carriles por actor, guardas y concurrencia paralela en caja):**  
  [`01-diagramas-actividades.md`](./01-diagramas-actividades.md) · [`CU-07 .svg`](./01-diagrama-actividad-cu07-promocion.svg) · [`CU-10 .svg`](./01-diagrama-actividad-cu10-redencion.svg)
* **Plantillas Extendidas de Casos de Uso (`CU-05`, `CU-07`, `CU-10` en lenguaje de negocio):**  
  [`02-plantillas-extendidas-casos-uso.md`](./02-plantillas-extendidas-casos-uso.md)
* **Modelo de Dominio Conceptual (12 clases sin métodos, con generalización y composición):**  
  [`03-modelo-dominio.md`](./03-modelo-dominio.md) · [`03-modelo-dominio.svg`](./03-modelo-dominio.svg) · [`.drawio`](./03-modelo-dominio.drawio)
* **Modelo Entidad-Relación MER (Notación Pata de Gallo, 11 entidades, N:M y entidad débil):**  
  [`04-modelo-entidad-relacion.md`](./04-modelo-entidad-relacion.md) · [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg) · [`.drawio`](./04-modelo-entidad-relacion.drawio)
* **Prototipos Iniciales de Interfaz (4 pantallas rotuladas con su caso de uso):**  
  [`05-prototipos-iniciales.md`](./05-prototipos-iniciales.md)
* **Matriz Completa de Trazabilidad (Anexo C · 100% de cobertura):**  
  [`09-matriz-trazabilidad.md`](./09-matriz-trazabilidad.md)

---

## 3. Resultado de la Verificación (Lista de Chequeo)

Se diseñó y aplicó una lista de chequeo con **18 criterios objetivos verificables** ([`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)), abarcando cobertura de requisitos, coherencia entre plantillas y actividades, pureza conceptual del dominio, notación de Pata de Gallo, rotulación de prototipos y reglas de autoría en Git.

* **Criterios que cumplieron en la primera verificación (12 de 18):** Cobertura del 100% de RFs en matriz, 3 plantillas extendidas sin detalles técnicos SQL, 12 clases de dominio sin métodos, existencia de entidad débil (`horarios_promocion`), 4 pantallas rotuladas y dualidad de archivos editables `.drawio`/`.svg`.
* **Criterios con hallazgos en la primera verificación (6 de 18):** Cruces visuales de líneas en el diagrama UML (`#8`), falta de categorización ISO/IEC 25010 en RNFs (`#9`), omisión de enlaces a commit y datos personales en README P1 (`#17`), ausencia de atributos propios en la tabla asociativa `locales_categorias` (`#14`), comentarios XML inválidos con `--` y falta de glosario en el MER (`#13`), y rutas automáticas sin puntos fijos en los `.drawio` de actividades junto con falta de rótulo en las barras paralelas (`#4`).

---

## 4. Ajustes Realizados y Dictamen Final

Todos los hallazgos fueron corregidos de inmediato y documentados en [`07-registro-ajustes.md`](./07-registro-ajustes.md):
1. Se reorganizó el diagrama de casos de uso en tres columnas eliminando los 2 cruces detectados (0 cruces verificados) y se tabularon los 10 RNFs bajo ISO/IEC 25010 en español claro (commit [`5451311`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/5451311)).
2. Se añadieron los atributos `es_categoria_principal` y `fecha_asignacion` a la entidad asociativa `locales_categorias`, se depuró el código XML de todos los SVG, se fijaron los puntos de ruta (*waypoints*) en todos los `.drawio` y se rotularon las barras de bifurcación/unión paralela en `CU-10` (commit [`cc70898`](https://github.com/edwin-esquivel-ADSO/ADSO-3413974/commit/cc70898de41f2efb23bd1b91d4be65693b39914b) y cierre final).

En la **segunda verificación**, los **18 de 18 criterios aprobaron satisfactoriamente (100%)**, dejando el modelo conceptual de análisis verificado, trazable y listo para la fase de diseño arquitectónico (Guía 2).