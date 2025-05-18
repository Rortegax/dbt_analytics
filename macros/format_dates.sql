
/*
    Macro que devuelve una fecha en el timezone adecuado para el proyecto <timezone>.
    Forma de uso: {{ format_dates('created_at', var('timezone')) }} AS 'desired_camp'
*/
{% macro format_dates(date, timezone) %}
  CONVERT_TIMEZONE('{{ timezone }}', {{ date }})
{% endmacro %}