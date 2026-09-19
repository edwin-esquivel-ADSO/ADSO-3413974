# Microservices Governance Framework

## Guía de estudio y presentación --- Carpetas 00, 01, 02, 03, 06 y 12

> **Objetivo:** comprender y explicar el hilo conductor de las carpetas
> seleccionadas del repositorio `microservices-governance-framework`, no
> memorizar documentos de forma aislada.

------------------------------------------------------------------------

# 1. ¿Qué es Microservices Governance?

## Definición sencilla

**Microservices Governance** es el conjunto de **reglas, principios,
estándares, decisiones y documentación** que permiten que un equipo
construya y mantenga un sistema basado en microservicios de manera
organizada, consistente y controlada.

Un sistema de microservicios divide una aplicación grande en **servicios
pequeños e independientes**, donde cada servicio tiene una
responsabilidad concreta y puede comunicarse con otros mediante
contratos como APIs o eventos.

La gobernanza no es un microservicio ni una aplicación. Es el **marco
que establece cómo se toman decisiones y cómo debe trabajar el equipo
alrededor de esos microservicios**.

## ¿Por qué existe la gobernanza?

Cuando varios desarrolladores trabajan sobre un sistema distribuido
pueden aparecer problemas:

-   Cada persona trabaja de una manera diferente.
-   Se utilizan nombres distintos para las mismas cosas.
-   Se crean microservicios con límites incorrectos.
-   Los datos quedan acoplados entre servicios.
-   El alcance del producto crece sin control.
-   Las decisiones técnicas no quedan documentadas.
-   La interfaz puede terminar desconectada de las necesidades reales
    del usuario.

La gobernanza busca reducir estos problemas mediante reglas y
documentación compartida.

## Idea para memorizar

> **Gobernanza = reglas comunes para que muchas personas puedan
> construir un sistema complejo de forma coherente.**

------------------------------------------------------------------------

# 2. ¿Qué es este repositorio?

El repositorio `microservices-governance-framework` es un **andamiaje de
documentación** para proyectos de microservicios. No contiene un sistema
de negocio específico; muestra **qué debe documentarse, por qué importa
y cómo se relacionan las diferentes partes de un proyecto**.

El repositorio organiza el proyecto en carpetas numeradas por secciones
y fases. `00-governance` funciona de manera transversal sobre todo el
proyecto. Las carpetas 01, 02 y 03 forman parte de la etapa inicial de
descubrimiento; 06 pertenece al diseño de datos; y 12 corresponde al
diseño UX/UI.

> **Importante:** para esta presentación solamente se estudian las
> carpetas **00, 01, 02, 03, 06 y 12**. No es necesario explicar las
> demás carpetas.

------------------------------------------------------------------------

# 3. Hilo conductor de las carpetas

La mejor manera de entenderlas no es como seis temas separados, sino
como una historia.

## La cadena principal

``` text
00 → 01 → 02 → 03 → 06 → 12

REGLAS
  ↓
CONTEXTO
  ↓
DOMINIO
  ↓
PRODUCTO
  ↓
DATOS
  ↓
USUARIO
```

### Preguntas que responde cada carpeta

  -----------------------------------------------------------------------
  Carpeta                 Pregunta principal      Palabra clave
  ----------------------- ----------------------- -----------------------
  **00 Governance**       ¿Cómo vamos a trabajar? **REGLAS**

  **01 Context**          ¿Qué problema tenemos y **CONTEXTO**
                          cuáles son sus límites? 

  **02 Domain**           ¿Cómo funciona el       **DOMINIO**
                          problema o negocio?     

  **03 Product**          ¿Qué vamos a construir  **PRODUCTO**
                          para resolverlo?        

  **06 Data**             ¿Cómo vamos a almacenar **DATOS**
                          y gestionar la          
                          información?            

  **12 UX/UI**            ¿Cómo lo experimentará  **USUARIO**
                          y utilizará el usuario? 
  -----------------------------------------------------------------------

