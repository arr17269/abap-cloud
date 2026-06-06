@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS_FUNCIONES_AGREGACION'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_FUNCIONES_AGREGACION_ARR
 as select from /dmo/travel
{
 
  agency_id as AgencyId,
  
  @Semantics.amount.currencyCode: 'CurrencyCode' 
  min( total_price ) as MinTotalPrice,
   @Semantics.amount.currencyCode: 'CurrencyCode'
  max( total_price ) as MaxTotalPrice,
   @Semantics.amount.currencyCode: 'CurrencyCode'
   sum( total_price ) as SumTotalPrice, 
   
   count( distinct total_price ) as CountDistTotalPrice,        //no hace falta @   
   count( * ) as CountTotalPrice,
  currency_code as CurrencyCode
   
   
    
}

group by


agency_id,
currency_code;


