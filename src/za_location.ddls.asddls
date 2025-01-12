@EndUserText.label: 'Location'
define abstract entity ZA_LOCATION
{
    location : abap.char(4);
    _plant : association to parent ZA_PLANT;
    
}