## Frase para memorizar

> **Primero nos organizamos, después entendemos el problema, luego
> entendemos el dominio, definimos el producto, estructuramos los datos
> y finalmente diseñamos la experiencia del usuario.**

------------------------------------------------------------------------

# 4. 00 --- GOVERNANCE

## Palabra clave: REGLAS

### ¿Qué es?

Es la sección que define los **acuerdos que el equipo debe seguir
durante todo el proyecto**.

El repositorio indica que todos los integrantes deben conocer esta
sección antes de realizar su primer commit.

### ¿Qué problema resuelve?

Evita que cada integrante tenga una forma diferente de trabajar.

Por ejemplo:

``` text
Desarrollador A → commits de una forma
Desarrollador B → otra forma
Desarrollador C → otra estructura
```

La gobernanza busca:

``` text
Equipo
  ↓
Mismas reglas
  ↓
Trabajo consistente
```

## Documentos de la carpeta

### `git-conventions.md`

Define convenciones relacionadas con:

-   ramas;
-   commits;
-   Pull Requests;
-   merges.

**Git:** sistema de control de versiones que permite registrar y
coordinar cambios en el código.

**Commit:** registro de un conjunto de cambios realizados en el
proyecto.

**Branch/Rama:** línea independiente de trabajo dentro de Git.

**Pull Request:** propuesta para revisar e integrar cambios en otra
rama.

### `agile-conventions.md`

Define cómo se organiza el trabajo bajo prácticas ágiles:

-   sprints;
-   ceremonias;
-   estimaciones;
-   gestión del backlog.

**Sprint:** periodo corto de trabajo en el que el equipo desarrolla un
conjunto de objetivos.

**Agile:** enfoque de trabajo que busca entregar valor progresivamente y
adaptarse al cambio.

### `definition-of-done.md`

Define cuándo una tarea o historia puede considerarse realmente
terminada.

**Definition of Done (DoD):** conjunto de condiciones que deben
cumplirse para considerar un trabajo terminado.

Ejemplo conceptual:

``` text
Código realizado
+ revisado
+ probado
+ documentado
= terminado
```

### `definition-of-ready.md`

Define cuándo una historia está suficientemente preparada para entrar a
un sprint.

**Definition of Ready (DoR):** condiciones mínimas que debe cumplir una
tarea antes de ser tomada para desarrollo.

### `documentation-rules.md`

Establece cómo crear, modificar y eliminar documentación.

### `microservices-documentation.md`

Indica qué documentación debe existir para cada microservicio.

### `security-policy.md`

Define cómo manejar vulnerabilidades e incidentes de seguridad.

### `security-rules.md`

Establece reglas técnicas de seguridad, como:

-   protección de secretos;
-   autenticación;
-   validación de entradas.

## ¿Por qué 00 es transversal?

Porque no importa si estamos diseñando datos, producto o interfaz:
**todos los integrantes siguen las mismas reglas de trabajo**.

### Memorizar

> **00 = Cómo trabajamos.**

**Palabras clave:**

`Git · Agile · DoD · DoR · Documentación · Seguridad · Estándares`

------------------------------------------------------------------------

# 5. 01 --- CONTEXT

## Palabra clave: CONTEXTO

### ¿Qué es?

Define el **porqué del sistema**.

Antes de diseñar tecnología debemos saber:

-   qué problema se quiere solucionar;
-   para quién;
-   qué está dentro del alcance;
-   qué está fuera del alcance;
-   qué significan los términos utilizados.

### Pregunta principal

> **¿Qué problema estamos tratando de resolver y cuáles son los límites
> del proyecto?**

## Documentos

### `overview.md`

Es la descripción ejecutiva del sistema.

Debe permitir que una persona nueva entienda rápidamente:

-   qué es el sistema;
-   qué problema resuelve;
-   quiénes son sus usuarios principales;
-   qué tecnologías utiliza;
-   cuál es su estado actual.

