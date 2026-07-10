@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Valores fijos de Estado'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZCE_TRAVEL_STATUS
  as select from ztravel
{
  @ObjectModel.text.element: ['StatusText']
  key  'O' as StatusId,
    'Open' as StatusText
}

union select from ztravel
{
  key  'P' as StatusId,
      'Pendiente' as StatusText
}
