@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ASOCIACION DE BD A BD'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_20_ARR as select from /dmo/booking


association[1..1] to zi_19_der as _Travel on _Travel.TravelId = $projection.TravelId        //LA BD 19
{
    key travel_id as TravelId,
    key booking_id as BookingID, 
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    _Travel
}
