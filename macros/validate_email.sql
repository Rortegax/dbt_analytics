/*
    Macro que recibe un email y devuelve True si es valido o False.
    Forma de uso: {{ validate_email('email') }}
*/
{% macro validate_email(email) %}
    CASE
        WHEN {{ email }} ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$' THEN TRUE
        ELSE FALSE
    END AS valid_email
{% endmacro %}

