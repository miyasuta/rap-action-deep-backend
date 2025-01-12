CLASS lhc_zr_yasu_stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Stock
        RESULT result,
      calcStockAmountDeep FOR MODIFY
        IMPORTING keys FOR ACTION Stock~calcStockAmountDeep RESULT result,
      calcStockAmount FOR MODIFY
        IMPORTING keys FOR ACTION Stock~calcStockAmount RESULT result,
      calcStockAmountAll FOR MODIFY
        IMPORTING keys FOR ACTION Stock~calcStockAmountAll RESULT result.

    TYPES: BEGIN OF ty_key,
             id       TYPE sysuuid_x16,
             is_draft TYPE abp_behv_flag,
           END OF ty_key.

    TYPES: BEGIN OF ty_location,
             location TYPE zr_yasu_stock-location,
           END OF ty_location.
ENDCLASS.

CLASS lhc_zr_yasu_stock IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD calcStockAmountDeep.
    DATA amount TYPE i.
    DATA lt_productuuid TYPE STANDARD TABLE OF ty_key.

    "get product ids
    LOOP AT keys INTO DATA(key).
      LOOP AT key-%param-_product INTO DATA(product).
        APPEND VALUE #( id = product-productUuId
                        is_draft = SWITCH #( product-isActiveEntity
                                              WHEN abap_true THEN if_abap_behv=>mk-off
                                                             ELSE if_abap_behv=>mk-on ) ) TO lt_productuuid.
      ENDLOOP.
    ENDLOOP.

    READ ENTITIES OF zr_yasu_stock IN LOCAL MODE
      ENTITY Stock
      FIELDS ( Price Stock )
      WITH VALUE #( FOR data IN lt_productuuid (
          %tky = VALUE #( id = data-id
                          %is_draft = data-is_draft ) ) )
      RESULT DATA(stock_t).

    " calculate stock amount
    LOOP AT stock_t INTO DATA(stock).
      amount = amount + stock-Price * stock-Stock.
    ENDLOOP.

    " return result
    result = VALUE #( FOR key1 IN keys (
                       %cid = key1-%cid
                       %param =  VALUE #( amount = amount )
                     ) ).

  ENDMETHOD.

  METHOD calcStockAmount.
    DATA amount TYPE i.

    "get selected records
    READ ENTITIES OF zr_yasu_stock IN LOCAL MODE
      ENTITY stock
      FIELDS ( Price Stock )
      WITH CORRESPONDING #( keys )
      RESULT DATA(stock_t).

    " calculate stock amount
    LOOP AT stock_t INTO DATA(stock).
      amount = amount + stock-Price * stock-Stock.
    ENDLOOP.

    result = VALUE #( FOR key IN keys (
                      %tky = key-%tky
                      %param = VALUE #( amount = amount )
                     ) ).


  ENDMETHOD.

  METHOD calcStockAmountAll.
    DATA plant TYPE zr_yasu_stock-Plant.
    DATA r_location TYPE RANGE OF zr_yasu_stock-location.
    DATA amount TYPE i.

    "get plant and storage locations
    LOOP AT keys INTO DATA(key).
      plant = key-%param-plant.
      r_location = VALUE #( FOR loc IN key-%param-_location (
                           sign = 'I'
                           option = 'EQ'
                           low = loc-location ) ).
      EXIT. "get the first record of the keys
    ENDLOOP.

    "select from cds view (not including draft data)
    SELECT price,
           stock
      FROM zr_yasu_stock
      WHERE plant = @plant
      AND location IN @r_location
      INTO TABLE @DATA(stock_t).

    " calculate stock amount
    LOOP AT stock_t INTO DATA(stock).
      amount = amount + stock-Price * stock-Stock.
    ENDLOOP.

    " return result
    result = VALUE #( FOR key1 IN keys (
                       %cid = key1-%cid
                       %param =  VALUE #( amount = amount )
                     ) ).
  ENDMETHOD.

ENDCLASS.
