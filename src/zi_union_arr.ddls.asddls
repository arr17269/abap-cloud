@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UNION_TABLAS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_UNION_ARR as select from /dmo/travel
{
key travel_id as TravelId,
    cast( '' as abap.numc(4)) as BookingID  
    
}

union select from /dmo/booking              //la union se hace fuera de las llaves

{

key travel_id as TravelId,
    booking_id as BookingID
}
