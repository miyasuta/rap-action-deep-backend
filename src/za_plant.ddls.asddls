@EndUserText.label: 'Plant'
define root abstract entity ZA_PLANT
{
    plant : abap.char(4);
    _location : composition [0..*] of ZA_LOCATION; 
}