### `scope.md`

Define los **límites del sistema**.

Separa:

-   **In Scope:** lo que sí forma parte del proyecto.
-   **Out of Scope:** lo que deliberadamente no forma parte.
-   **Future:** funcionalidades que podrían llegar después.

### Concepto: Scope Creep

**Scope Creep** es el crecimiento descontrolado del alcance.

Ejemplo:

``` text
Proyecto inicial:
Consultar horarios

↓ se agregan cosas sin control ↓

Horarios
+ pagos
+ chat
+ tienda
+ red social
+ videollamadas
```

El proyecto pierde foco.

### `glossary.md`

Es el diccionario del proyecto.

Define términos técnicos y de negocio con un significado preciso.

Esto es importante porque una palabra puede significar cosas diferentes
para distintas personas.

## Ejemplo

Si el proyecto utiliza la palabra:

> "Usuario"

el equipo debe determinar exactamente qué significa y a quién incluye.

## Memorizar

> **01 = ¿Qué problema tenemos, para quién y hasta dónde llega el
> sistema?**

**Palabras clave:**

`Problema · Usuarios · Alcance · Límites · Glosario`

------------------------------------------------------------------------

# 6. 02 --- DOMAIN

## Palabra clave: DOMINIO

### ¿Qué es?

Representa el **modelo mental del negocio o problema**.

No se centra todavía en tecnología. Primero busca entender cómo funciona
aquello que el software debe solucionar.

La carpeta utiliza conceptos de **Domain-Driven Design (DDD)**.

## DDD --- Domain-Driven Design

**Domain-Driven Design** es un enfoque de diseño de software que pone el
**dominio del negocio** en el centro del análisis y del diseño.

La idea fundamental es:

> **Primero entender correctamente el negocio; después convertir ese
> conocimiento en software.**

## ¿Por qué es importante?

Una mala comprensión del dominio puede provocar:

-   entidades incorrectas;
-   nombres que no coinciden con el negocio;
-   reglas mal implementadas;
-   límites incorrectos entre microservicios;
-   cambios costosos posteriormente.

------------------------------------------------------------------------

## Conceptos técnicos fundamentales

### Entity

Objeto del dominio que posee una **identidad única**.

Ejemplo:

``` text
Aprendiz
ID: 3413974
```

Aunque cambien algunos datos, sigue siendo el mismo aprendiz porque
conserva su identidad.

**Palabra clave:** identidad.

------------------------------------------------------------------------

### Value Object

Objeto definido por sus **atributos o valor**, no por una identidad
propia.

Ejemplos:

``` text
Dirección
Precio
Fecha
```

**Palabra clave:** valor.

------------------------------------------------------------------------

### Aggregate

Conjunto de objetos del dominio tratados como una **unidad**.

El aggregate tiene una **raíz (Aggregate Root)** que controla el acceso
al resto del conjunto.

**Palabra clave:** unidad.

------------------------------------------------------------------------

### Domain Event

Representa un hecho que **ya ocurrió en el negocio** y que puede ser
importante para otras partes del sistema.

Ejemplos:

``` text
StudentEnrolled
PaymentApproved
ScheduleChanged
```

Los eventos se expresan normalmente en pasado porque representan hechos.

**Palabra clave:** hecho.

------------------------------------------------------------------------

### Bounded Context

Es un límite dentro del dominio donde un determinado modelo y lenguaje
tienen un significado concreto.

Es uno de los conceptos más importantes para microservicios.

El repositorio indica que cada microservicio generalmente corresponde a
un Bounded Context.

**Palabra clave:** límite.

------------------------------------------------------------------------

## Documentos

### `domain-map.md`

Mapa de los Bounded Contexts y sus relaciones.

Permite visualizar:

``` text
Contexto A
   ↓
relación
   ↓
Contexto B
```

Puede documentar relaciones como:

-   upstream/downstream;
-   shared kernel;
-   anti-corruption layer.

### `entities-and-rules.md`

