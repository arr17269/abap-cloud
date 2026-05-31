CLASS zcl_poo2_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_poo2_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data(lo_perro) = new zcl_poo_arr(  ).  "estoy declarando objetos
  data(lo_perro2) = new zcl_poo_arr(  ).
  data(lo_perro3) = new zcl_poo_arr(  ).
  data(lo_perro4) = new zcl_poo_arr(  ).
  data(lo_coche) = new zcl_fabrica_arr(  ).

    "si objeto lo_perro esta creado.
 if lo_coche is bound.

    lo_coche->lv_color = 'azul'.
    lo_coche->lv_puertas = 'tiene 4 puertas'.

    out->write( lo_coche->parar( ) ).
    out->write( lo_coche->frenar( ) ).

  ENDIF.




  if lo_perro is bound.

  lo_perro->lv_nombre = 'Rey'.
  lo_perro->lv_color = 'marron claro'.
  lo_perro->lv_size = 'pequeño'.

  out->write( lo_perro->comer(  ) ).
  out->write( lo_perro->saltar(  ) ).

  ENDIF.

  if lo_perro3 is bound.

  lo_perro3->lv_nombre = 'gasper'.
  lo_perro3->lv_size = 'grande'.

  out->write( lo_perro3->lanzar_pelota(  ) ).
  out->write( lo_perro3->saltar( ) ).

  ENDIF.






  ENDMETHOD.
ENDCLASS.
