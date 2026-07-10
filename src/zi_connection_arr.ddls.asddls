
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Conexiones de vuelo con asociaciones'
@Metadata.ignorePropagatedAnnotations: true


define view entity ZI_CONNECTION_ARR
  as select from /dmo/connection as Connection
  
  -- 1. Asociación a la compañía aérea (Exactamente una)
  association [1..1] to /dmo/carrier as _Carrier 
    on Connection.carrier_id = _Carrier.carrier_id
    
  -- 2. Asociación al aeropuerto de salida (Exactamente uno)
  association [1..1] to /dmo/airport as _DepartureAirport 
    on Connection.airport_from_id = _DepartureAirport.airport_id
    
  -- 3. Asociación a los vuelos (Cero a muchos - Requiere dos campos clave)
  association [0..*] to /dmo/flight  as _Flights 
    on  Connection.carrier_id    = _Flights.carrier_id
    and Connection.connection_id = _Flights.connection_id
    
  -- 4. RETO BONUS: Asociación al aeropuerto de destino (Misma tabla, alias distinto)
  association [1..1] to /dmo/airport as _DestinationAirport 
    on Connection.airport_to_id = _DestinationAirport.airport_id

{
  -- Campos clave a exponer (usando camelCase como pide el ejercicio)
  key Connection.carrier_id     as CarrierId,
  key Connection.connection_id  as ConnectionId,
  
  -- Otros campos requeridos en la lista de proyección
  Connection.airport_from_id    as AirportFromId,
  Connection.airport_to_id      as AirportToId,
  Connection.departure_time     as DepartureTime,
  Connection.distance           as Distance,
  
  -- Exponer las asociaciones al final para que puedan ser usadas externamente
  _Carrier,
  _DepartureAirport,
  _Flights,
  _DestinationAirport // Incluida en el bonus
}
