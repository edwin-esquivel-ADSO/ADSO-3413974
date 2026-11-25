# 01. Caracterización de la Solución de Software

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — SENA Regional Huila  
**Proyecto Formativo:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)  
**Autor:** Edwin Alejandro Esquivel Bahamón (`edwin-esquivel-ADSO`) — Líder Técnico, Backend & Base de Datos  
**Equipo de Desarrollo:** Edwin Esquivel, Jose Covaleda, Paula Claros  
**Instructores de Seguimiento:** Instructora Karol Correa (Técnica y Curricular) · Instructor Jesús Ariel González Bonilla (Planificación y Gestión Ágil)  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 1:** Plan de Análisis y Casos de Uso (G1-P1)  

---

## 1. Contexto y Descripción del Negocio

**Nuvora** es una solución de software diseñada como una aplicación web responsiva adaptada principalmente para teléfonos celulares, creada para dinamizar el comercio y la plazoleta de comidas en centros comerciales, tomando como escenario piloto el **Centro Comercial San Pedro Plaza** de la ciudad de Neiva (Huila).

El proyecto nace del estudio de campo y encuestas realizadas en San Pedro Plaza (35 visitantes, 4 administradores de locales comerciales y 2 cajeros en punto de atención), donde encontramos tres problemas principales:
1. El **88.6% de los volantes de papel impresos que entregan en las entradas terminan en la basura** a los pocos minutos.
2. El **82.9% de los visitantes no conoce las ofertas del día** al momento de entrar al centro comercial.
3. El **77.1% de las personas que van a comer a la plazoleta deciden qué almorzar según un presupuesto fijo de dinero** que traen en el bolsillo.

Nuvora resuelve esta situación mediante cuatro funciones principales:
1. **Directorio de Locales y Filtro por Presupuesto:** El visitante puede ver los menús y combos de los restaurantes de San Pedro Plaza desde su celular, e ingresar cuánto dinero tiene disponible (por ejemplo, $18.000 COP) para que el sistema le muestre al instante qué opciones de comida le alcanzan ("¿Qué comer con mi presupuesto?").
2. **Promociones Relámpago en Horarios Valle:** Los dueños de los locales pueden publicar ofertas con cupos limitados en días y horas específicas donde casi no hay ventas (por ejemplo, de martes a jueves de 2:30 p.m. a 5:30 p.m.).
3. **Billetera de Cupones con Código QR:** El usuario solicita la promoción y el sistema le genera un código alfanumérico aleatorio único en formato QR con un tiempo límite de 2 horas para ir a reclamarlo.
4. **Validación Rápida en Caja (menos de 1.5 segundos):** El cajero del restaurante escanea el código QR desde su celular o digita el código en pantalla, y el sistema valida en la base de datos que el cupón sea auténtico y lo marca como canjeado de inmediato para que nadie pueda usar el mismo descuento dos veces.

---

## 2. Cuatro Aspectos Fundamentales de Caracterización (Rúbrica G1 · Criterio C1)

Para cumplir con el Criterio C1 de la rúbrica de evaluación (RAP 592375), se caracterizan los cuatro aspectos principales del proyecto Nuvora:

