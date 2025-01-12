@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Location'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.representativeKey: 'Location'
define view entity ZI_YASU_LOCATION as select from zyasu_location
{
    key plant as Plant,
    key location as Location,
    name as Name
}
