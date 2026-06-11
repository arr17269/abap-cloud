@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS9'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_9_ARR 
as select from /dmo/customer
{
key customer_id as CustomerID,
case country_code
    when 'US' then concat('United States - ', concat_with_space( last_name, first_name, 2 ))  //no lleva comas, ni puntos ni nada (filtro con when)
    when 'DE' then 'Germany'
    when 'ES' then 'Spain'
    else 'codigo de pais distinto'
    end as Case1,

$session.client as Cliente,                     //el mandante
$session.system_date as ClientField,            //fecha actual del servidor SAP
$session.system_language as systemidioma,       //idioma del sistema
$session.user as UserField,                     //es el ID del usuario logeado
$session.user_date as userDate,                 //fecha local del usuario
$session.user_timezone as userTZ                //zona horaria
    
}
