@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS_8'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_8_ARR 
as select from zcl_database_arr

{  

key nombre as Nombre,
edad as Edad

} 
