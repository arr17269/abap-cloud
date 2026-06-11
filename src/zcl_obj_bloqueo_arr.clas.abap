CLASS zcl_obj_bloqueo_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_obj_bloqueo_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  out->write( 'El usuario ha empezado el programa'  ).

  try.

  data(lo_lock_object) = cl_abap_lock_object_factory=>get_instance(  exporting iv_name = 'EZINV_ARR' ).

  CATCH cx_abap_lock_failure.
        out->write( 'El objeto de instancia no se ha creado' ).
        return.

  ENDTRY.

  data lt_parameter type if_abap_lock_object=>tt_parameter.

  lt_parameter = value #( (  name = 'ID'
                             value = ref #( '00000001' )
                                ) ).


 TRY.
  lo_lock_object->enqueue( it_parameter = lt_parameter ).
CATCH cx_abap_foreign_lock cx_abap_lock_failure.
  out->write( 'El objeto ya esta siendo tratado por otro usuario' ).
  RETURN.
ENDTRY.

out->write( 'El objeto ya esta disponible' ).
WAIT UP TO 20 SECONDS.



  if sy-subrc = 0.
    out->write( 'la base de datos ha sido actualizada' ).
  ENDIF.

try.
    lo_lock_object->dequeue(  it_parameter = lt_parameter ).
    catch cx_abap_lock_failure.

    out->write( 'el objeto no ha sido liberado' ).
    ENDTRY.
    out->write( 'el objeto ha sido liberado' ).


  ENDMETHOD.
ENDCLASS.
