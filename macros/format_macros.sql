/*
- ha ha ha, no has dicho la palabra mágica :)

-- ha 	    ha 	    ha

  , ; ,   .-'"""'-.   , ; ,
  \\|/  .'         '.  \|//
   \-;-/   ()   ()   \-;-/
   // ;               ; \\
  //__; :.         .; ;__\\
 `-----\'.'-.....-'.'/-----'
        '.'.-.-,_.'.'
hah       '(  (..-'

*/

/*
Macro que devuelve el delta de fivetran formateado a la zona horaria del proyecto.
Opcionalmente, formatea la etiqueta de si esta borrado el registro a true o false.

Ejemplos de llamada:

Un argumento: {{ format_fivetran_fields('_fivetran_synced') }}
Dos: {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}

*/
{% macro format_fivetran_fields(synced, deleted = None) %}
    {% if deleted is not none %}
        COALESCE({{ deleted }}, FALSE) AS is_deleted,
    {% endif %}
    CONVERT_TIMEZONE('{{ var('timezone')}}', {{ synced }}::TIMESTAMP) AS date_loaded
{% endmacro %}
/*
    Macro que formatea las fechas como YYYY-MM-DD

    Como parametro adicional, si se le pasa una timezone,
    devuelve la fecha en el timezone adecuado para el proyecto <timezone>.

    Forma de uso: {{ format_dates('created_at', var('timezone')) (Optional) }} AS 'desired_camp'
*/
{% macro format_dates(date, timezone = None) %}
    TO_CHAR(
    {% if timezone is not none %}
        CONVERT_TIMEZONE('{{ timezone }}', {{ date }})
    {% else %}
        date
    {% endif %}
    , 'YYYY-MM-DD')
{% endmacro %}