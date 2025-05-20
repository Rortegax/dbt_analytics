-- Validate a phone field to match US format
{% test validate_phone(phone_number_field, model) %}
    {{ config(severity = 'warn') }}

    SELECT
        {{ phone_number_field }}
    FROM {{ model }}
    WHERE {{ phone_number_field }} ~ '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'
{% endtest %}

-- Validate the format of an email field 
{% test validate_email(email_field, model) %}
    {{ config(severity = 'warn') }}

    SELECT
        {{ email_field }}
    FROM {{ model }}
    WHERE {{ email_field }} ~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
{% endtest %}

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