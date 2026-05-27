CLASS zcl_enum_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_enum_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
*  types: begin of enum ty_color,
*        rojo,
*        verde,
*        azul,
*
*        end of enum ty_color.
*
*
*  data lv_color type ty_color.
*
*  lv_color = rojo. "solo puedo guardar en la variable los colores tipos. No me permite poner rosa, por ejemplo.
                    "Tendria que añadir el color en el tipo.

 types: begin OF enum ty_vuelos,
        nacional,
        internacional,
        charter,            "vuelos especial/privado.
        END of enum ty_vuelos.

   data lv_vuelo TYPE ty_vuelos.

   lv_vuelo = charter.

   case lv_vuelo.
        when nacional.
        out->write( 'vuelos dentro de tu mismo pais' ).
        when internacional.
        out->write( 'vuelo entre paises' ).
        when charter.
        out->write( 'vuelo especial/privado' ).
        ENDCASE.









  ENDMETHOD.
ENDCLASS.
