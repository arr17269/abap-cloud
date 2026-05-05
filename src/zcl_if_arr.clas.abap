CLASS zcl_if_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_if_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

DATA Lv_Pedro TYPE string VALUE 'Pedro'.
DATA lv_Sara TYPE string VALUE 'Sara'.
data lv_Juan TYPE string VALUE 'Juan'.
data lv_Laura type string VALUE 'Laura'.

data lv_num1 type i VALUE 30.
DATA lv_num2 type i VALUE 20.
data lv_num3 type i VALUE 25.

data lv_gustar type string VALUE 'si'.
data lv_gustar2 type string VALUE 'no'.

If lv_Pedro = 'Pedro' and lv_num1 = 20.
    elseif lv_gustar = 'si'.
    out->write( 'A Pedro le gusta Laura de 30 años' ).

 ENDIF.


 If lv_Pedro = 'Pedro' and lv_num1 = 25.
    elseif lv_gustar = 'si'.
    out->write( 'A Pedro le gusta Laura de 30 años' ).
 ENDIF.















  ENDMETHOD.

ENDCLASS.
