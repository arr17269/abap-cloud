@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UNION'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_5_ARR 
as select from /dmo/travel
{      
 key travel_id as TravelId,
 cast(''as abap.numc(4)) as BookingId  //la union la hace a traves del campo travel_id
    
}
//cuando haces una union, todas las ramas deben devolver exactamente las mismas columnas, con los mismos tipos de dato.
//en este caso la tabla /dmo/travel no tiene ningun campo booking_id, pero la vista necesita que la columna BookingId exista en ambas ramas de la union
//cuando como en este caso una tabla comparte un campo, lo inventas con un cast que devuelve un valor vacio del tipo correcto
union select distinct from /dmo/booking  //le decimos muestra los registros JOIN no duplicados de travel_id
{ 
key travel_id as TravelId,
booking_id as BookingId
}



