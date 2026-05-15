CLASS zcl_eje_tabla_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eje_tabla_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data ls_aeropuerto type /dmo/airport.
  data lt_aeropuerto type TABLE OF /dmo/airport."standard

  ls_aeropuerto-name = 'Madrid airport'.
  ls_aeropuerto-city = 'Madrid'.
  ls_aeropuerto-country = 'SP'.
  ls_aeropuerto-airport_id = 'Spa'.

  insert ls_aeropuerto into table lt_aeropuerto.

  ls_aeropuerto-city = 'Londres'.
  ls_aeropuerto-name = 'Londres airport'.
  ls_aeropuerto-country = 'LD'.
  ls_aeropuerto-airport_id = 'LDA'.

  insert ls_aeropuerto into table lt_aeropuerto.

  ls_aeropuerto-city = 'Tokyo'.
  ls_aeropuerto-name = 'Tokyo airport'.
  ls_aeropuerto-country = 'JP'.
  ls_aeropuerto-airport_id = 'TKO'.

  insert ls_aeropuerto into table lt_aeropuerto.

out->write( lt_aeropuerto ).

    LOOP AT lt_aeropuerto into ls_aeropuerto.

         if ls_aeropuerto-city cp 'T*'.

             out->write( ls_aeropuerto ).


        ENDIF.



    ENDLOOP.


"insertar un campo ID que se autogenere solo y que empiece por 1






  ENDMETHOD.
ENDCLASS.
