@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EJERC_UNION1'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_EJ1_UNION_ARR 
as select from /dmo/travel as viaje
       inner join /dmo/booking as reserva on reserva.travel_id = viaje.travel_id
{
key viaje.travel_id as TravelID,
key reserva.booking_id as BookingID,
    reserva.flight_date as FlightDate, 
    @Semantics.amount.currencyCode: 'CurrencyCode'
    reserva.flight_price as FlightPrice,
    reserva.currency_code as CurrencyCode,      
    viaje.agency_id as AgencyID,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    viaje.booking_fee as BookingFee
   
}


