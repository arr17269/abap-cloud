CLASS lhc_ZI_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel RESULT result.

ENDCLASS.

CLASS lhc_ZI_TRAVEL IMPLEMENTATION.

  METHOD get_global_authorizations.

  result-%create = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
