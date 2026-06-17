@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'reserva'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.viewEnhancementCategory: [#NONE]

define view entity ZI_CDS_11_ARR
  as select from /dmo/booking as Booking
  association [1..1] to /dmo/carrier as _Carrier on $projection.CarrierID = _Carrier.carrier_id
{
  key Booking.booking_id   as BookingID,
      Booking.carrier_id   as CarrierID,
      Booking.flight_date  as FlightDate,
      
      /* Campo calculado con la asociación */
      concat_with_space(_Carrier.name, Booking.carrier_id, 1) as CarrierInfo,
      
      /* Exponer la asociación para que pueda ser usada en el futuro */
      _Carrier
}
