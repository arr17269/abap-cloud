CLASS zcl_volcar_tabla_arr2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VOLCAR_TABLA_ARR2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  types:BEGIN OF ty_aeropuerto,
        ID type i,
        aeropuerto_id type string,
        name type string,
        city type string,
        country type string,

        END OF TY_AEROPUERTO.

   data lt_aeropuerto TYPE TABLE of ty_aeropuerto.
   DATA ls_aeropuerto type ty_aeropuerto.


        ls_aeropuerto-id = 0.
        ls_aeropuerto-aeropuerto_id = 'NY'.
        ls_aeropuerto-name = 'New York'.
        ls_aeropuerto-city = 'New York'.
        ls_aeropuerto-country = 'EEUU'.

APPEND ls_aeropuerto to lt_aeropuerto.      "le decimos inserta la estructura en la tabla.


    insert value #( ID = 2 aeropuerto_id = 'HK' name = 'Hong kong' city = 'Kowloon' country = 'Hong kong' ) into table lt_aeropuerto.
    insert value #( ID = 3 aeropuerto_id = 'NY' name = 'New York' city = 'New York' country = 'EEUU' ) into table lt_aeropuerto.
        out->write( lt_aeropuerto ).









  ENDMETHOD.
ENDCLASS.
