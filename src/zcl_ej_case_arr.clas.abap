CLASS zcl_ej_case_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_case_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "4 NIÑOS SE LLAMAN DANIEL: 8,6,5,9 AÑOS. Hay 20 niños en la clase.
  "8- Ricardo, 6- Pedro, 5- Fernando, 9-Luis.
  "if lv_edad =

  data lv_edad type i VALUE 8.
  data lv_nombre type string VALUE 'Daniel'.
  data lv_pelo type string VALUE 'moreno'.

  if lv_nombre = 'Daniel'.
  case lv_edad.
        when 8.
            if lv_pelo = 'castaño'.
                out->write( 'el padre se llama Ricardo' ).
            else.
                out->write( 'el padre se llama Gonzalo' ).
            ENDIF.

        when 6.
            out->write( 'el padre se llama Pedro' ).
        when 5.
            out->write( 'el padre se llama Fernando' ).
        when 9.
            out->write( 'el padre se llama Luis' ).
        when others.
            out->write( 'no se sabe el nombre del padre de Daniel' ).
  ENDCASE.

   else.
            out->write( 'no ningun niño llamado Daniel' ).
   ENDIF.












  ENDMETHOD.
ENDCLASS.
