# A2. Diagrama de Clases de Diseño Orientado a Objetos

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Proyecto Formativo:** Nuvora — Centro Comercial San Pedro Plaza (Neiva)  
**Autor:** `edwin-esquivel-ADSO`  
**Guía 2:** Diseño de la Solución — **Producto 1:** Artefactos de Diseño (`G2-P1`)

---

## 1. Archivos del Diagrama (Fuente Editable e Imagen Exportada)

* **Fuente editable (Draw.io):** [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio)
* **Imagen vectorial exportada (SVG):** [`02-diagrama-clases.svg`](./02-diagrama-clases.svg)

---

## 2. Decisiones de Diseño Orientado a Objetos (Rúbrica G2 · Criterio 2)

El diagrama evoluciona las 12 clases conceptuales del Modelo de Dominio (`G1-P2/03-modelo-dominio.md`) hacia **16 clases/interfaces de diseño** en TypeScript, respetando **alta cohesión** y **bajo acoplamiento**:

1. **Separación estricta de responsabilidades (Regla 5 de `Rubricas_G2.md`):** Ninguna clase mezcla interfaz gráfica, lógica de negocio, persistencia ni reportes. Las entidades (`Usuario`, `Promocion`, `Cupon`, `Redencion`, etc.) encapsulan estado y reglas puras del negocio; la coordinación transaccional recae en `FachadaCanjeMostrador`, y la analítica de conversión (`RF19`) se ejecuta como consulta de solo lectura en el servicio `ServicioCatalogoPromociones` (`A5`) sin contaminar las entidades de dominio.
2. **Generalización / Herencia (`«es un»`):** `Usuario` es clase abstracta padre con atributos comunes (`-id: UUID`, `-nombreCompleto: string`, `-correo: string`, `-hashContrasena: string`, `-salContrasena: string`, `-estadoCuenta: string`) y los métodos `+autenticar(clave: string): boolean` y `+actualizarAcceso(): void`. De ella heredan las **3 subclases operativas transaccionales** (`Visitante`, `Locatario` y `Cajero`), evitando duplicar credenciales; el **4.º rol** (`ADMINISTRADOR`, declarado en `roles` de `G2-P2` y equivalente al `Superadministrador` de `G1-P1`) utiliza la entidad `Usuario` asociada al rol administrativo para supervisar catálogo y bitácora (`RegistroAuditoria`, `RF20`).
3. **Composición (`«es parte de»`):** `Promocion` (`1`) contiene por composición (`◆──`) de `0..*` instancias de `FranjaHoraria`. Si una promoción es eliminada, sus franjas horarias dejan de existir en el dominio.
4. **Polimorfismo por Interfaz (`≥ 2` implementaciones):** La interfaz `<<interface>> IEstrategiaVigencia` define `+esVigenteAhora(promo: Promocion, fechaServidor: Date): boolean` con dos implementaciones concretas: `VigenciaHorarioRegular` y `VigenciaFranjaRelampago`. Así, `FachadaCanjeMostrador` evalúa la vigencia sin condicionales rígidos por tipo de campaña (Patrón **Estrategia**).
5. **Orquestación Desacoplada:** `FachadaCanjeMostrador` (Patrón **Fachada**) expone una única operación `+procesarCanje(codigo: string, cajero: Cajero, ip: string): string` que coordina la validación del `Cupon` (`CU-11`), el cambio atómico de estado (`RN-04`), la creación de `Redencion` (`CU-10`) y la escritura de `RegistroAuditoria` (`RF20`).

---

## 3. Catálogo Completo de Clases, Atributos Tipados, Métodos y Trazabilidad