Define:

-   entidades;
-   value objects;
-   agregados;
-   identificadores;
-   reglas del negocio.

### `domain-events.md`

Define los eventos del dominio y su información.

## Relación con microservicios

``` text
Dominio
   ↓
Bounded Context
   ↓
Responsabilidad delimitada
   ↓
Posible microservicio
```

### Memorizar

> **02 = Entender el negocio antes de construir el software.**

**Palabras clave:**

`DDD · Entity · Value Object · Aggregate · Event · Bounded Context · Reglas`

------------------------------------------------------------------------

# 7. 03 --- PRODUCT

## Palabra clave: PRODUCTO

### ¿Qué es?

Define **qué se va a construir**.

No responde todavía cómo será la arquitectura interna. Responde:

> **¿Qué producto vamos a crear para solucionar el problema
> identificado?**

La carpeta funciona como un puente entre el problema y el plan de
construcción.

## ¿Por qué es importante?

Sin una definición clara del producto:

-   se pueden desarrollar funcionalidades innecesarias;
-   el alcance puede crecer sin control;
-   no existe una visión común;
-   es difícil medir el éxito.

## Documentos

### `problem-framing.md`

Define el problema antes de proponer una solución.

Pregunta:

-   ¿Quién tiene el problema?
-   ¿Qué problema tiene?
-   ¿Cuándo aparece?
-   ¿Qué impacto genera?
-   ¿Cómo se resuelve actualmente?
-   ¿Por qué vale la pena solucionarlo?

**Problem framing:** estructuración precisa del problema para evitar
diseñar una solución basada en suposiciones.

------------------------------------------------------------------------

### `discovery-brief.md`

Recoge resultados de investigación con usuarios:

-   entrevistas;
-   hallazgos;
-   supuestos validados;
-   supuestos invalidados.

**Discovery:** proceso de investigación para conocer y validar el
problema, las necesidades y las suposiciones antes de construir.

------------------------------------------------------------------------

### `vision.md`

Define la visión del producto.

Es el **norte** del producto:

> Para quién es, qué necesidad tiene, qué producto se propone y cuál es
> su beneficio diferencial.

**Product Vision:** declaración breve que expresa hacia dónde debe
dirigirse el producto.

------------------------------------------------------------------------

### `roadmap.md`

Organiza la evolución del producto a lo largo del tiempo.

Ejemplo:

``` text
Fase 1 → MVP
Fase 2 → Mejoras
Fase 3 → Nuevas funcionalidades
```

**Roadmap:** planificación de alto nivel de las etapas y entregas
futuras.

------------------------------------------------------------------------

### `product-backlog.md`

Lista priorizada de todo lo que debe construirse.

**Backlog:** conjunto ordenado de trabajos, funcionalidades o
necesidades pendientes.

## Historia de usuario

Una forma común de expresar una necesidad:

``` text
Como [usuario]
quiero [acción]
para [beneficio].
```

Ejemplo:

``` text
Como aprendiz,
quiero consultar mi horario,
para saber cuándo tengo clase.
```

## Diferencia clave

### 01 Context

> **¿Qué problema y contexto tenemos?**

### 02 Domain

> **¿Cómo funciona ese problema?**

### 03 Product

> **¿Qué producto construiremos para solucionarlo?**

### Memorizar

> **03 = Convertimos el problema entendido en una definición concreta de
> producto.**

**Palabras clave:**

`Problema · Discovery · Visión · Backlog · Roadmap · Valor`

------------------------------------------------------------------------

# 8. 06 --- DATA

## Palabra clave: DATOS

### ¿Qué es?

Define cómo el sistema:

-   almacena;
-   estructura;
-   organiza;
-   consulta;
-   mantiene;
-   migra

sus datos.

Esta sección pertenece a la fase de diseño.

## Principio fundamental de microservicios

> **Cada microservicio es dueño de sus propios datos.**

Esto significa que un servicio no debe entrar directamente a la base de
datos de otro servicio.

