@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UNION11'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_EJ_UNION_ARR as select from zcl_database_arr
{
       
    key correo as Correo,
        nombre as Nombre,
        telefono as Telefono
}

union select from zbd_ex_arr

{

    key correo as Correo,
    nombre as Nombre,
    telefono as Telefono


}
