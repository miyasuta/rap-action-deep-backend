CLASS zcl_yasu_fill_plant DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_yasu_fill_plant IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data plant type STANDARD TABLE OF zyasu_plant.
    data location type standard table of zyasu_location.

    delete from zyasu_plant.
    delete from zyasu_location.

    plant = value #( ( plant = '1000' name = 'Plant 1000' )
                     ( plant = '2000' name = 'Plant 2000' )
                     ( plant = '3000' name = 'Plant 3000' ) ).

    location = value #( ( plant = '1000' location = 'A010' name = 'Location A010' )
                        ( plant = '1000' location = 'A020' name = 'Location A020' )
                        ( plant = '2000' location = 'B010' name = 'Location B010' )
                        ( plant = '2000' location = 'B020' name = 'Location B020' )
                        ( plant = '3000' location = 'C010' name = 'Location C010' )
                        ( plant = '3000' location = 'C020' name = 'Location C020' ) ).

    insert zyasu_plant from table @plant.
    insert zyasu_location from table @location.

    out->write( sy-subrc ).

  ENDMETHOD.
ENDCLASS.