### Ejemplo incorrecto

``` text
Servicio A ──┐
Servicio B ──┼──→ Base de datos compartida
Servicio C ──┘
```

Esto aumenta el acoplamiento.

### Idea preferida

``` text
Servicio A → Datos A

Servicio B → Datos B

Servicio C → Datos C
```

Si un servicio necesita información de otro:

``` text
Servicio B
    ↓
 API / Evento
    ↓
Servicio A
```

Esto ayuda a conservar la independencia de los servicios.

------------------------------------------------------------------------

## Documentos

### `models.md`

Define los modelos de datos de cada microservicio.

Puede documentar:

-   motor de base de datos;
-   tablas o colecciones;
-   campos;
-   tipos;
-   restricciones;
-   claves;
-   índices;
-   justificación técnica.

Ejemplo conceptual:

``` text
Servicio: Scheduling

DB: PostgreSQL

Tabla: schedule

id
student_id
date
start_time
end_time
status
```

### `data-dictionary.md`

Explica el significado exacto de los campos importantes.

Ejemplo:

``` text
status = estado actual del horario
```

Esto evita ambigüedades.

### `modeling-conventions.md`

Define convenciones de modelado:

-   nombres;
-   UUID vs identificadores secuenciales;
-   timestamps;
-   eliminación lógica o física;
-   auditoría.

### `normalization-assessment.md`

Analiza la normalización y documenta las razones de una posible
desnormalización.

**Normalización:** organización de los datos para reducir redundancia y
problemas de consistencia.

**Desnormalización:** duplicación controlada de información para
conseguir beneficios como rendimiento o simplificación.

### `migration-strategy.md`

Define cómo evolucionar el esquema de datos entre versiones.

Una **migración** es un cambio controlado de la estructura de la base de
datos.

## Conceptos técnicos

### PK --- Primary Key

Identifica de forma única un registro.

### FK --- Foreign Key

Referencia un registro relacionado en otra tabla, cuando el modelo lo
requiere.

### Index

Estructura que permite acelerar determinadas consultas.

### Schema

Estructura que define cómo están organizados los datos.

## Relación con 02 Domain

Una entidad del dominio puede terminar siendo representada mediante
estructuras de datos.

``` text
02 DOMAIN
Entidad
   ↓
06 DATA
Modelo de datos
```

Pero no significa que una entidad tenga que convertirse automáticamente
en una tabla. El diseño de datos depende también de las reglas,
responsabilidades del servicio y necesidades técnicas.

### Memorizar

> **06 = Cómo organizamos y almacenamos la información respetando la
> propiedad de datos de cada microservicio.**

**Palabras clave:**

`Modelos · BD · Tablas · Campos · Índices · Migraciones · Data Ownership`

------------------------------------------------------------------------

# 9. 12 --- UX/UI

## Palabra clave: USUARIO

### ¿Qué es?

Define la experiencia del usuario:

-   cómo se ve el sistema;
-   cómo se navega;
-   qué pantallas existen;
-   quién puede acceder;
-   cómo se comportan las interfaces.

## UX vs UI

### UX --- User Experience

Es la **experiencia del usuario** al utilizar el sistema.

Pregunta:

> ¿La interacción es clara, lógica y útil?

### UI --- User Interface

Es la **interfaz visual** con la que interactúa el usuario.

Incluye:

-   botones;
-   formularios;
-   tablas;
-   tipografía;
-   colores;
-   componentes.

## Principio importante

> **Diseñar antes de programar.**

El repositorio explica que modificar un wireframe es mucho más barato
que modificar código, especialmente cuando el sistema ya está en
producción.

------------------------------------------------------------------------

## Documentos

### `navigation-map.md`

Define:

-   todas las pantallas;
-   cómo se conectan;
-   qué rutas existen;
-   qué roles pueden acceder.

Ejemplo:

``` text
LOGIN
  ↓
DASHBOARD
  ├── Horarios
  ├── Notificaciones
  └── Perfil
```

