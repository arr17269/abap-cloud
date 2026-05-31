CLASS zcl_ej_calculadora_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ej_calculadora_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "crear una calculadora para calculos dependiendo de la operacion matematica.
  "el usuario ha de llamarse Paco.
  "primero declarar las variables para poder operar: nombre; operacion; numero 1, numero 2, resultado.
  "se declara con DATA y con lv_ (de variable)

  DATA lv_nombre type string VALUE 'Paco'.
  data lv_operacion TYPE string value '/'.   "esta variable no admite decfloat34.

  DATA lv_num1 TYPE decfloat34 VALUE 25.
  DATA lv_num2 type decfloat34 VALUE 0.
  DATA lv_resultado type decfloat34.            "no le ponemos valor, porque almacena el resultado de la operacion.

  If lv_nombre = 'Paco'.  "primer IF

  case lv_operacion.                           "calculamos segun la operacion que pongamos
        when '+'.
        lv_resultado = lv_num1 + lv_num2.
        when '-'.
        lv_resultado = lv_num1 - lv_num2.
        when '*'.
        lv_resultado = lv_num1 * lv_num2.
        when '/'.

            IF                                  "un IF dentro de otro IF
                lv_num2 <> 0.
                lv_resultado = lv_num1 / lv_num2.
            else.
                out->write( | Error: division entre cero no permitida | ).
                RETURN.
             ENDIF.

        when others.
            out->write( | Operacion no reconocida:usa +, -, *, / | ).   "cuidado con los espacios en blanco
            RETURN.                                  "ha ocurrido un error, sal del metodo y no ejecutes y devuelve el control
                                                      "desde al punto desde donde fue llamado.
 ENDCASE.
            out->write( | El resultado es: { lv_num1 } { lv_operacion } { lv_num2 } = { lv_resultado } | ).

  Else.
        out->write( |Acceso denegado. Solo Paco puede usar la calculadora| ).

 ENDIF.



  ENDMETHOD.
ENDCLASS.
