# B5. Evidencia de Ejecución del Script SQL sin Errores

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Script evaluado:** [`05-script-creacion-nuvora.sql`](./05-script-creacion-nuvora.sql)

---

## 1. Resumen de Ejecución en Motor SQL Real

* **Motor utilizado en verificación:** **SQLite `3.50.4`** (con `PRAGMA foreign_keys = ON;`, sintaxis ANSI SQL idéntica y compatible con **PostgreSQL 18**).
* **Resultado:** **Ejecución exitosa con código de salida `0` (cero errores de sintaxis o integridad referencial)**.
* **Tablas creadas (`11` de `11`, `100 %`):** `roles`, `locales`, `usuarios`, `categorias`, `locales_categorias`, `productos`, `promociones`, `horarios_promocion`, `cupones`, `redenciones`, `auditoria_logs`.
* **Restricciones comprobadas:** `11` llaves primarias (`PK`), `15` llaves foráneas (`FK`) con acciones `ON DELETE RESTRICT`, `CASCADE` o `SET NULL`, `6` llaves únicas (`UNIQUE`), `15` restricciones `CHECK` y `3` índices B-Tree (`idx_cupones_codigo_unico`, `idx_productos_precio_regular`, `idx_promociones_estado_fechas`).

---

## 2. Log Real de Ejecución y Pruebas de Integridad

```text
=== EJECUCION REAL SQL (SQLite 3.50.4) ===
Tablas creadas (11): roles, locales, usuarios, categorias, locales_categorias, productos, promociones, horarios_promocion, cupones, redenciones, auditoria_logs
Indices creados (3): idx_cupones_codigo_unico, idx_productos_precio_regular, idx_promociones_estado_fechas
Consulta JOIN extremo a extremo: ('Asados Plazoleta SPP', 'Parrilla', 'Combo Punta de Anca + Bebida', 'Hora Valle Parrilla', '14:30-17:30', 'SPP-7F2A9B', 8000, 'CANJE_CUPON_EXITOSO')
Bloqueo doble redencion OK (IntegrityError): UNIQUE constraint failed: redenciones.cupon_id
Bloqueo CHECK cupos OK (IntegrityError): CHECK constraint failed: ck_promociones_cupos
```

---

## 3. Verificación de Reglas Críticas de Negocio en BD

1. **Bloqueo de doble redención (`RN-04` / `RNF04`):** Al intentar insertar una segunda fila en `redenciones` con el mismo `cupon_id`, el motor rechazó la operación automáticamente con `UNIQUE constraint failed: redenciones.cupon_id`.
2. **Protección de cupos máximos (`RF12`):** Al intentar insertar una promoción con `cupos_usados > cupo_maximo` (`15 > 10`), el motor detuvo la inserción con `CHECK constraint failed: ck_promociones_cupos`.
3. **Consistencia diccionario ↔ SQL:** Los nombres de las `11` tablas, columnas y tipos coinciden exactamente con [`04-diccionario-datos.md`](./04-diccionario-datos.md) y [`02-modelo-logico.md`](./02-modelo-logico.md).