También puede existir una matriz de acceso:

  Pantalla           Usuario   Administrador
  ---------------- --------- ---------------
  Dashboard                ✓               ✓
  Perfil                   ✓               ✓
  Administración           ✗               ✓

### `wireframes.md`

Define la estructura de las pantallas antes del diseño visual final.

**Wireframe:** representación de baja fidelidad de una interfaz que
muestra principalmente estructura y distribución.

Ejemplo:

``` text
+--------------------------+
|          HEADER          |
+------------+-------------+
|   MENÚ     |  CONTENIDO  |
|            |             |
|            |    TABLA    |
+------------+-------------+
```

### `design-system.md`

Define reglas visuales reutilizables:

-   colores;
-   tipografía;
-   espaciado;
-   botones;
-   formularios;
-   tablas;
-   componentes.

**Design System:** conjunto organizado de reglas, componentes y patrones
visuales reutilizables que mantienen consistente la interfaz.

## Memorizar

> **12 = Cómo el usuario ve, recorre y utiliza el sistema.**

**Palabras clave:**

`UX · UI · Navegación · Wireframe · Roles · Design System · Componentes`

------------------------------------------------------------------------

# 10. EL HILO CONDUCTOR COMPLETO

Para presentar las seis carpetas, se puede contar una sola historia.

## Paso 1 --- 00: Nos organizamos

Antes de construir:

> ¿Cómo trabajaremos?

Definimos reglas, Git, seguridad, documentación y criterios para
considerar el trabajo listo.

↓

## Paso 2 --- 01: Entendemos el contexto

Después:

> ¿Qué problema tenemos?

Definimos usuarios, problema, alcance y lenguaje común.

↓

## Paso 3 --- 02: Entendemos el dominio

Después:

> ¿Cómo funciona realmente el problema?

Identificamos entidades, reglas, eventos, agregados y Bounded Contexts.

↓

## Paso 4 --- 03: Definimos el producto

Después:

> ¿Qué vamos a construir?

Validamos el problema, definimos visión, backlog y roadmap.

↓

## Paso 5 --- 06: Diseñamos los datos

Después:

> ¿Qué información necesita el sistema y cómo se almacenará?

Definimos modelos, estructuras, diccionario, convenciones y migraciones,
respetando la propiedad de datos de cada microservicio.

↓

## Paso 6 --- 12: Diseñamos la experiencia

Finalmente:

> ¿Cómo utilizará el usuario el sistema?

Definimos navegación, pantallas, wireframes y sistema de diseño.

------------------------------------------------------------------------

# 11. CONEXIONES IMPORTANTES

Las carpetas no están completamente aisladas.

## 00 → TODAS

Las reglas de Governance afectan todo el proyecto.

``` text
             00 GOVERNANCE
            /      |      \
           ↓       ↓       ↓
        Context  Domain  Product
           ↓       ↓       ↓
          Data   UX/UI   ...
```

------------------------------------------------------------------------

## 01 → 03

El alcance afecta directamente qué producto se puede construir.

``` text
01 Context
   ↓
Scope
   ↓
03 Product
   ↓
Backlog / Roadmap
```

Si cambia el alcance, se deben revisar las decisiones del producto.

------------------------------------------------------------------------

## 02 → 06

El dominio ayuda a definir qué información debe manejar el sistema.

``` text
02 Domain
   ↓
Entities / Rules
   ↓
06 Data
   ↓
Data Models
```

El repositorio señala explícitamente esta relación entre entidades del
dominio y modelos de datos.

------------------------------------------------------------------------

## 03 → 12

El producto define qué necesidades debe resolver la interfaz.

``` text
03 Product
   ↓
Necesidades / funcionalidades
   ↓
12 UX/UI
   ↓
Pantallas / navegación
```

------------------------------------------------------------------------

## 02 → Microservicios

El Bounded Context ayuda a establecer límites de responsabilidad.

