@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_YASU_STOCK
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_YASU_STOCK
{
  key Id,
  ProductId,
  Price,
  Stock,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt
  
}
