@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'primer cds'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_EJ_ARR 
as select from zbd_ex_arr
{
   
   key id_empleado as IdEmpleado,
   nombre as Nombre,
   apellido as Apellido,
   sueldo as Sueldo
   
}