``` text
Dominio
   ↓
Bounded Context
   ↓
Responsabilidad
   ↓
Microservicio
```

No significa que la regla sea "una tabla = un microservicio" ni que
cualquier entidad automáticamente sea un servicio.

------------------------------------------------------------------------

# 12. EJEMPLO ÚNICO PARA EXPLICAR TODO

Supongamos que queremos crear un sistema para gestionar horarios.

## 00 --- Governance

El equipo acuerda:

> "Todos utilizaremos las mismas reglas de Git, documentación, seguridad
> y revisión."

## 01 --- Context

Descubrimos:

> "Los aprendices necesitan consultar fácilmente sus horarios y conocer
> cambios."

Definimos:

-   quiénes son los usuarios;
-   qué problema existe;
-   qué incluye el sistema;
-   qué queda fuera.

## 02 --- Domain

Entendemos el negocio:

``` text
Aprendiz
Horario
Instructor
Programa
```

También identificamos reglas y eventos:

``` text
HorarioModificado
HorarioPublicado
```

Y podemos separar responsabilidades mediante Bounded Contexts.

## 03 --- Product

Decidimos:

> "Construiremos una plataforma que permita consultar horarios y conocer
> cambios."

Después organizamos:

``` text
Visión
↓
Backlog
↓
Prioridades
↓
Roadmap
```

## 06 --- Data

Ahora preguntamos:

> "¿Qué información necesita el sistema?"

Definimos modelos de datos y qué servicio es dueño de cada información.

## 12 --- UX/UI

Finalmente:

> "¿Cómo lo utilizará el aprendiz?"

Podemos definir:

``` text
Login
 ↓
Dashboard
 ↓
Mis horarios
 ↓
Detalle del horario
```

------------------------------------------------------------------------

# 13. DIFERENCIAS QUE NO SE DEBEN CONFUNDIR

## Context vs Domain

**Context:**

> Define el problema, usuarios y límites.

**Domain:**

> Explica cómo funciona el negocio o problema internamente.

------------------------------------------------------------------------

## Domain vs Product

**Domain:**

> Entender el problema.

**Product:**

> Decidir qué producto construir para resolverlo.

------------------------------------------------------------------------

## Product vs UX/UI

**Product:**

> Qué valor y funcionalidades se van a construir.

**UX/UI:**

> Cómo el usuario experimenta esas funcionalidades.

------------------------------------------------------------------------

## Domain vs Data

**Domain:**

> Qué representa la información dentro del negocio.

**Data:**

> Cómo esa información se estructura y almacena técnicamente.

------------------------------------------------------------------------

# 14. PREGUNTAS QUE PODRÍAN HACER EN LA PRESENTACIÓN

## ¿Qué es Governance?

> Es el conjunto de reglas, estándares, políticas y acuerdos que
> permiten coordinar el desarrollo y mantenimiento de un sistema de
> microservicios de manera consistente.

## ¿Por qué 00 está primero?

> Porque define las reglas que todos deben seguir y que aplican
> transversalmente al resto del proyecto.

## ¿Qué diferencia hay entre Context y Domain?

> Context define el problema, los usuarios y los límites del sistema.
> Domain profundiza en cómo funciona el negocio y cuáles son sus
> entidades, reglas, eventos y límites conceptuales.

## ¿Qué es DDD?

> Domain-Driven Design es un enfoque que coloca el dominio del negocio
> en el centro del diseño del software.

## ¿Qué es un Bounded Context?

> Es un límite dentro del dominio donde un determinado modelo y lenguaje
> tienen un significado específico. En microservicios, normalmente se
> relaciona con la responsabilidad de un microservicio.

## ¿Qué es un Domain Event?

> Es un hecho que ocurrió dentro del negocio y que puede ser relevante
> para otras partes del sistema.

## ¿Qué diferencia hay entre DoD y DoR?

