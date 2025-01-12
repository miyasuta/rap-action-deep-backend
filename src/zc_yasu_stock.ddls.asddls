@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_YASU_STOCK
  provider contract transactional_query
  as projection on ZR_YASU_STOCK
{
  key Id,
  ProductId,
  Price,
  Stock,
  Plant,
  Location,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt
  
}
