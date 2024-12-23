@EndUserText.label: 'Deep Parameter for Products'
define abstract entity ZA_PRODUCT_TABLE
{
  productUuId : sysuuid_x16;
  isActiveEntity: abap_boolean;
  
  _root: association to parent ZA_PRODUCT_ROOT;
}
