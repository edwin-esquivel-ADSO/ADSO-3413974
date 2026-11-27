# A6. Vista de Despliegue y Condiciones de Implantación

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Archivos del Diagrama de Despliegue

* **Fuente editable (Draw.io):** [`06-vista-despliegue.drawio`](./06-vista-despliegue.drawio)
* **Imagen vectorial exportada (SVG):** [`06-vista-despliegue.svg`](./06-vista-despliegue.svg)

---

## 2. Topología de Nodos, Artefactos, Protocolos y Respaldo a RNF (Rúbrica G2 · Criterio 6)

El despliegue separa físicamente la experiencia en navegadores del centro comercial, el servidor de aplicación y el motor de base de datos aislado en red privada (4 nodos en total, superando el mínimo de 3 nodos exigido):

| # | Nodo de Despliegue | Artefactos Alojados | Conexión (Protocolo y Puerto) | Decisión de Despliegue que Responde a un RNF |
| :-: | :--- | :--- | :--- | :--- |
| **1** | **Nodo Cliente** *(Teléfonos de Visitantes, PC/Móvil de Locatarios y Caja)* | • `AppWebVisitanteLocatario` (PWA Next.js)<br>• `ValidadorCajaUI` (lector QR cámara + código manual) | Se conecta únicamente al **Nodo Aplicación** mediante **HTTPS sobre TLS 1.3 (Puerto `443`)** | **RNF02 y RNF05:** Todo tráfico con correos, contraseñas o códigos de cupón viaja cifrado por TLS; al ser web responsiva no exige instalación desde tiendas nativas y permite reintentar sin perder sesión (`RNF08`). |
| **2** | **Nodo Servidor de Aplicación** *(Contenedor Linux · Node.js / TypeScript)* | • `ServicioAutenticacionSeguridad`<br>• `ServicioCatalogoPromociones`<br>• `MotorCuponesCanje` (`FachadaCanjeMostrador`)<br>• Reloj oficial sincronizado (`NTP`) | • Expone API REST en **HTTPS Puerto `443`** hacia el Cliente.<br>• Consume datos hacia el **Nodo Datos** por subred privada **TCP/TLS Puerto `5432`** | **RNF01, RNF06 y RN-05:** Mantiene pool persistente de conexiones hacia PostgreSQL para validar cupones en $\le 1.5\text{ s}$ (`RNF01`), garantiza disponibilidad en horario de 8:00 a. m. a 10:00 p. m. (`RNF06`) y centraliza la hora oficial del servidor para evitar fraudes por cambio de reloj en celulares. |
| **3** | **Nodo Base de Datos** *(Motor PostgreSQL en Red Privada Aislada)* | • `CapaAccesoDatosAuditoria`<br>• Base de datos relacional `nuvora_db` (11 tablas 3FN + índices B-Tree + `auditoria_logs`) | • Acepta **exclusivamente** tráfico interno desde el Nodo Aplicación por **TCP/TLS Puerto `5432`**.<br>• Sin IP pública ni exposición a Internet | **RNF02 y RNF04:** Bloquea cualquier acceso directo externo al motor de datos (`firewall` solo permite el puerto `5432` interno) y ejecuta transacciones `SELECT ... FOR UPDATE` para impedir doble redención simultánea (`RNF04`). |
| **4** | **Nodo Respaldo Cifrado** *(Almacenamiento Externo)* | • Copias automáticas diarias (`pg_dump` cifrado AES-256)<br>• Actas de prueba de restauración mensual | Recibe volcados programados desde el Nodo Datos vía **SFTP / SSH (Puerto `22`)** | **RNF06 (Disponibilidad y Recuperación):** Asegura continuidad operativa y recuperación ante fallos de disco sin perder historial de cupones ni auditorías de San Pedro Plaza. |
