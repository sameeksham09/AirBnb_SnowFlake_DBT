{% set configs = [
    {
        "table": ref('obt'),
        "columns": "GOLD_obt.booking_id,GOLD_obt.total_booking_amount, gold_obt.accommodates, gold_obt.price_per_night",
        "alias": "GOLD_obt",
    },
    {
        "table": ref('dim_listings'),
        "columns": "",
        "alias": "GOLD_listings",
        "join_condition": "GOLD_obt.listing_id = gold_obt.listing_id",
    },
    {
        "table": ref('dim_hosts'),
        "columns": "",
        "alias": "GOLD_hosts",
        "join_condition": "gold_obt.host_id = gold_obt.host_id",
    },
] %}

select
    
        {{ configs[0]["columns"] }}
from
{% for config in configs %}
    {% if loop.first %} {{ config["table"] }} as {{ config["alias"] }}
    {% else %}
        left join
            {{ config["table"] }} as {{ config["alias"] }}
            on {{ config["join_condition"] }}
    {% endif %}
{% endfor %}