@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EXPOSICION'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_14_ARR
  as select from /dmo/travel as Travel
  
  
//cada viaje tiene exactamente un cliente. minimo 1 (siempre hay un cliente, no puede faltar) y maximo 1 (no puede haber 2).
//es una relacion obligatoria y unica.
  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId
  
//igual que el anterior. Cada viaje pertenece a EXACTAMENTE A UNA AGENCIA. Siempre hay una y solo una.  
  association [1..1] to /dmo/agency   as _Agency   on _Agency.agency_id = $projection.AgencyId
  
  //cada viaje puede tener DESDE CERO HASTA MUCHAS reservas. El 0 significa que un viaje podria no tener ninguna reserva todavia.
  //*significa que puede acumular tantas como haga falta.
  association [0..*] to /dmo/booking  as _Booking  on _Booking.travel_id = $projection.TravelID
  
  //un viaje (travel) apunta a un cliente y una agencia -> son los "padres" o datos maestros. Por eso [1..1]
  //las reservas (booking) son los "hijos" que cuelgan del viaje agrupa varias reservas -> por eso [0..*]
  


{

  key Travel.travel_id   as TravelID,
      Travel.customer_id as CustomerId,
      Travel. agency_id  as AgencyId,
      
      //esto se pone para que salgan las asociaciones 
      _Customer,
      _Agency,
      _Booking
      
      
 //asociacion/relacion -> el hecho de que travel esté conectado con customer, agency o booking. Eso es relacion
 //cardinalidad -> es solo el [min..max] . es un atributo de la relacion que cuantifica cuantas instancias hay en cada extremo.   


}
