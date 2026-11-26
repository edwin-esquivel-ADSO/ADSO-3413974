# A4. Arquitectura del Software y Decisiones frente a los RNF

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Archivos del Diagrama de Arquitectura

* **Fuente editable (Draw.io):** [`04-arquitectura-software.drawio`](./04-arquitectura-software.drawio)
* **Imagen vectorial exportada (SVG):** [`04-arquitectura-software.svg`](./04-arquitectura-software.svg)

---

## 2. Estilo Arquitectónico Definido y Comunicación

* **Estilo seleccionado:** **Arquitectura en Tres Capas Estricta (Cliente-Servidor Web)**.
  1. **Capa de Presentación (React / Next.js Responsivo):** Renderiza las vistas móviles del Visitante (directorio, filtro por presupuesto, billetera QR), el panel administrativo del Locatario y la pantalla de lectura de caja del Cajero. **Regla estricta:** no contiene reglas de negocio ni consultas a base de datos.
  2. **Capa de Lógica de Negocio (API Node.js / TypeScript):** Aloja los controladores HTTP, la autenticación JWT/sesión por rol, el catálogo con filtro presupuestal, `IEstrategiaVigencia` y `FachadaCanjeMostrador`. **Es la única capa autorizada** para validar horarios contra el reloj oficial del servidor (`RN-05`) y comunicarse con la capa de datos.
  3. **Capa de Persistencia / Datos (Repositorios + PostgreSQL):** Ejecuta las consultas SQL parametrizadas y gestiona las transacciones ACID (`SELECT ... FOR UPDATE`), restricciones `UNIQUE`/`CHECK` e integridad referencial de las 11 tablas del sistema.
* **Regla de no salto de capas:** La Capa de Presentación **nunca** se conecta directamente a PostgreSQL ni a la Capa de Datos; toda petición atraviesa obligatoriamente la Capa de Lógica de Negocio (`Presentación -> Lógica de Negocio -> Datos`).
* **Estilo de comunicación entre capas:**
  * **Presentación $\leftrightarrow$ Lógica de Negocio:** Peticiones síncronas **REST API sobre HTTPS (puerto `443`)** con carga en formato **JSON** y encabezado de autorización por token de sesión (`Bearer`).
  * **Lógica de Negocio $\leftrightarrow$ Datos:** Pool de conexiones TCP seguras (**TLS, puerto `5432`**) con sentencias preparadas (*Prepared Statements*) y bloques transaccionales `BEGIN ... COMMIT/ROLLBACK`.

---

## 3. Tabla de Decisiones Arquitectónicas frente a los RNF (Rúbrica G2 · Criterio 4)

| RNF / Aspecto | Decisión de Diseño Arquitectónico | Alternativa Descartada | Razón Concreta del Descarte |
| :--- | :--- | :--- | :--- |
| **RNF01** *(Respuesta en caja $\le 1.5\text{ s}$)* | Índices B-Tree sobre `cupones(codigo_unico)` y `productos(precio_regular)`, más consulta directa optimizada dentro de `FachadaCanjeMostrador` en una sola transacción SQL. | Arquitectura de microservicios distribuidos en contenedores separados por cada módulo con mensajería asíncrona para validar cupones. | Un esquema de microservicios distribuidos introduce saltos adicionales de red y latencia de serialización innecesarios para un equipo de 3 desarrolladores y un solo centro comercial, poniendo en riesgo el límite de $1.5\text{ s}$. |
| **RNF02** *(Seguridad: hash y sal + TLS)* | Middleware centralizado de autenticación y autorización por rol (`RBAC`) en la Capa de Lógica de Negocio; contraseñas procesadas con **hash y sal** (Argon2id/bcrypt) y tráfico web obligatorio por HTTPS/TLS. | Validar permisos de rol (`Locatario` / `Cajero`) únicamente ocultando botones en la interfaz React/Next.js. | Ocultar elementos en el navegador es inseguro porque cualquier usuario técnico puede invocar directamente el endpoint del servidor si la capa de negocio no valida el rol y el `local_id`. |
| **RNF04** *(Cero doble redención simultánea)* | Bloqueo transaccional pesimista (`SELECT ... FOR UPDATE`) y restricción `UNIQUE` en `redenciones(cupon_id)` directamente dentro de PostgreSQL. | Verificar en memoria de la aplicación Node.js si el cupón ya fue usado sin bloqueo de fila en base de datos. | Ante dos cajeros escaneando el mismo QR en el mismo milisegundo (condición de carrera), la validación solo en memoria permite que ambos lean `Emitido` antes de escribir, violando la regla `RN-04`. |
| **RNF07** *(Mantenibilidad en 3 capas)* | Separación estricta de carpetas y módulos: Presentación (vistas UI), Lógica de Negocio (servicios, fachada y estrategias) y Datos (repositorios SQL), prohibiendo saltos de capa. | Monolito acoplado donde los componentes visuales arman consultas SQL directas contra la base de datos. | Mezclar interfaz con SQL impide probar reglas de negocio de forma independiente, expone credenciales de base de datos y dificulta el mantenimiento paralelo entre los 3 aprendices. |
| **RNF09** *(Ley 1581 Habeas Data y auditoría)* | Registro obligatorio de aceptación booleana (`autoriza_datos = TRUE`) en capa de negocio antes de persistir un visitante, y tabla `auditoria_logs` de solo inserción (`INSERT`) para trazabilidad de canjes. | Almacenar aceptación implícita solo en un aviso visual temporal (*cookie banner*) sin persistir fecha/estado en base de datos. | Sin columna validada por restricción en la base de datos ni traza de auditoría, el comercio carece de evidencia legal verificable del consentimiento informado. |
