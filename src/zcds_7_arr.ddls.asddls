@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS7'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_7_ARR 
as select from /dmo/flight


{
   key carrier_id as AerolineID, 
   key connection_id as ConnectionId,
   key flight_date as FlightDate,
   @Semantics.amount.currencyCode: 'moneda'
   @EndUserText.label: 'Precio'
   price as Precio,
   currency_code as moneda,
   'USD' as manual,         //me invento una columna
   '20300101' as fecha,
   cast('20200202' as abap.dats ) as FechaC, //la FechaC es el alias
   1.2 as flotante,
   fltp_to_dec(3.2 as abap.dec(4,2)) as NumeroDecimal
   
}
