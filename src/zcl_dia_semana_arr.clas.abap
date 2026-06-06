CLASS zcl_dia_semana_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dia_semana_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


  DATA lv_num type i.


  lv_num = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                      min = 1
                                                        max = 7 )->get_next(  ).

  case lv_num.

    when 1.

        out->write( lv_num ).
        out->write( |Hoy es lunes | ).


    when 2.

        out->write( lv_num ).
        out->write( |Hoy es martes | ).

    when 3.

        out->write( lv_num ).
        out->write( |Hoy es miercoles | ).

    when 4.

        out->write( lv_num ).
        out->write( |Hoy es jueves | ).

    when 5.

        out->write( lv_num ).
        out->write( |Hoy es viernes | ).

    when 6.

        out->write( lv_num ).
        out->write( |Hoy es sabado | ).

    when 7.

        out->write( lv_num ).
        out->write( |Hoy es domingo | ).

    when others.
        out->write( |Dia invalido | ).




  ENDCASE.











  ENDMETHOD.
ENDCLASS.
