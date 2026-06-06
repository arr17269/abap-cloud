@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS_3'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_3_ARR 
as select from /dmo/customer

{
    key customer_id as CustomerId,
    $session.client as NumeroSesion,       //devuelve el mandante
    $session.system_date as FechaSistema,   // devuelve la fecha del servidor SAP (INDEPENDIENTE DEL USUARIO)
    $session.system_language as LenguaSistema,   //idioma del sistema
    $session.user as CampoUsuario,              //el nombre del usuario que ejecuta la consulta
    $session.user_date as fechaUsuario,         //la fecha segun la zona horaria DEL USUARIO
    $session.user_timezone as UserTZ            //la zona horaria configurada del usuario.
    
}