| Aspecto | Caracterización Concreta del Proyecto Nuvora | Impacto en el Análisis y Desarrollo |
| :--- | :--- | :--- |
| **1. Tipo de Proyecto** | **Aplicación Web Responsiva adaptada para Celulares con Arquitectura en Capas.**<br>• **Tecnologías:** Interfaz en React / Next.js adaptada para móviles, lógica del servidor en Node.js con TypeScript, y base de datos relacional PostgreSQL organizada en tablas normalizadas.<br>• **Control de Seguridad y Cupones:** Emisión y canje de cupones con validación directa en la base de datos para impedir duplicados, control de horas contra el reloj del servidor (para que nadie altere la hora de su celular para pedir ofertas vencidas) y almacenamiento seguro de contraseñas con cifrado.<br>• **Modelo Operativo:** Canje presencial directo en el mostrador del restaurante o local (sin servicio de domicilios y sin pagos bancarios en línea). | Exige definir reglas de negocio claras (RN-01 a RN-07), estados definidos para cada cupón (Emitido, Redimido, Vencido) y pantallas sencillas y rápidas para que el cajero no demore la fila de atención. |
| **2. Tamaño del Equipo** | **Equipo de 3 Aprendices Desarrolladores ADSO:**<br>• **Edwin Alejandro Esquivel Bahamón (Líder Técnico):** Lógica del servidor, diseño de tablas en PostgreSQL, inicio de sesión seguro, control de canje en caja para evitar doble redención y registro de auditoría.<br>• **Jose Esneider Covaleda Hortua:** Panel administrativo para dueños de locales (crear productos y promociones) y pantalla de lectura QR para los cajeros.<br>• **Paula Sofia Claros Nañez:** Interfaz del visitante (catálogo de locales, filtro por presupuesto y billetera de cupones QR), diseño visual en Figma y análisis de requisitos. | Al ser un equipo pequeño de 3 personas, la comunicación es directa y continua, permitiendo coordinar tareas en el tablero ágil sin confusiones ni burocracia documental. |
| **3. Estabilidad de Requisitos** | **Requisitos Claros y Bien Delimitados (SRS v2.0):**<br>• **Ajuste guiado por los instructores:** Siguiendo la orientación de la Instructora Karol Correa, se descartó el modelo abierto de minimercados de barrio y domicilios, enfocando el proyecto en el Centro Comercial San Pedro Plaza.<br>• **Alcance Estable (20 Requisitos Funcionales):** Reglas fijas como máximo 1 cupón diario por persona, duración de 2 horas para reclamar el descuento y validación de que el cupón pertenezca al local correcto.<br>• **Exclusiones Justificadas:** Se dejan fuera pasarelas de pago bancarias y mensajería a domicilio para mantener el proyecto viable y enfocado en la ingeniería de software. | Permite trabajar con un cronograma ordenado y seguro, sin cambios imprevistos de última hora y con trazabilidad entre requisitos y diagramas. |
| **4. Disponibilidad del Cliente** | **Validación Directa con Usuarios y Comerciantes de Neiva:**<br>• **Participantes Consultados:** Comerciantes de la plazoleta (como don Carlos Méndez de *El Corralito Parrilla* y doña Martha Tovar de *Delicias del Huila*), cajeros en mostrador y visitantes consumidores (estudiantes de la USCO y empleados del sector).<br>• **Seguimiento Semanal:** Revisiones presenciales los sábados en el centro de formación con los instructores Karol Correa y Jesús Ariel, contrastando los avances contra la necesidad real de la plazoleta. | Permite revisar pantallas y casos de uso con retroalimentación rápida cada semana, asegurando que lo desarrollado resuelva el problema real del comercio. |

---

## 3. Delimitación del Alcance y Criterio Pedagógico SENA

El alcance del proyecto Nuvora se definió bajo dos decisiones prácticas de ingeniería:

1. **Sin Enredos de Domicilios:** A diferencia de una aplicación de entregas a domicilio (que requiere lidiar con mensajeros en moto, demoras de tráfico y paquetes perdidos), Nuvora aprovecha a las personas que ya están caminando dentro del centro comercial. El cliente ya está en el lugar; la aplicación solo le ayuda a decidir más rápido dónde comer y cómo ahorrar.
2. **Sin Comisiones Bancarias en Línea:** Al no cobrar por pasarelas de pago por internet, el equipo evita costos financieros por transacción bancaria y trámites comerciales con bancos. El cliente paga su comida en la caja del restaurante (en efectivo o datáfono del local). Nuvora se enfoca en lo que evalúa el SENA: **la lógica de negocio, el control de cupones en la base de datos y la seguridad del sistema**.