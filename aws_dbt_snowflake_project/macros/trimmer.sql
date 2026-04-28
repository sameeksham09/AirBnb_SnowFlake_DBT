{% macro trimmer(column_name, node) %}
    {{ columnname | trim | upper }}
{% endmacro %}