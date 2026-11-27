# B6. Políticas de Seguridad de los Datos y Matriz de Roles

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 2:** Modelo de Datos y Verificación (`G2-P2`)

---

## 1. Políticas Concretas de Seguridad (Integridad, Confidencialidad y Disponibilidad)

Se definen **9 políticas verificables** (3 por cada principio, superando el mínimo de 6 políticas exigido en `Rubricas_G2.md`):

| ID | Principio | Política Concreta Aplicada al Caso Nuvora | Mecanismo en Tablas / Arquitectura |
| :-: | :--- | :--- | :--- |
| **POL-01** | **Integridad** | **Unicidad y bloqueo ante doble canje:** ningún cupón puede aplicarse dos veces ni en un local distinto al de su promoción. | `redenciones.cupon_id UNIQUE`, verificación de `cajero.local_id = promocion.local_id` y bloqueo transaccional `SELECT ... FOR UPDATE`. |
| **POL-02** | **Integridad** | **Validación estructural de precios, cupos y vigencias:** se prohíben valores negativos, cupos excedidos y fechas invertidas en el motor de datos. | Restricciones `CHECK` en `productos.precio_regular > 0`, `promociones.cupos_usados <= cupo_maximo`, `fecha_fin > fecha_inicio` y llaves foráneas con `ON DELETE RESTRICT`. |
| **POL-03** | **Integridad** | **Trazabilidad inmutable de redenciones:** toda operación de canje queda registrada con autor, hora del servidor, dirección IP y detalle, sin permisos de borrado ni edición operativa. | Tabla `auditoria_logs` con permiso único `INSERT` para el servicio de aplicación (cero `UPDATE`/`DELETE` en capa operativa). |
| **POL-04** | **Confidencialidad** | **Protección de contraseñas con hash y sal:** las claves de acceso jamás se almacenan en texto plano ni con cifrado reversible; cada usuario recibe una sal aleatoria única y algoritmo resistente a fuerza bruta (Argon2id/bcrypt). | Columnas separadas `usuarios.hash_contrasena` y `usuarios.sal_contrasena` (`CHECK LENGTH >= 16`) procesadas en `ServicioAutenticacionSeguridad`. |
| **POL-05** | **Confidencialidad** | **Cifrado en tránsito y columnas sensibles:** todo intercambio entre navegador, servidor y base de datos viaja exclusivamente por canales cifrados; el correo y los códigos de cupón nunca se exponen entre locales distintos. | Tráfico Cliente $\rightarrow$ App por **HTTPS (TLS 1.3 :443)** y App $\rightarrow$ BD por **TCP/TLS (:5432)**; consultas filtradas por `usuario_id` o `local_id` del token. |
| **POL-06** | **Confidencialidad** | **Aislamiento de red del motor de datos:** la base de datos permanece en subred privada sin IP pública, aceptando conexiones únicamente del servidor de aplicación con credenciales mínimas. | Regla de firewall en `Nodo Datos` (solo puerto `5432` interno hacia `Nodo Aplicación`). |
| **POL-07** | **Disponibilidad** | **Respaldo automático diario cifrado:** cada madrugada (2:00 a. m., fuera de horario comercial) se ejecuta un volcado completo cifrado (`pg_dump` + AES-256) replicado en el nodo externo. | Transferencia programada vía **SFTP :22** hacia `Nodo Respaldo Cifrado` con retención mínima de 30 días. |
| **POL-08** | **Disponibilidad** | **Prueba mensual de restauración verificada:** el primer domingo de cada mes se restaura un respaldo en ambiente de pruebas verificando integridad de llaves y conteo de filas, levantando acta de resultado. | Procedimiento documentado de recuperación (`RTO <= 30 min`) para respaldar `RNF06` ($\ge 99.0\%$). |
| **POL-09** | **Disponibilidad** | **Optimización de índices para evitar bloqueos lentos en caja:** consultas frecuentes en hora pico (almuerzos) mantienen tiempos de respuesta inferiores a $1.5\text{ s}$ (`RNF01`). | Índices B-Tree `idx_cupones_codigo_unico` y `idx_productos_precio_regular`, más pool persistente de conexiones. |

