CLASS zcl_ejer_arr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_arr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data lv_edad TYPE i VALUE 15.
 "ofrecer un descuento de un 10% a personas entre 1-12 años, descuento del 5% a personas entre 12_18
 "precio normal a personas entre 18_65 años,
 "descuento del 5% a mayores de 65.

* data lv_tarifa type i VALUE 25.
*
*        if lv_edad >= 1 and lv_edad <= 12.
*            out->write( 'el es descuento es del 10%' ).
*
*           elseif lv_edad > 12 and lv_edad <= 18.
*             out->write( 'descuento del 5%' ).
*           elseif lv_edad > 18 and lv_edad <= 65.
*             out->write( 'precio normal'  ).
*           elseif lv_edad > 65.
*             out->write( 'descuento del 5%' ).
*           else.
*             out->write( 'Entrada gratuita' ).
*          ENDIF.

"""""""""""""""""""""""""""""""""""""""""""""""""""

*"Ejercicio rebuscado: "El calculador de costes de envío del almacén"
*Te he preparado un ejercicio con bastante mala leche: a primera vista parece una cadena
*de IF sencilla, pero el orden de las comprobaciones y los solapamientos de rangos están diseñados
*para que se cometan errores típicos. Es perfecto para formación, porque obliga a leer el enunciado con lupa.

*Contexto
*Tienes que implementar un método de una clase ABAP Cloud llamado calcular_coste_envio. El método recibe
*los datos de un pedido y devuelve el coste final más un código de estado.
*
*Parámetros de entrada (IMPORTING):
*
*iv_peso — peso en kg, tipo decimal (por ejemplo p LENGTH 8 DECIMALS 2)
*iv_zona — zona de destino, tipo char1 (valores esperados: 'A', 'B', 'C')
*iv_tipo_cliente — tipo char10 ('PREMIUM' o 'NORMAL')
*iv_urgente — tipo abap_bool
*iv_peligroso — tipo abap_bool
*Parámetros de salida (EXPORTING / RETURNING):
*
*ev_coste — coste final, decimal con 2 decimales
*ev_codigo — tipo char20 (código de resultado: 'OK', un código de error, o un aviso)
*Las reglas (léelas enteras antes de empezar)
*1. Validaciones de entrada
*
*Si iv_peso es 0 o negativo → ev_codigo = 'PESO_INVALIDO', ev_coste = 0 y termina.
*Si iv_zona no es 'A', 'B' ni 'C' → ev_codigo = 'ZONA_INVALIDA', ev_coste = 0 y termina.
*2. Tarifa base según el peso (¡cuidado con los límites!)
*
*Hasta 5 kg incluidos → 5 €
*Más de 5 y hasta 20 incluidos → 12 €
*Más de 20 y hasta 50 incluidos → 25 €
*Más de 50 kg → 25 € + 1 € por cada kg (o fracción) que supere los 50
*3. Recargo por zona
*
*Zona 'A' → +0 € · Zona 'B' → +8 € · Zona 'C' → +15 €
*4. Urgencia
*
*Si iv_urgente = abap_true y la zona es 'A' o 'B' → el coste acumulado hasta aquí se multiplica por 1,5.
*Si iv_urgente = abap_true y la zona es 'C' → la urgencia no está disponible: en lugar de multiplicar, se suma
* un recargo fijo de +30 € y ev_codigo debe quedar como 'URGENCIA_LIMITADA'.
*5. Descuento de cliente PREMIUM
*
*Si iv_tipo_cliente = 'PREMIUM' → descuento del 20 % sobre el coste acumulado. Pero este descuento NO se aplica si:
*el envío es peligroso (iv_peligroso = abap_true), o
*el coste acumulado antes del descuento supera los 200 €.
*6. Producto peligroso
*
*Si iv_peligroso = abap_true → recargo del 40 % sobre el coste acumulado.
*Si iv_peligroso = abap_true y la zona es 'C' → envío prohibido: ev_codigo = 'PELIGROSO_ZONA_C', ev_coste = 0.
*7. Coste mínimo
*
*El coste final nunca puede ser inferior a 10 € (salvo los casos de error, que son 0).
*8. Redondeo final a 2 decimales.
*
*Las trampas (que es lo divertido)
*Sin dártelas resueltas, aquí están los puntos donde casi todo el mundo falla:
*
*Los límites de los tramos. Un paquete de exactamente 5 kg ¿va a 5 € o a 12 €? Si escribes iv_peso < 5
*en lugar de <= 5, ya tienes un bug. Lo mismo en 20 y 50.
*La regla 6 está mal colocada a propósito. La prohibición PELIGROSO_ZONA_C aparece en el punto 6,
* pero si la programas ahí habrás calculado tarifa, recargos, urgencia y descuento para nada.
* ¿Dónde debería ir realmente esa comprobación? (Pista: junto a las validaciones del punto 1.)
*El descuento PREMIUM tiene doble excepción y una de ellas (> 200 €) depende de un valor que aún no es el final.
*Tienes que decidir bien en qué momento "congelas" ese importe.
*Urgencia en zona C no es un multiplicador, es un recargo fijo y además cambia el código de salida.
*El coste mínimo de 10 € se aplica al final de todo. Un envío barato (base 5, zona A) acaba costando 10, no 5.
*Restricción del ejercicio
*Solo puedes usar IF / ELSEIF / ELSE. Nada de CASE, nada de LOOP, nada de tablas internas. El reto es estructurar
* bien los condicionales anidados y secuenciales sin perderte.
*
*Pistas de ABAP Cloud (porque no es ABAP clásico)
*Compara los booleanos de forma explícita: IF iv_urgente = abap_true. — no uses el atajo IF iv_urgente.
*aunque funcione; en ABAP Cloud se valora el código claro y limpio.
*Declara variables con declaración inline donde puedas: DATA(lv_coste) = ....
*Para "1 € por cada kg o fracción que supere los 50" te vendrá bien la función ceil( ).
*En ABAP clásico verías a menudo MOVE o variables globales; aquí trabajas dentro de un método de una clase,
*todo con variables locales y parámetros tipados. Es el mismo IF, pero el contexto es estricto: sin sentencias obsoletas.
*Tabla de comprobación (tu clave de corrección)
*Cuando tengas tu solución, verifica estos casos. Si alguno no cuadra, has caído en una trampa:
*
* 
*
*peso    zona    cliente urgente peligroso   Resultado esperado
*3   A   NORMAL  no  no  10,00 € (base 5 → mínimo 10)
*5   B   NORMAL  no  no  13,00 € (5 va al tramo de 5 €)
*10  A   PREMIUM sí  no  14,40 € (12 ×1,5 = 18; −20 %)
*60  C   NORMAL  sí  no  80,00 € + código URGENCIA_LIMITADA
*10  B   PREMIUM no  sí  28,00 € (sin descuento; +40 %)
*10  C   NORMAL  no  sí  0,00 € + código PELIGROSO_ZONA_C
*100 C   PREMIUM sí  no  96,00 €
*−2  A   NORMAL  no  no  0,00 € + código PESO_INVALID

out->write( 'Ejercicio 1' ).
out->write( | | ).
DATA lv_calcular_coste_envio TYPE p length 8 decimals 2 value 65.
data lv_pedido TYPE p length 8 decimals 2.
data lv_coste_final TYPE p length 8 decimals 2.
data lv_codigo_estado TYPE string.
data lv_peso TYPE p length 8 decimals 2 value 55.
data lv_zona type string VALUE 'C'. "A, B, C
DATA LV_tipo_cliente type string VALUE 'Normal'. "Normal, Premiun
data lv_urgente TYPE i VALUE 1. "1 true, 2 false
data lv_peligroso type i value 1. "1 true, 2 false
data lv_coste_extra type i.
data lv_descuento TYPE i.


 if lv_peso <= 0.
    lv_codigo_estado = 'PESO INVALIDO'.
    lv_coste_final = 0.

        elseif lv_peso <= 5.
        lv_coste_final = 5.
        elseif lv_peso between 5 and 20.
        lv_coste_final = 12.
        elseif lv_peso > 20 and lv_peso <= 50.
        lv_coste_final = 25.
        else.
            lv_peso = 55.
            lv_coste_extra = lv_peso - 50.
            lv_coste_final = 25 + lv_coste_extra .

  ENDIF.

 if lv_zona <> 'A' or lv_zona <> 'B' or lv_zona <> 'C'.
    lv_codigo_estado = 'ZONA INVALIDA'.
    lv_coste_final = 0.

          elseif lv_zona = 'A'.
          elseif lv_urgente = 1.
                lv_coste_final = lv_coste_final + 0 * '1.5'."los numeros decimales se ponen comillas simples
          else.
                    lv_coste_final = lv_coste_final + 0.
  endif.


  if lv_zona = 'B'.
          elseif lv_urgente = 1.
                lv_coste_final = lv_coste_final + 8 * '1.5'."los numeros decimales se ponen comillas simples
          else.
                        lv_coste_final = lv_coste_final + 8.
  endif.


  if lv_zona = 'C'.
          elseif lv_urgente = 1.
                lv_coste_final = lv_coste_final + 15 + 30.

  ENDIF.
                out->write( | { lv_codigo_estado }  URGENCIA LIMITADA | ).

                out->write( lv_coste_final ).


 IF lv_tipo_cliente = 'PREMIUM'.

     lv_descuento = lv_coste_final * '20%'.

     elseif lv_peligroso or lv_coste_final > 200.

     lv_descuento = 0.

 ENDIF.

        out->write( lv_descuento ).





























  ENDMETHOD.
ENDCLASS.
