@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PATH EXPRESION'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_FILTRO_ARR 
as select from /dmo/travel


association[0..*] to I_CurrencyText as  _Currency on _Currency.Currency = $projection.Currency


{
key travel_id as TravelId,
@Semantics.amount.currencyCode: 'Currency'
total_price as Price,
currency_code as Currency,

//the association Currency can modify the cardinality of the result set.
_Currency[ 1: Language = $session.system_language ].CurrencyName as CurrencyName

//el error da igual
  
  
    
}
