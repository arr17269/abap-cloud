CLASS zcl_case_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_case_arr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

data: lv_operacion TYPE string VALUE '*',
      lv_num1 TYPE i VALUE 5,
      lv_num2 type i value 4,
      lv_resultado type i.

    case lv_operacion.

        when '-'.
        lv_resultado = lv_num1 - lv_num2.
             out->write( lv_resultado ).
        when '+'.
        lv_resultado = lv_num1 + lv_num2.
             out->write( lv_resultado ).
        when '*'.
         lv_resultado = lv_num1 * lv_num2.
             out->write( |esto es una multiplicacion ({ lv_resultado }) de { lv_num1 } por { lv_num2 } | ).
        when '/'.
         lv_resultado = lv_num1 / lv_num2.
            out->write( lv_resultado ).
        when OTHERS.
            out->write( 'no es una operacion correcta' ).

       ENDCASE.







  ENDMETHOD.

ENDCLASS.
