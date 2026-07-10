CLASS zcl_dudas_groupby DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dudas_groupby IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

TYPES: BEGIN OF ty_resumen,
             agency_id    TYPE /dmo/travel-agency_id,
             num_reservas TYPE i,
             precio_total TYPE /dmo/travel-total_price,
             precio_medio TYPE /dmo/travel-total_price,
           END OF ty_resumen.

    " Declara un tipo tabla
    TYPES ty_t_resumen TYPE STANDARD TABLE OF ty_resumen WITH EMPTY KEY.

    " Recupera los datos de la BD
    SELECT FROM /dmo/travel
          FIELDS *
          INTO TABLE @DATA(lt_travel).

    DATA(lt_resumen) = VALUE ty_t_resumen(
      FOR GROUPS grupo_agencia OF ls_t IN lt_travel
      GROUP BY ls_t-agency_id
      ( agency_id    = grupo_agencia

        num_reservas =
                REDUCE i(
                    INIT count = 0
                    FOR ls_g
                    IN GROUP grupo_agencia
                    NEXT count = count + 1 )

        precio_total =
                REDUCE /dmo/travel-total_price(
                    INIT total = 0
                    FOR ls_g
                    IN GROUP grupo_agencia
                    NEXT total = total + ls_g-total_price )

        precio_medio =
                round(
                    val = REDUCE /dmo/travel-total_price(
                        INIT tot = 0
                        FOR ls_g
                        IN GROUP grupo_agencia
                        NEXT tot = tot + ls_g-total_price )

                        /

                        REDUCE i(
                            INIT cnt = 0
                            FOR ls_g
                            IN GROUP grupo_agencia
                            NEXT cnt = cnt + 1 )

                               dec = 2 )
                      ) ).

    out->write( lt_resumen ).

  ENDMETHOD.
ENDCLASS.
