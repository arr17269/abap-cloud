CLASS zcl_dominio_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dominio_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

 data:BEGIN  OF ls_empleado,
        nombre type string VALUE 'hhhh',
        edad type zde_edad_arr VALUE 10,
        correo type string VALUE 'toniarr@yavale',

        End OF ls_EMPLEADO.
        out->write( ls_empleado ).
















  ENDMETHOD.
ENDCLASS.