> DoR determina cuándo una tarea está preparada para entrar al
> desarrollo. DoD determina cuándo el trabajo puede considerarse
> terminado.

## ¿Qué es Scope Creep?

> Es el crecimiento descontrolado del alcance de un proyecto.

## ¿Por qué cada microservicio debe ser dueño de sus datos?

> Para mantener independencia y reducir el acoplamiento entre servicios.
> Si necesita información de otro servicio, debe utilizar mecanismos de
> comunicación como APIs o eventos en lugar de acceder directamente a su
> base de datos.

## ¿Qué es un wireframe?

> Es una representación de baja fidelidad de una interfaz que muestra
> principalmente su estructura y distribución.

## ¿Qué es un Design System?

> Es un conjunto reutilizable de reglas, componentes y patrones que
> permite mantener una interfaz consistente.

## ¿Por qué UX/UI aparece después?

> Porque primero debemos conocer el problema, el dominio y el producto
> que vamos a construir. Después podemos diseñar cómo el usuario
> interactuará con esa solución.

------------------------------------------------------------------------

# 15. MAPA MENTAL PARA MEMORIZAR

``` text
                MICROSERVICES GOVERNANCE
                         │
                         ▼
                 REGLAS DEL PROYECTO
                         │
                         ▼
                    00 GOVERNANCE
                         │
                         ▼
                 ¿QUÉ PROBLEMA HAY?
                         │
                         ▼
                     01 CONTEXT
                         │
                         ▼
              ¿CÓMO FUNCIONA EL NEGOCIO?
                         │
                         ▼
                     02 DOMAIN
                         │
                         ▼
                 ¿QUÉ VAMOS A CONSTRUIR?
                         │
                         ▼
                    03 PRODUCT
                         │
                         ▼
             ¿CÓMO GUARDAMOS LA INFORMACIÓN?
                         │
                         ▼
                      06 DATA
                         │
                         ▼
               ¿CÓMO LO UTILIZA EL USUARIO?
                         │
                         ▼
                     12 UX/UI
```

------------------------------------------------------------------------

# 16. RESUMEN DE UNA SOLA LÍNEA

> **00 establece las reglas; 01 define el contexto; 02 entiende el
> dominio; 03 define el producto; 06 organiza los datos; y 12 diseña la
> experiencia del usuario.**

------------------------------------------------------------------------

# 17. PALABRAS CLAVE FINALES

## 00 --- GOVERNANCE

**Reglas → Git → Agile → DoD → DoR → Seguridad**

## 01 --- CONTEXT

**Problema → Usuarios → Scope → Límites → Glosario**

## 02 --- DOMAIN

**DDD → Entity → Value Object → Aggregate → Event → Bounded Context**

## 03 --- PRODUCT

**Problema → Discovery → Visión → Backlog → Roadmap → Valor**

## 06 --- DATA

**Modelos → BD → Tablas → Campos → Índices → Migraciones → Data
Ownership**

## 12 --- UX/UI

**UX → UI → Navegación → Wireframes → Roles → Design System**

------------------------------------------------------------------------

# 18. FRASE FINAL PARA LA PRESENTACIÓN

> **"El hilo conductor de estas carpetas es pasar de la organización a
> la solución: primero establecemos cómo trabaja el equipo mediante
> Governance; después entendemos el contexto y el problema; luego
> modelamos el dominio del negocio; con ese conocimiento definimos el
> producto; posteriormente diseñamos cómo se almacenan y gestionan sus
> datos; y finalmente definimos cómo el usuario interactúa con el
> sistema mediante UX/UI. Así, las carpetas no representan documentos
> aislados, sino diferentes perspectivas de un mismo proceso de
> construcción de software basado en microservicios."**

------------------------------------------------------------------------

## Fuente principal

Repositorio estudiado: `microservices-governance-framework`

Este documento se limita deliberadamente a las carpetas:

-   `00-governance`
-   `01-context`
-   `02-domain`
-   `03-product`
-   `06-data`
-   `12-ux-ui`
