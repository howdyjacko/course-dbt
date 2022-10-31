{%macro aggregrates_count_macros(table, columns) %}

SELECT {{ columns }}, count(*) as count_of_occurences
FROM {{ ref(table) }}
GROUP BY {{ columns }}

{% endmacro %}