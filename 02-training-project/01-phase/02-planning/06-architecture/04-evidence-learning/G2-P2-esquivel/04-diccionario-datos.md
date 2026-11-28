# B4. Diccionario de Datos Completo

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 2:** Modelo de Datos y Verificación (`G2-P2`)

---

## 1. Estándar de Nombrado Declarado (Rúbrica G2 · Criterio 4)

* **Tablas:** Nombres en español, plural y formato `snake_case` minúscula (`roles`, `usuarios`, `locales`, `categorias`, `locales_categorias`, `productos`, `promociones`, `horarios_promocion`, `cupones`, `redenciones`, `auditoria_logs`), manteniendo coherencia exacta con [`02-modelo-logico.md`](./02-modelo-logico.md) y [`05-script-creacion-nuvora.sql`](./05-script-creacion-nuvora.sql).
* **Columnas:** Formato `snake_case` sin tildes ni caracteres especiales.
* **Llaves:** Llave primaria `id` (`VARCHAR(36)` para UUID v4 en tablas transaccionales; `INTEGER` en catálogos base `roles` y `categorias`); llaves foráneas con sufijo `_id` (`<entidad_singular>_id`).

---

## 2. Catálogo Completo de las 11 Tablas y Todas sus Columnas

### Tabla 1: `roles`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `INTEGER` | n/a | `PK` | Entero positivo identificador del rol (`1`, `2`, `3`, `4`) |
| `nombre` | `VARCHAR` | 30 | `NOT NULL`, `UNIQUE`, `CHECK (nombre IN ('VISITANTE', 'LOCATARIO', 'CAJERO', 'ADMINISTRADOR'))` | Los 4 roles del sistema Nuvora |
| `descripcion` | `VARCHAR` | 150 | `NOT NULL` | Descripción funcional del alcance del rol |

### Tabla 2: `locales`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 del local comercial |
| `nombre_comercial` | `VARCHAR` | 100 | `NOT NULL` | Nombre visible del comercio en San Pedro Plaza |
| `numero_local` | `VARCHAR` | 20 | `NOT NULL`, `UNIQUE` | Código de ubicación física (ej. `L-204`, `PC-08`) |
| `telefono_contacto` | `VARCHAR` | 20 | `NOT NULL` | Teléfono comercial de contacto del local |
| `horario_atencion` | `VARCHAR` | 100 | `NOT NULL` | Horario general de atención en plazoleta |
| `logo_url` | `VARCHAR` | 255 | `NULL` | Ruta URL HTTPS al logotipo comercial del local |
| `estado_operativo` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (estado_operativo IN ('ACTIVO', 'INACTIVO'))` | Estado operativo en el directorio |

### Tabla 3: `usuarios`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 del usuario |
| `rol_id` | `INTEGER` | n/a | `FK` $\rightarrow$ `roles.id`, `NOT NULL`, `ON DELETE RESTRICT` | Rol asignado al usuario |
| `local_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `locales.id`, `NULL`, `ON DELETE SET NULL` | Local asignado (`NULL` para Visitante; obligatorio en lógica para Locatario/Cajero) |
| `nombre_completo` | `VARCHAR` | 120 | `NOT NULL` | Nombre público del usuario |
| `correo` | `VARCHAR` | 120 | `NOT NULL`, `UNIQUE` | Correo electrónico válido único de acceso |
| `hash_contrasena` | `VARCHAR` | 255 | `NOT NULL` | Resumen criptográfico Argon2id/bcrypt (cero texto plano) |
| `sal_contrasena` | `VARCHAR` | 64 | `NOT NULL`, `CHECK (LENGTH(sal_contrasena) >= 16)` | Sal aleatoria única por usuario |
| `estado_cuenta` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (estado_cuenta IN ('ACTIVO', 'BLOQUEADO'))` | Estado de habilitación para iniciar sesión |
| `autoriza_datos` | `BOOLEAN` | n/a | `NOT NULL` | Consentimiento explícito Ley 1581 de 2012 (`RNF09`) |
| `fecha_registro` | `TIMESTAMP` | n/a | `NOT NULL` | Fecha y hora oficial de alta en el servidor |

### Tabla 4: `categorias`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `INTEGER` | n/a | `PK` | Entero positivo identificador de categoría |
| `nombre_categoria` | `VARCHAR` | 60 | `NOT NULL`, `UNIQUE` | Nombre único (ej. `Comidas Rápidas`, `Cafetería`, `Heladería`) |
| `icono` | `VARCHAR` | 80 | `NOT NULL` | Nombre del ícono visual del catálogo |

### Tabla 5: `locales_categorias` *(Tabla intermedia N:M)*
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `local_id` | `VARCHAR` | 36 | `PK`, `FK` $\rightarrow$ `locales.id`, `NOT NULL`, `ON DELETE CASCADE` | Identificador del local comercial |
| `categoria_id` | `INTEGER` | n/a | `PK`, `FK` $\rightarrow$ `categorias.id`, `NOT NULL`, `ON DELETE RESTRICT` | Identificador de la categoría asignada |
| `es_categoria_principal` | `BOOLEAN` | n/a | `NOT NULL` | `TRUE` si es la categoría principal del comercio |
| `fecha_asignacion` | `TIMESTAMP` | n/a | `NOT NULL` | Fecha/hora en que se asoció el local a la categoría |

### Tabla 6: `productos`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 del producto o combo |
| `local_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `locales.id`, `NOT NULL`, `ON DELETE CASCADE` | Local dueño del producto |
| `nombre_producto` | `VARCHAR` | 100 | `NOT NULL` | Nombre del plato, combo o artículo |
| `descripcion` | `VARCHAR` | 300 | `NOT NULL` | Detalle de ingredientes o presentación |
| `precio_regular` | `NUMERIC` | (10,2) | `NOT NULL`, `CHECK (precio_regular > 0)` | Precio regular en pesos colombianos (`$COP`) |
| `foto_url` | `VARCHAR` | 255 | `NULL` | URL HTTPS de la fotografía del producto |
| `disponible` | `BOOLEAN` | n/a | `NOT NULL` | Disponibilidad actual en carta digital |

