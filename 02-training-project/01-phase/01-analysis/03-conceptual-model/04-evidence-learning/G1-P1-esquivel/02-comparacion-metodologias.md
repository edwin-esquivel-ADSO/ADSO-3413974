# 02. Comparación y Selección Justificada de Metodologías de Desarrollo

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — SENA Regional Huila  
**Proyecto Formativo:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para Centros Comerciales (Caso Piloto: San Pedro Plaza, Neiva)  
**Autor:** Edwin Alejandro Esquivel Bahamón (`edwin-esquivel-ADSO`) — Líder Técnico, Backend & Base de Datos  
**Equipo de Desarrollo:** Edwin Esquivel, Jose Covaleda, Paula Claros  
**Instructores de Seguimiento:** Instructora Karol Correa (Técnica y Curricular) · Instructor Jesús Ariel González Bonilla (Planificación y Gestión Ágil)  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 1:** Plan de Análisis y Casos de Uso (G1-P1)  

---

## 1. Metodologías Analizadas

Para escoger la mejor forma de organizar el trabajo en equipo del proyecto **Nuvora**, comparamos tres metodologías conocidas en el desarrollo de software:

1. **Scrum (Marco Ágil por Ciclos Cortos):** Metodología de trabajo en equipo organizada en ciclos cortos (entregas de 1 a 2 semanas), donde el equipo se reúne a planear tareas, revisar avances y mostrar partes del software funcionando en cada entrega.
2. **RUP - Proceso Unificado Racional (Metodología Tradicional Estructurada):** Metodología pesada y muy formal que divide el proyecto en cuatro fases secuenciales (Inicio, Elaboración, Construcción y Transición), exigiendo una gran cantidad de documentos y diagramas antes de empezar a programar.
3. **XP - Programación Extrema (Metodología Ágil Enfocada en Código):** Metodología ágil centrada en la calidad directa del código mediante prácticas como programar en parejas, hacer pruebas continuas y mejorar el código sobre la marcha.

*(También se revisó el modelo RAD de desarrollo rápido, pero se descartó porque se enfoca en hacer prototipos visuales rápidos sin cuidar el orden de las bases de datos ni el control de concurrencia).*

---

## 2. Matriz Comparativa Basada en las Características de Nuvora (Rúbrica G1 · Criterios C1 y C2)

Comparamos las tres metodologías frente a las cuatro características principales del proyecto Nuvora:

