# Venta y Control de Tiquetes Aéreos

## Problema de negocio

Una aerolínea necesita un sistema que permita controlar todo el proceso relacionado con la venta de tiquetes aéreos.

El proceso comienza cuando un pasajero realiza una reserva. A partir de esta reserva se genera un tiquete para un vuelo específico. Posteriormente se asigna un asiento dentro de la aeronave, el pasajero puede registrar equipaje y realizar el pago correspondiente. Finalmente, cuando viaja, se registra el embarque.

El sistema también debe permitir consultar qué pasajeros compraron un tiquete pero nunca abordaron el avión (No Show).

## Usuarios del sistema

Según el documento, el sistema cuenta con un único usuario durante el MVP.

Agente de la aerolínea

Es el encargado de:

Iniciar sesión.
Gestionar pasajeros.
Crear reservas.
Emitir tiquetes.
Crear vuelos.
Asignar asientos.
Registrar equipaje.
Registrar pagos.
Registrar embarques.
Consultar reportes.

El sistema inicia con un agente administrador ya registrado.

### 4. Design Thinking

## 4.1 Empatizar

## Usuario

--- Agente de la aerolínea. ---

Necesidades
Registrar pasajeros.
Crear reservas.
Emitir tiquetes.
Organizar vuelos.
Asignar asientos.
Registrar pagos.
Registrar equipaje.
Registrar embarques.
Consultar pasajeros que no viajaron.

## 4.2 Definir

--- Problema ---

La aerolínea necesita controlar de manera organizada todo el proceso de venta de tiquetes, desde la reserva hasta el embarque, permitiendo además identificar los pasajeros que compraron un tiquete pero no realizaron el viaje.

## 4.3 Idear

Como solución se propone desarrollar un sistema que permita:

Registrar pasajeros.
Crear reservas.
Emitir tiquetes.
Registrar vuelos.
Asignar asientos.
Registrar equipaje.
Registrar pagos.
Registrar embarques.
Consultar reportes de pasajeros que no viajaron.

## 4.4 Prototipo

El sistema estará compuesto por diferentes módulos.

Inicio de sesión.
Gestión de pasajeros.
Gestión de reservas.
Gestión de tiquetes.
Gestión de vuelos.
Gestión de asientos.
Gestión de pagos.
Gestión de equipaje.
Registro de embarques.
Reporte de pasajeros que no viajaron.

## 4.5 Probar

El sistema será considerado funcional cuando permita:

Iniciar sesión correctamente.
Registrar un pasajero.
Crear una reserva.
Emitir un tiquete.
Crear un vuelo.
Asignar un asiento.
Registrar un embarque.
Consultar el reporte de pasajeros que no viajaron.

### 5. Priorización MoSCoW

## Must Have (Debe tener)

Inicio de sesión.
Registro de pasajeros.
Creación de reservas.
Emisión de tiquetes.
Creación de vuelos.
Asignación de asientos.
Registro de embarques.
Consulta de pasajeros que no viajaron.

## Should Have (Debería tener)

Registro de pagos.
Registro de equipaje.

## Could Have (Podría tener)

Reportes adicionales.
Búsqueda avanzada de pasajeros.
Historial de viajes.

## Won't Have (No tendrá en esta versión)

Compra de tiquetes por internet.
Aplicación móvil.
Notificaciones por correo electrónico.

### 6. Modelo Entidad Relación

## Pasajero

Atributos

Documento
Nombre
Fecha de nacimiento

Descripción

Representa a la persona que compra y utiliza el tiquete.

## Reserva

Atributos

Código
Fecha
Estado

Descripción

Representa la solicitud realizada antes de emitir el tiquete.

## Tiquete

Atributos

Número
Fecha de emisión
Clase de servicio

Descripción

Representa el tiquete generado a partir de una reserva.

## Vuelo

Atributos

Número de vuelo
Fecha de salida
Hora programada

Descripción

Representa el vuelo asignado al pasajero.

## Aeropuerto

Atributos

Código
Nombre
Ciudad

Descripción

Representa el aeropuerto de origen y destino del vuelo.

## Aeronave

Atributos

Matrícula
Modelo
Capacidad

Descripción

Representa el avión asignado al vuelo.

## Asiento

Atributos

Número de asiento
Fila
Ubicación

Descripción

Representa el asiento disponible dentro de la aeronave.

## Payment (Pago)

Atributos

Referencia
Fecha
Valor

Descripción

Representa el pago realizado por el pasajero.

## Equipaje

Atributos

Etiqueta
Peso
Estado

Descripción

Representa el equipaje registrado para el viaje.

## Embarque

Atributos

Hora de ingreso
Puerta
Condición de presentación

Descripción

Representa el registro de embarque del pasajero.
