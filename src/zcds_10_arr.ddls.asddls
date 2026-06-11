@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZCDS10'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_10_ARR
 as select from zcl_database_arr
 {

 key telefono as Telefono,
 
 concat(
    concat(
        concat(
            concat(
                substring( telefono, 1, 2 ), ' '
            ),
            substring( telefono, 3, 2 )
        ),
        ' '
    ),
    concat(
        substring( telefono, 5, 2 ), 
        concat( ' ', substring( telefono, 7, 2 ) )
    )
) as telefono_formateado,
  
  case nombre
    when 'antonis' then 'alumn@ Antonia'
    when 'leonards' then 'alumn@ Leonardo'
    when 'romero' then 'no es alumno'
    else 'persona desconocida'
    end as AlumnoPropio
 
 
 
 
 
 
  
}
