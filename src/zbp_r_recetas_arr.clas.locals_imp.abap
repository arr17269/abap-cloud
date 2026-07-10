CLASS lhc_ZrRecetasArr DEFINITION
  INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validate_tiempo FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrRecetasArr~validateTiempo.
    METHODS set_publicada FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZrRecetasArr~setPublicada.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZrRecetasArr RESULT result.
ENDCLASS.

CLASS lhc_ZrRecetasArr IMPLEMENTATION.
  METHOD validate_tiempo.
    READ ENTITIES OF zr_recetas_arr IN LOCAL MODE
      ENTITY ZrRecetasArr
        FIELDS ( TiempoPrep )
        WITH CORRESPONDING #( keys )
      RESULT DATA(recetas).
    LOOP AT recetas INTO DATA(receta).
      IF receta-TiempoPrep < 1 OR receta-TiempoPrep > 600.
        APPEND VALUE #( %tky = receta-%tky ) TO failed-ZrRecetasArr.
        APPEND VALUE #( %tky = receta-%tky
                        %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'El tiempo debe estar entre 1 y 600 minutos' )
                      ) TO reported-ZrRecetasArr.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_publicada.
    READ ENTITIES OF zr_recetas_arr IN LOCAL MODE
      ENTITY ZrRecetasArr
        FIELDS ( Publicada )
        WITH CORRESPONDING #( keys )
      RESULT DATA(recetas).
    MODIFY ENTITIES OF zr_recetas_arr IN LOCAL MODE
      ENTITY ZrRecetasArr
        UPDATE FIELDS ( Publicada )
        WITH VALUE #( FOR receta IN recetas
                      ( %tky      = receta-%tky
                        Publicada = abap_true ) )
    REPORTED DATA(reported_modify).
  ENDMETHOD.
METHOD get_global_authorizations.
  result-%update = if_abap_behv=>auth-allowed.
  result-%delete = if_abap_behv=>auth-allowed.
ENDMETHOD.
ENDCLASS.
