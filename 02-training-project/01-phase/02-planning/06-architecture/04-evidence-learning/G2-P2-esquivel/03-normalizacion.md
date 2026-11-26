# B3. Evidencia de Normalización Paso a Paso (`0FN → 1FN → 2FN → 3FN`)

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 2:** Modelo de Datos y Verificación (`G2-P2`)

---

## 1. Propósito (Rúbrica G2 · Criterio B3)

Se presenta la normalización paso a paso (`0FN → 1FN → 2FN → 3FN`) sobre **dos estructuras propias reales del proyecto Nuvora** (con sus dependencias funcionales escritas y estado antes/después):
1. **Caso 1 (Llave Compuesta y Dependencia Parcial — 2FN):** Registro consolidado de clasificación de locales por categorías (`locales`, `categorias`, `locales_categorias`).
2. **Caso 2 (Dependencia Transitiva — 3FN):** Registro consolidado de redenciones de cupones en caja (`redenciones`, `cupones`, `usuarios`, `locales`).

---

## 2. Tabla Propia 1 · Clasificación de Locales en Directorio (Llave Compuesta → 2FN)

### Estado Inicial (`0FN` — Antes)

En la captura inicial de requisitos comerciales (`RF04`, `RF05`), toda la ficha del directorio de un local llegaba en una tabla plana sin normalizar:

`directorio_local_0fn(local_id, categoria_id, nombre_comercial, numero_local, telefono_contacto, nombre_categoria, icono, etiquetas_horarios, es_categoria_principal, fecha_asignacion)`
* **Llave primaria compuesta candidata:** `(local_id, categoria_id)`
* **Problema visible en `0FN`:** La columna `etiquetas_horarios` almacena varios turnos concatenados en una misma celda (ej. `"Lun-Vie 11:00-21:00; Sab-Dom 11:00-22:00"`) y se repiten datos del local y la categoría por cada combinación.

### Paso a Paso de Normalización (Tabla 1)

| Forma Normal | Violación Detectada | Dependencias Funcionales (DF) Escritas | Estado Resultante (Después) |
| :--- | :--- | :--- | :--- |
| **1FN** *(Valores atómicos)* | `etiquetas_horarios` contiene múltiples valores separados por punto y coma dentro de una misma celda (atributo no atómico). | *(Limpieza de atomicidad por columna)* | Se deja en `locales` un campo atómico resumido `horario_atencion` (y las franjas detalladas de promociones pasan a tabla propia `horarios_promocion`). Queda en **1FN**: `directorio_1fn(local_id, categoria_id, nombre_comercial, numero_local, telefono_contacto, horario_atencion, nombre_categoria, icono, es_categoria_principal, fecha_asignacion)`. |
| **2FN** *(Dependencia parcial sobre llave compuesta)* | Con llave compuesta `(local_id, categoria_id)`, los datos del comercio dependen **solo** de `local_id` y los de la categoría dependen **solo** de `categoria_id` (no de toda la llave). | • `local_id → nombre_comercial, numero_local, telefono_contacto, horario_atencion`<br>• `categoria_id → nombre_categoria, icono`<br>• `(local_id, categoria_id) → es_categoria_principal, fecha_asignacion` | Se descompone en **tres tablas** sin dependencias parciales:<br>1. `locales(id PK, nombre_comercial, numero_local, telefono_contacto, horario_atencion, logo_url, estado_operativo)`<br>2. `categorias(id PK, nombre_categoria, icono)`<br>3. `locales_categorias(local_id PK/FK, categoria_id PK/FK, es_categoria_principal, fecha_asignacion)` |
| **3FN** *(Sin dependencias transitivas)* | Verificación de que ningún atributo no clave en las tres tablas dependa de otro atributo no clave. | Todos los atributos no clave de `locales`, `categorias` y `locales_categorias` dependen directa y únicamente de su respectiva PK. | **Tabla en 3FN confirmada.** Cero redundancia al cambiar el nombre de una categoría o el teléfono de un local. |

---

## 3. Tabla Propia 2 · Registro de Redención de Cupones en Caja (Dependencia Transitiva → 3FN)

### Estado Inicial (`0FN` — Antes)

Al diseñar el módulo de validación en mostrador (`CU-10`, `RF18`, `RF20`), un reporte plano de canjes reunía en una sola tabla todos los datos visibles en pantalla:

`redencion_mostrador_0fn(id, cupon_id, codigo_unico, estado_cupon, cajero_id, nombre_cajero, correo_cajero, local_id, nombre_local, numero_local, fecha_hora_canje, monto_descontado, metodo_validacion, codigos_alerta_caja)`
* **Llave primaria:** `id`
* **Problema visible en `0FN`:** `codigos_alerta_caja` agrupa varios códigos/observaciones en una celda y aparecen datos descriptivos del cupón, del cajero y del local duplicados en cada redención.

### Paso a Paso de Normalización (Tabla 2)

| Forma Normal | Violación Detectada | Dependencias Funcionales (DF) Escritas | Estado Resultante (Después) |
| :--- | :--- | :--- | :--- |
| **1FN** *(Valores atómicos)* | La columna `codigos_alerta_caja` almacena múltiples eventos o avisos concatenados en un solo campo. | *(Eliminación de grupos repetitivos)* | Los eventos de validación/canje se extraen hacia la bitácora atómica `auditoria_logs(id, usuario_id, redencion_id, accion, detalle, ip_origen, fecha_registro)`. La tabla queda en **1FN** con valores simples por celda. |
| **2FN** *(Dependencia total de PK)* | La llave primaria es simple (`id`), por lo que no existen dependencias parciales respecto a una clave compuesta. | `id → cupon_id, codigo_unico, estado_cupon, cajero_id, nombre_cajero, correo_cajero, local_id, nombre_local, numero_local, fecha_hora_canje, monto_descontado, metodo_validacion` | Confirmada **2FN** en `redencion_mostrador_2fn`. |
| **3FN** *(Dependencias transitivas)* | Existen columnas no clave que dependen de otra columna no clave (y no directamente de `id`): los datos del cupón dependen de `cupon_id`, los del cajero dependen de `cajero_id` y los del local dependen de `local_id`. | • `id → cupon_id → codigo_unico, estado_cupon`<br>• `id → cajero_id → nombre_cajero, correo_cajero`<br>• `id → local_id → nombre_local, numero_local`<br>• `id → cupon_id, cajero_id, local_id, fecha_hora_canje, monto_descontado, metodo_validacion` | Se trasladan los atributos transitivos a sus entidades dueñas:<br>1. `cupones(id PK, promocion_id FK, usuario_id FK, codigo_unico UQ, fecha_emision, fecha_expiracion, estado)`<br>2. `usuarios(id PK, rol_id FK, local_id FK, nombre_completo, correo UQ, ...)`<br>3. `locales(id PK, nombre_comercial, numero_local, ...)`<br>4. **`redenciones(id PK, cupon_id FK UQ, cajero_id FK, local_id FK, fecha_hora_canje, monto_descontado, metodo_validacion)`** |

---

## 4. Resultado Global del Modelo

El modelo lógico completo de **11 tablas** queda **100 % normalizado en 3FN** sin anomalías de inserción, actualización ni borrado, y sin desnormalizaciones intencionales (la columna `promociones.cupos_usados` se actualiza atómicamente bajo transacción SQL con restricción `CHECK (cupos_usados <= cupo_maximo)` para mantener el conteo en tiempo real en `RNF01`).
