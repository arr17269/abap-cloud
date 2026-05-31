CLASS zcl_ej_cal_notas_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_cal_notas_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.   "metodo RUN o IF_OO_ADT_CLASSRUN (punto de entrada)

  data lv_num type i.
  data(lv_nota) = 7.  "forma de declarar una variable de golpe (entre parentesis)


  lv_num = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                       min = 0
                                                        max = 15 )->get_next(  ).
     out->write( |Calculo de calificacion| ).
     out->write( | | ).
     out->write( | | ).
     out->write( lv_num ).

  IF lv_num between 0 and 4.
         out->write( | la calificacion es: Suspenso.| ).
  elseif lv_num between 5 and 6.
         out->write( | la calificacion es: Aprobado.| ).
  elseif lv_num between 7 and 8.

         if lv_num = 7.
         out->write( | la nota esperada es: 7 | ).
         else.
         out->write( | la calificacion es: Notable.| ).
         ENDIF.

  elseif lv_num between 9 and 10.
        out->write( | la calificacion es: Sobresaliente.| ).
    else.
        out->write( | Valor negativo o mayor que 10: valor no valido:| ).

   ENDIF.







  ENDMETHOD.
ENDCLASS.
