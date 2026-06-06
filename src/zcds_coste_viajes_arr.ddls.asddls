@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS_COSTE_VIAJES'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_COSTE_VIAJES_ARR 
as select from /dmo/travel
    
{
 key travel_id as TravelId,
 cast('0000'as abap.numc(4)) as BookingId,
 @Semantics.amount.currencyCode: 'CurrencyCode'             //para indicarle que tipo de moneda utiliza la tabla TRAVEL
 cast( total_price as abap.curr(16,2) ) as Total_Price,    //homogeneizar el campo precio
      currency_code as CurrencyCode
 }
 
 
union select distinct from /dmo/booking                      //le decimos muestra los registros JOIN no duplicados de la columna travel_id
{ 
key travel_id as TravelId,
booking_id as BookingId,


cast( flight_price as abap.curr(16,2) ) as Total_Price,
      currency_code as CurrencyCode

} 


