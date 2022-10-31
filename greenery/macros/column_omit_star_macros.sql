{%macro column_omit_star_macros(table, columns) %}

select {{ dbt_utils.star(from=ref(table), except=[COLUMN]) }}
from {{ ref(table) }}

{% endmacro %}