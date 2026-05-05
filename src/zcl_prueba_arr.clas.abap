CLASS zcl_prueba_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_prueba_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

" hola mundo segundo commit.

data lv_mundo type string VALUE 'mi segundo commit'.

DATA lv_nombre TYPE string VALUE 'Paco'.

    if lv_nombre <> 'Paco'.
    exit.
    Endif.

    lv_nombre = 'Luis'.
    out->write( 'La calculadora sólo está permitida para Paco' ).

DATA lv_operation TYPE string value '+'.

    DATA lv_num TYPE i value 5.
    data lv_num1 TYPE i value 8.
    data lv_resultado TYPE i.

      case lv_operation.
            When '+'.
                lv_resultado = lv_num + lv_num1.
                out->write( lv_resultado ).
            When '-'.
                lv_resultado = lv_num - lv_num1.
                out->write( lv_resultado ).
            When '*'.
                lv_resultado = lv_num * lv_num1.
                out->write( lv_resultado ).
            When '/'.
                lv_resultado = lv_num / lv_num1.
                out->write( lv_resultado ).
            When others.
                out->write( 'no es una operación correcta' ).

       ENDCASE.








  ENDMETHOD.

ENDCLASS.














