@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZCDS10'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_10_ARR
 as select from zcl_database_arr
 {

 key telefono as Telefono,
 

  
  case nombre
    when 'antonis' then 'alumn@ Antonia'
    when 'leonards' then 'alumn@ Leonardo'
    when 'romero' then 'no es alumno'
    else 'persona desconocida'
    end as AlumnoPropio
 
 
 
 
 
 
  
}
