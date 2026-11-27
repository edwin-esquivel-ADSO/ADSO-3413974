-- =============================================================================
-- B5. Script SQL de Creación de Base de Datos Nuvora (3FN)
-- Proyecto: Nuvora - Centro Comercial San Pedro Plaza (Neiva)
-- Autor: edwin-esquivel-ADSO
-- Compatibilidad verificada: PostgreSQL 18 / SQLite 3 (ANSI SQL estricto)
-- =============================================================================

-- 1. Roles del sistema
CREATE TABLE roles (
  id          INTEGER PRIMARY KEY,
  nombre      VARCHAR(30)  NOT NULL UNIQUE,
  descripcion VARCHAR(150) NOT NULL,
  CONSTRAINT ck_roles_nombre CHECK (nombre IN ('VISITANTE', 'LOCATARIO', 'CAJERO'))
);

-- 2. Locales comerciales de San Pedro Plaza
CREATE TABLE locales (
  id                VARCHAR(36)  PRIMARY KEY,
  nombre_comercial  VARCHAR(100) NOT NULL,
  numero_local      VARCHAR(20)  NOT NULL UNIQUE,
  telefono_contacto VARCHAR(20)  NOT NULL,
  horario_atencion  VARCHAR(100) NOT NULL,
  logo_url          VARCHAR(255) NULL,
  estado_operativo  VARCHAR(20)  NOT NULL,
  CONSTRAINT ck_locales_estado CHECK (estado_operativo IN ('ACTIVO', 'INACTIVO'))
);