### Tabla 7: `promociones`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 de la promoción |
| `local_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `locales.id`, `NOT NULL`, `ON DELETE CASCADE` | Local que publica la campaña |
| `producto_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `productos.id`, `NOT NULL`, `ON DELETE RESTRICT` | Producto en oferta |
| `titulo_oferta` | `VARCHAR` | 120 | `NOT NULL` | Título comercial visible al visitante |
| `precio_oferta` | `NUMERIC` | (10,2) | `NOT NULL`, `CHECK (precio_oferta > 0)` | Precio promocional en `$COP` (`< precio_regular`) |
| `cupo_maximo` | `INTEGER` | n/a | `NOT NULL`, `CHECK (cupo_maximo > 0)` | Límite máximo de cupones emitibles (`RF12`) |
| `cupos_usados` | `INTEGER` | n/a | `NOT NULL`, `CHECK (cupos_usados >= 0 AND cupos_usados <= cupo_maximo)` | Contador de cupones ya solicitados |
| `fecha_inicio` | `TIMESTAMP` | n/a | `NOT NULL` | Inicio de vigencia oficial |
| `fecha_fin` | `TIMESTAMP` | n/a | `NOT NULL`, `CHECK (fecha_fin > fecha_inicio)` | Fin de vigencia oficial |
| `estado` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (estado IN ('BORRADOR', 'ACTIVA', 'PAUSADA', 'AGOTADA', 'VENCIDA'))` | Ciclo de vida permitido de la promoción (`RF11`) |

### Tabla 8: `horarios_promocion` *(Entidad Débil)*
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 de la franja horaria |
| `promocion_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `promociones.id`, `NOT NULL`, `ON DELETE CASCADE` | Promoción padre (dependencia existencial) |
| `dia_semana` | `INTEGER` | n/a | `NOT NULL`, `CHECK (dia_semana BETWEEN 1 AND 7)` | Día ISO (`1` = Lunes ... `7` = Domingo) |
| `hora_inicio` | `VARCHAR` | 5 | `NOT NULL` | Hora inicial formato `HH:MM` (ej. `14:30`) |
| `hora_fin` | `VARCHAR` | 5 | `NOT NULL`, `CHECK (hora_fin > hora_inicio)` | Hora final formato `HH:MM` (ej. `17:30`) |

### Tabla 9: `cupones`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 del cupón |
| `promocion_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `promociones.id`, `NOT NULL`, `ON DELETE RESTRICT` | Promoción originadora del cupón |
| `usuario_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `usuarios.id`, `NOT NULL`, `ON DELETE RESTRICT` | Visitante dueño del cupón |
| `codigo_unico` | `VARCHAR` | 16 | `NOT NULL`, `UNIQUE` | Código alfanumérico aleatorio irrepetible (ej. `SPP-7F2A9B`) |
| `fecha_emision` | `TIMESTAMP` | n/a | `NOT NULL` | Timestamp oficial del servidor al emitir |
| `fecha_expiracion` | `TIMESTAMP` | n/a | `NOT NULL`, `CHECK (fecha_expiracion > fecha_emision)` | Máximo 2 horas desde `fecha_emision` (`RN-02`) |
| `estado` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (estado IN ('EMITIDO', 'REDIMIDO', 'VENCIDO'))` | Estado controlado del cupón |

### Tabla 10: `redenciones`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 de la redención |
| `cupon_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `cupones.id`, `NOT NULL`, `UNIQUE`, `ON DELETE RESTRICT` | Garantiza relación `1:1` e impide doble canje (`RN-04`) |
| `cajero_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `usuarios.id`, `NOT NULL`, `ON DELETE RESTRICT` | Cajero autenticado que procesó el canje |
| `local_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `locales.id`, `NOT NULL`, `ON DELETE RESTRICT` | Local donde se efectuó el canje (`RN-07`) |
| `fecha_hora_canje` | `TIMESTAMP` | n/a | `NOT NULL` | Timestamp oficial del servidor en el momento del canje |
| `monto_descontado` | `NUMERIC` | (10,2) | `NOT NULL`, `CHECK (monto_descontado >= 0)` | Ahorro real calculado en `$COP` |
| `metodo_validacion` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (metodo_validacion IN ('QR', 'MANUAL'))` | Modo de captura usado en mostrador |

### Tabla 11: `auditoria_logs`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id` | `VARCHAR` | 36 | `PK` | Identificador único UUID v4 del registro de auditoría |
| `usuario_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `usuarios.id`, `NOT NULL`, `ON DELETE RESTRICT` | Actor que ejecutó la acción |
| `redencion_id` | `VARCHAR` | 36 | `FK` $\rightarrow$ `redenciones.id`, `NULL`, `ON DELETE RESTRICT` | Redención asociada cuando aplica (permite `NULL` en eventos generales; `ON DELETE RESTRICT` impide borrar redenciones auditadas) |
| `accion` | `VARCHAR` | 60 | `NOT NULL` | Evento registrado (ej. `CANJE_CUPON_EXITOSO`) |
| `detalle` | `VARCHAR` | 400 | `NOT NULL` | Descripción inmutable del evento |
| `ip_origen` | `VARCHAR` | 45 | `NOT NULL` | Dirección IPv4 o IPv6 del equipo cliente |
| `fecha_registro` | `TIMESTAMP` | n/a | `NOT NULL` | Timestamp exacto del servidor |