---

## 2. Tratamiento de Datos Personales (Ley 1581 de 2012 — Habeas Data Colombia)

* **Finalidad declarada:** Los datos recolectados en `usuarios` (`nombre_completo`, `correo`) se usan exclusivamente para autenticar la sesión, gestionar la billetera personal de cupones (`CU-06`) y prevenir fraude o duplicidad de canjes (`RN-01`, `RN-04`). No se ceden a terceros ni se usan para cobros bancarios.
* **Autorización previa explícita (`RNF09`):** Todo registro requiere marcación afirmativa en `usuarios.autoriza_datos = TRUE` junto con `fecha_registro`. Si no existe aceptación, el sistema rechaza la creación de cuenta.
* **Derechos del titular (Acceso, Rectificación, Supresión):** El usuario puede consultar sus datos y solicitar la desactivación o anonimización de su cuenta (`estado_cuenta = 'BLOQUEADO'`) conservando únicamente referencias anonimizadas en `auditoria_logs` si existieron redenciones fiscales previas.

---

## 3. Matriz de Permisos: Roles vs. Tablas del Modelo (4 Roles $\times$ 11 Tablas)

| Tabla | `Visitante` | `Locatario` | `Cajero` | `AdminSistema / Auditor` |
| :--- | :--- | :--- | :--- | :--- |
| **`roles`** | `SELECT` | `SELECT` | `SELECT` | `SELECT` |
| **`locales`** | `SELECT` *(solo activos)* | `SELECT`, `UPDATE` *(solo su `local_id`)* | `SELECT` *(solo su `local_id`)* | `SELECT`, `INSERT`, `UPDATE` |
| **`usuarios`** | `SELECT`, `UPDATE` *(solo su propia fila)* | `SELECT`, `UPDATE` *(solo su perfil y cajeros de su `local_id`)* | `SELECT` *(solo su propia fila)* | `SELECT`, `UPDATE` *(gestión de estado, sin ver contraseñas)* |
| **`categorias`** | `SELECT` | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` |
| **`locales_categorias`** | `SELECT` | `SELECT`, `INSERT`, `DELETE` *(solo su `local_id`)* | `SELECT` | `SELECT`, `INSERT`, `DELETE` |
| **`productos`** | `SELECT` *(solo disponibles)* | `SELECT`, `INSERT`, `UPDATE` *(solo su `local_id`)* | `SELECT` *(solo su `local_id`)* | `SELECT` |
| **`promociones`** | `SELECT` *(solo `ACTIVA`)* | `SELECT`, `INSERT`, `UPDATE` *(solo su `local_id`)* | `SELECT` *(solo su `local_id`)* | `SELECT` |
| **`horarios_promocion`** | `SELECT` *(solo activas)* | `SELECT`, `INSERT`, `UPDATE`, `DELETE` *(solo sus promos)* | `SELECT` *(solo su `local_id`)* | `SELECT` |
| **`cupones`** | `SELECT`, `INSERT` *(solo los suyos, max 1/24h)* | `SELECT` *(conteo agregado de su local)* | `SELECT`, `UPDATE` *(solo `estado` al canjear en su local)* | `SELECT` |
| **`redenciones`** | `SELECT` *(solo los de sus cupones)* | `SELECT` *(solo las de su `local_id`)* | `SELECT`, `INSERT` *(solo en su `local_id`)* | `SELECT` |
| **`auditoria_logs`** | *(Sin acceso)* | `SELECT` *(solo eventos de su local)* | `INSERT` *(automático vía Fachada al redimir)* | `SELECT`, `INSERT` *(prohibido `UPDATE`/`DELETE`)* |