-- 3. Usuarios autenticables (Generalización unificada con rol y local opcional)
CREATE TABLE usuarios (
  id              VARCHAR(36)  PRIMARY KEY,
  rol_id          INTEGER      NOT NULL,
  local_id        VARCHAR(36)  NULL,
  nombre_completo VARCHAR(120) NOT NULL,
  correo          VARCHAR(120) NOT NULL UNIQUE,
  hash_contrasena VARCHAR(255) NOT NULL,
  sal_contrasena  VARCHAR(64)  NOT NULL,
  estado_cuenta   VARCHAR(20)  NOT NULL,
  autoriza_datos  BOOLEAN      NOT NULL,
  fecha_registro  TIMESTAMP    NOT NULL,
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (rol_id)
    REFERENCES roles (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_usuarios_local FOREIGN KEY (local_id)
    REFERENCES locales (id) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_usuarios_sal CHECK (LENGTH(sal_contrasena) >= 16),
  CONSTRAINT ck_usuarios_estado CHECK (estado_cuenta IN ('ACTIVO', 'BLOQUEADO'))
);

-- 4. Categorías del directorio
CREATE TABLE categorias (
  id               INTEGER PRIMARY KEY,
  nombre_categoria VARCHAR(60) NOT NULL UNIQUE,
  icono            VARCHAR(80) NOT NULL
);

-- 5. Tabla intermedia N:M Locales <-> Categorías con atributos propios
CREATE TABLE locales_categorias (
  local_id               VARCHAR(36) NOT NULL,
  categoria_id           INTEGER     NOT NULL,
  es_categoria_principal BOOLEAN     NOT NULL,
  fecha_asignacion       TIMESTAMP   NOT NULL,
  PRIMARY KEY (local_id, categoria_id),
  CONSTRAINT fk_lc_local FOREIGN KEY (local_id)
    REFERENCES locales (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_lc_categoria FOREIGN KEY (categoria_id)
    REFERENCES categorias (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. Productos y combos por local
CREATE TABLE productos (
  id              VARCHAR(36)    PRIMARY KEY,
  local_id        VARCHAR(36)    NOT NULL,
  nombre_producto VARCHAR(100)   NOT NULL,
  descripcion     VARCHAR(300)   NOT NULL,
  precio_regular  NUMERIC(10, 2) NOT NULL,
  foto_url        VARCHAR(255)   NULL,
  disponible      BOOLEAN        NOT NULL,
  CONSTRAINT fk_productos_local FOREIGN KEY (local_id)
    REFERENCES locales (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_productos_precio CHECK (precio_regular > 0)
);

-- 7. Promociones comerciales con límite de cupos
CREATE TABLE promociones (
  id            VARCHAR(36)    PRIMARY KEY,
  local_id      VARCHAR(36)    NOT NULL,
  producto_id   VARCHAR(36)    NOT NULL,
  titulo_oferta VARCHAR(120)   NOT NULL,
  precio_oferta NUMERIC(10, 2) NOT NULL,
  cupo_maximo   INTEGER        NOT NULL,
  cupos_usados  INTEGER        NOT NULL,
  fecha_inicio  TIMESTAMP      NOT NULL,
  fecha_fin     TIMESTAMP      NOT NULL,
  estado        VARCHAR(20)    NOT NULL,
  CONSTRAINT fk_promociones_local FOREIGN KEY (local_id)
    REFERENCES locales (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_promociones_producto FOREIGN KEY (producto_id)
    REFERENCES productos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_promociones_precio CHECK (precio_oferta > 0),
  CONSTRAINT ck_promociones_cupos CHECK (cupo_maximo > 0 AND cupos_usados >= 0 AND cupos_usados <= cupo_maximo),
  CONSTRAINT ck_promociones_fechas CHECK (fecha_fin > fecha_inicio),
  CONSTRAINT ck_promociones_estado CHECK (estado IN ('BORRADOR', 'ACTIVA', 'PAUSADA', 'AGOTADA', 'VENCIDA'))
);

-- 8. Entidad débil: Franjas horarias relámpago dependientes de la promoción
CREATE TABLE horarios_promocion (
  id           VARCHAR(36) PRIMARY KEY,
  promocion_id VARCHAR(36) NOT NULL,
  dia_semana   INTEGER     NOT NULL,
  hora_inicio  VARCHAR(5)  NOT NULL,
  hora_fin     VARCHAR(5)  NOT NULL,
  CONSTRAINT fk_hp_promocion FOREIGN KEY (promocion_id)
    REFERENCES promociones (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_hp_dia CHECK (dia_semana BETWEEN 1 AND 7),
  CONSTRAINT ck_hp_horas CHECK (hora_fin > hora_inicio)
);

-- 9. Cupones emitidos con código único y expiración de 2 horas
CREATE TABLE cupones (
  id               VARCHAR(36) PRIMARY KEY,
  promocion_id     VARCHAR(36) NOT NULL,
  usuario_id       VARCHAR(36) NOT NULL,
  codigo_unico     VARCHAR(16) NOT NULL UNIQUE,
  fecha_emision    TIMESTAMP   NOT NULL,
  fecha_expiracion TIMESTAMP   NOT NULL,
  estado           VARCHAR(20) NOT NULL,
  CONSTRAINT fk_cupones_promocion FOREIGN KEY (promocion_id)
    REFERENCES promociones (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_cupones_usuario FOREIGN KEY (usuario_id)
    REFERENCES usuarios (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_cupones_fechas CHECK (fecha_expiracion > fecha_emision),
  CONSTRAINT ck_cupones_estado CHECK (estado IN ('EMITIDO', 'REDIMIDO', 'VENCIDO'))
);

-- 10. Redenciones presenciales (1:1 estricto con cupones vía UNIQUE)
CREATE TABLE redenciones (
  id                VARCHAR(36)    PRIMARY KEY,
  cupon_id          VARCHAR(36)    NOT NULL UNIQUE,
  cajero_id         VARCHAR(36)    NOT NULL,
  local_id          VARCHAR(36)    NOT NULL,
  fecha_hora_canje  TIMESTAMP      NOT NULL,
  monto_descontado  NUMERIC(10, 2) NOT NULL,
  metodo_validacion VARCHAR(20)    NOT NULL,
  CONSTRAINT fk_redenciones_cupon FOREIGN KEY (cupon_id)
    REFERENCES cupones (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_redenciones_cajero FOREIGN KEY (cajero_id)
    REFERENCES usuarios (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_redenciones_local FOREIGN KEY (local_id)
    REFERENCES locales (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_redenciones_monto CHECK (monto_descontado >= 0),
  CONSTRAINT ck_redenciones_metodo CHECK (metodo_validacion IN ('QR', 'MANUAL'))
);

-- 11. Bitácora inmutable de auditoría
CREATE TABLE auditoria_logs (
  id             VARCHAR(36)  PRIMARY KEY,
  usuario_id     VARCHAR(36)  NOT NULL,
  redencion_id   VARCHAR(36)  NULL,
  accion         VARCHAR(60)  NOT NULL,
  detalle        VARCHAR(400) NOT NULL,
  ip_origen      VARCHAR(45)  NOT NULL,
  fecha_registro TIMESTAMP    NOT NULL,
  CONSTRAINT fk_auditoria_usuario FOREIGN KEY (usuario_id)
    REFERENCES usuarios (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_auditoria_redencion FOREIGN KEY (redencion_id)
    REFERENCES redenciones (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Índices B-Tree de soporte al filtro por presupuesto (RF07) y validación en caja (RNF01)
CREATE INDEX idx_cupones_codigo_unico ON cupones (codigo_unico);
CREATE INDEX idx_productos_precio_regular ON productos (precio_regular);
CREATE INDEX idx_promociones_estado_fechas ON promociones (estado, fecha_inicio, fecha_fin);

-- =============================================================================
-- Datos de prueba mínimos para verificar integridad referencial
-- =============================================================================
INSERT INTO roles (id, nombre, descripcion) VALUES
  (1, 'VISITANTE', 'Consumidor en centro comercial'),
  (2, 'LOCATARIO', 'Administrador de local comercial'),
  (3, 'CAJERO', 'Operador de validacion en caja');

INSERT INTO locales (id, nombre_comercial, numero_local, telefono_contacto, horario_atencion, logo_url, estado_operativo) VALUES
  ('11111111-1111-4111-8111-111111111111', 'Asados Plazoleta SPP', 'PC-04', '3000000001', '11:00 - 21:00', NULL, 'ACTIVO');

INSERT INTO categorias (id, nombre_categoria, icono) VALUES
  (1, 'Parrilla', 'flame-icon'),
  (2, 'Comidas Rápidas', 'burger-icon');

INSERT INTO locales_categorias (local_id, categoria_id, es_categoria_principal, fecha_asignacion) VALUES
  ('11111111-1111-4111-8111-111111111111', 1, TRUE, '2026-11-26 10:00:00');

INSERT INTO usuarios (id, rol_id, local_id, nombre_completo, correo, hash_contrasena, sal_contrasena, estado_cuenta, autoriza_datos, fecha_registro) VALUES
  ('22222222-2222-4222-8222-222222222222', 1, NULL, 'Visitante Prueba', 'visitante.demo@ejemplo.local', '$argon2id$v=19$m=65536,t=3,p=1$hash_demo', 'sal_aleatoria_16ch', 'ACTIVO', TRUE, '2026-11-26 10:05:00'),
  ('33333333-3333-4333-8333-333333333333', 3, '11111111-1111-4111-8111-111111111111', 'Cajero Prueba', 'cajero.demo@ejemplo.local', '$argon2id$v=19$m=65536,t=3,p=1$hash_demo2', 'sal_aleatoria_caj1', 'ACTIVO', TRUE, '2026-11-26 10:06:00');

INSERT INTO productos (id, local_id, nombre_producto, descripcion, precio_regular, foto_url, disponible) VALUES
  ('44444444-4444-4444-8444-444444444444', '11111111-1111-4111-8111-111111111111', 'Combo Punta de Anca + Bebida', 'Porcion de carne a la parrilla con papa salada y gaseosa', 26000.00, NULL, TRUE);

INSERT INTO promociones (id, local_id, producto_id, titulo_oferta, precio_oferta, cupo_maximo, cupos_usados, fecha_inicio, fecha_fin, estado) VALUES
  ('55555555-5555-4555-8555-555555555555', '11111111-1111-4111-8111-111111111111', '44444444-4444-4444-8444-444444444444', 'Hora Valle Parrilla', 18000.00, 30, 1, '2026-11-26 08:00:00', '2026-12-05 22:00:00', 'ACTIVA');

INSERT INTO horarios_promocion (id, promocion_id, dia_semana, hora_inicio, hora_fin) VALUES
  ('66666666-6666-4666-8666-666666666666', '55555555-5555-4555-8555-555555555555', 2, '14:30', '17:30');

INSERT INTO cupones (id, promocion_id, usuario_id, codigo_unico, fecha_emision, fecha_expiracion, estado) VALUES
  ('77777777-7777-4777-8777-777777777777', '55555555-5555-4555-8555-555555555555', '22222222-2222-4222-8222-222222222222', 'SPP-7F2A9B', '2026-11-26 15:00:00', '2026-11-26 17:00:00', 'REDIMIDO');

INSERT INTO redenciones (id, cupon_id, cajero_id, local_id, fecha_hora_canje, monto_descontado, metodo_validacion) VALUES
  ('88888888-8888-4888-8888-888888888888', '77777777-7777-4777-8777-777777777777', '33333333-3333-4333-8333-333333333333', '11111111-1111-4111-8111-111111111111', '2026-11-26 15:18:00', 8000.00, 'QR');

INSERT INTO auditoria_logs (id, usuario_id, redencion_id, accion, detalle, ip_origen, fecha_registro) VALUES
  ('99999999-9999-4999-8999-999999999999', '33333333-3333-4333-8333-333333333333', '88888888-8888-4888-8888-888888888888', 'CANJE_CUPON_EXITOSO', 'Cupon SPP-7F2A9B redimido correctamente en caja', '192.168.10.24', '2026-11-26 15:18:00');
