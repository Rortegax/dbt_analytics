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
Ejemplos de llamada:

Un argumento: {{ format_fivetran_fields('_fivetran_synced') }}
Dos: {{ format_fivetran_fields('_fivetran_synced', '_fivetran_deleted') }}

*/
    {% macro format_fivetran_fields(synced, deleted = None) %}
        {% if deleted is not none %}
            {% if deleted %}
                COALESCE({{ deleted }}, FALSE) AS is_deleted,
            {% else %}
                False AS is_deleted, 
            {% endif %}
        {% endif %}
        CONVERT_TIMEZONE('{{ var('timezone')}}', {{ synced }}::TIMESTAMP) AS date_loaded
    {% endmacro %}
