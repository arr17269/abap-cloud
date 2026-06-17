@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'asociacion normal'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CDS_12_ARR 
as select from /dmo/travel as Travel

association[1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId


{

key Travel.travel_id                                            as TravelId,
Travel.customer_id                                              as CustomerId,
concat_with_space( _Customer.first_name, _Customer.last_name , 2) as CustomerName
                                                                 
}