| Criterio de Selección | Scrum (Marco Ágil) | RUP (Metodología Tradicional) | XP (Programación Extrema) | Aplicación Práctica en Nuvora |
| :--- | :--- | :--- | :--- | :--- |
| **1. Tamaño del Equipo** *(3 aprendices: Edwin, Jose y Paula)* | **Excelente:** Muy adecuada para equipos pequeños de 3 personas. Permite repartir el trabajo con claridad (Backend, Frontend de Locatarios y Frontend de Visitantes) sin burocracia ni trámites innecesarios. | **Inadecuada:** Demasiado pesada para 3 personas. Exige roles separados como analista de procesos, arquitecto, evaluador y jefe de cambios, lo cual complicaría el trabajo en un equipo formativo. | **Parcialmente viable:** Funciona bien en equipos pequeños, pero la regla de programar todo el tiempo de a dos personas en un solo computador reduciría la velocidad para construir los tres módulos a tiempo. | Scrum permite que los 3 integrantes avancemos en paralelo en nuestras áreas manteniendo reuniones diarias de sincronización. |
| **2. Disponibilidad del Cliente y Revisiones** *(Validación en San Pedro Plaza y clases en el SENA)* | **Excelente:** Las entregas de cada ciclo coinciden con las sesiones presenciales de los sábados en el ambiente de formación, permitiendo mostrar a los instructores y compañeros avances funcionales (catálogo, cupones QR y pantalla de caja). | **Regular:** Exige aprobaciones formales con documentos firmados al cierre de cada etapa que pueden tardar meses, desaprovechando las revisiones semanales de clase. | **Buena:** Permite revisiones rápidas, pero exige tener al cliente sentado todo el tiempo al lado del equipo, lo cual no es posible con los comerciantes de la plazoleta. | Scrum permite presentar software funcional cada dos semanas y ajustar detalles con la retroalimentación de los instructores. |
| **3. Manejo de Requisitos y Control de Cupones** *(Ofertas relámpago, horarios y validación rápida en caja)* | **Excelente:** La lista de tareas prioriza las reglas de negocio clave (como evitar que un cupón se use dos veces o fuera de horario), permitiendo probar y ajustar la base de datos en cada ciclo. | **Regular:** Muy detallada al inicio, pero rígida y lenta si se necesita ajustar una pantalla o un flujo detectado en las pruebas con los cajeros. | **Buena:** Buena para probar código rápido, pero descuida la documentación conceptual y los diagramas de base de datos que exige el SENA. | Scrum equilibra el diseño ordenado de la base de datos con la capacidad de ajustar detalles de las pantallas sobre la marcha. |
| **4. Carga de Documentación vs. Entrega de Software** *(Cumplimiento de las guías de aprendizaje)* | **Equilibrada:** Mantiene los diagramas y documentos necesarios (Casos de Uso, Diagramas de Actividades y Modelo Entidad-Relación) sin frenar la construcción del software. | **Muy Pesada:** Exige decenas de formatos y manuales que consumirían más de la mitad del tiempo del equipo, dejando poco espacio para programar. | **Muy Baja:** Reduce la documentación al mínimo diciendo que «el código es el documento», lo cual impediría cumplir las evidencias que califica el SENA. | Scrum da el punto exacto: asegura los diagramas de análisis que pide el instructor Jesús Ariel y garantiza que el software funcione. |

---

## 3. Metodología Seleccionada y Justificación Técnica (Rúbrica G1 · Criterio C2)

### Metodología Seleccionada: **Scrum con Prácticas de Ingeniería Ágil**

Seleccionamos formalmente **Scrum**, complementado con buenas prácticas técnicas de programación, como la metodología para guiar el análisis, diseño y desarrollo de **Nuvora**.

### Razones de la Elección:
1. **Alineación con el Cronograma de Clases:** Organizar el trabajo en ciclos cortos de 2 semanas nos permite revisar los avances con los instructores Karol Correa y Jesús Ariel, demostrando resultados concretos antes de las fechas límites.
2. **División Clara de Tareas en el Equipo:**
   * **Edwin Alejandro Esquivel Bahamón (Líder Técnico):** Lógica del servidor, diseño de tablas en PostgreSQL, inicio de sesión seguro y validación de cupones en caja para impedir duplicados.
   * **Jose Esneider Covaleda Hortua:** Panel administrativo para dueños de locales (crear promociones con horarios) e interfaz del cajero con lector de cámara.
   * **Paula Sofia Claros Nañez:** Diseño en Figma, catálogo de comidas, filtro por presupuesto monetario y billetera de cupones QR.
3. **Prácticas Técnicas de Apoyo:**
   * **Pruebas de Integración:** Pruebas para verificar que los cupones expiren a las 2 horas y que el sistema rechace si alguien intenta canjear el mismo código dos veces.
   * **Validación de Código:** Chequeo del código antes de unir cambios a la rama principal del repositorio para evitar que se dañe lo que ya funciona.
   * **Mejora Continua de Consultas:** Optimización de las consultas a la base de datos para que la respuesta en la pantalla del cajero tarde menos de 1.5 segundos.
4. **Por qué se descartaron las otras opciones:**
   * **Se descarta RUP:** Porque su exceso de trámites y documentos frenaría a un equipo de tres aprendices.
   * **Se descarta XP Puro:** Porque al no hacer diagramas previos no tendríamos los Casos de Uso ni los modelos de base de datos que califica el programa de formación ADSO.