| # | Clase / Interfaz | Estereotipo / Tipo | Atributos Clave (Visibilidad y Tipo) | Métodos Principales (Parámetros y Retorno) | Requisitos que Atiende |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **1** | `Usuario` | `«abstract»` Superclase | `-id: UUID`, `-nombreCompleto: string`, `-correo: string`, `-hashContrasena: string`, `-salContrasena: string`, `-estadoCuenta: string` | `+autenticar(clave: string): boolean`<br>`+actualizarAcceso(): void` | `RF01`, `RF02`, `RF03`, `RNF02` |
| **2** | `Visitante` | Subclase (`Usuario`) | `-fechaRegistro: Date`, `-autorizaDatos: boolean` | `+puedeReclamar(promoId: UUID): boolean` | `RF01`, `RF13`, `RF15`, `RNF09` |
| **3** | `Locatario` | Subclase (`Usuario`) | `-cargoEnLocal: string`, `-telefonoContacto: string`, `-localId: UUID` | `+gestionarOferta(promo: Promocion): void` | `RF04`, `RF09`, `RF11`, `RF19` |
| **4** | `Cajero` | Subclase (`Usuario`) | `-cajaAsignada: string`, `-turnoOperacion: string`, `-localId: UUID` | `+perteneceALocal(localId: UUID): boolean` | `RF16`, `RF17`, `RF18`, `RF20` |
| **5** | `LocalComercial` | Entidad | `-id: UUID`, `-nombreComercial: string`, `-numeroLocal: string`, `-horarioAtencion: string`, `-estadoOperativo: string` | `+actualizarPerfil(horario: string, tel: string): void` | `RF04`, `RF05`, `RF17` |
| **6** | `Categoria` | Entidad | `-id: number`, `-nombreCategoria: string`, `-icono: string` | `+obtenerNombre(): string` | `RF05` |
| **7** | `Producto` | Entidad | `-id: UUID`, `-nombreProducto: string`, `-descripcion: string`, `-precioRegular: number`, `-disponible: boolean` | `+cumplePresupuesto(montoMax: number): boolean` | `RF06`, `RF07`, `RF08` |
| **8** | `Promocion` | Entidad | `-id: UUID`, `-tituloOferta: string`, `-precioPromocional: number`, `-cupoMaximo: number`, `-cuposUsados: number`, `-fechaInicio: Date`, `-fechaFin: Date`, `-estado: string` | `+tieneCupoDisponible(): boolean`<br>`+descontarCupo(): void`<br>`+obtenerEstrategia(): IEstrategiaVigencia` | `RF09`, `RF10`, `RF11`, `RF12` |
| **9** | `FranjaHoraria` | Entidad (Parte) | `-id: UUID`, `-diaSemana: number`, `-horaInicio: string`, `-horaFin: string` | `+contieneHora(horaServidor: string, dia: number): boolean` | `RF10`, `RF17` |
| **10** | `Cupon` | Entidad | `-id: UUID`, `-codigoAlfanumerico: string`, `-fechaEmision: Date`, `-fechaExpiracion: Date`, `-estado: string` | `+estaVencido(fechaServidor: Date): boolean`<br>`+marcarRedimido(): void` | `RF13`, `RF14`, `RF15`, `RF17`, `RF18`, `RNF03` |
| **11** | `Redencion` | Entidad | `-id: UUID`, `-fechaHoraCanje: Date`, `-montoDescontado: number`, `-metodoValidacion: string` | `+calcularAhorro(precioBase: number, precioOferta: number): number` | `RF18`, `RF20`, `RNF04` |
| **12** | `RegistroAuditoria` | Entidad | `-id: UUID`, `-accion: string`, `-detalle: string`, `-ipOrigen: string`, `-fechaRegistro: Date` | `+registrarEvento(actorId: UUID, detalle: string): void` | `RF20` |
| **13** | `IEstrategiaVigencia` | `«interface»` | *(Sin atributos)* | `+esVigenteAhora(promo: Promocion, fechaServidor: Date): boolean` | `RF10`, `RF17`, `RNF07` |
| **14** | `VigenciaHorarioRegular` | Implementa Interfaz | *(Sin estado propio)* | `+esVigenteAhora(promo: Promocion, fechaServidor: Date): boolean` | `RF09`, `RF17` |
| **15** | `VigenciaFranjaRelampago` | Implementa Interfaz | *(Sin estado propio)* | `+esVigenteAhora(promo: Promocion, fechaServidor: Date): boolean` | `RF10`, `RF17` |
| **16** | `FachadaCanjeMostrador` | Servicio / Fachada | `-estrategiaRegular: IEstrategiaVigencia`<br>`-estrategiaRelampago: IEstrategiaVigencia` | `+procesarCanje(codigo: string, cajero: Cajero, ip: string): string` | `RF16`, `RF17`, `RF18`, `RF20`, `RNF01`, `RNF04` |
