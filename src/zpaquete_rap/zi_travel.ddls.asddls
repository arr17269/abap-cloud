@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vista Raíz - Viajes'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_TRAVEL
  as select from ztravel
{
  key id_viaje      as IdViaje,
      description   as Description,
      agency        as Agency,
      @Consumption.valueHelpDefinition: [
  {
    entity: {
      name: 'ZCE_TRAVEL_STATUS',
      element: 'StatusId'
    }
  }
]
status_travel as StatusTravel,
      
      
      
      
      
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true 
       local_last_changed_at as LocalLastChangedAt
          
   
      
      
}
