/* 
    Macro para calcular el precio total por linea de orden/ticket/venta/perro/whatever 
*/
{% macro calculate_extended_cost(quantity, price) %}
    {{ quantity }} * {{ price }}
{% endmacro %}