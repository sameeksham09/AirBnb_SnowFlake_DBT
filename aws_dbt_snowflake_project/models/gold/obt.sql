{% set configs = [
    {
        "table": ref('silver_bookings'),
        "columns": "SILVER_bookings.*",
        "alias": "SILVER_bookings",
    },
    {
        "table": ref('silver_listings'),
        "columns": "SILVER_listings.HOST_ID,  SILVER_listings.PROPERTY_TYPE, SILVER_listings.ROOM_TYPE, SILVER_listings.CITY,SILVER_listings.COUNTRY, SILVER_listings.ACCOMMODATES, SILVER_listings.BEDROOMS, SILVER_listings.BATHROOMS, SILVER_listings.PRICE_PER_NIGHT, SILVER_listings.PRICE_PER_NIGHT_TAG, SILVER_listings.CREATED_AT AS LISTING_CREATED_AT",
        "alias": "SILVER_listings",
        "join_condition": "SILVER_bookings.listing_id = SILVER_listings.listing_id",
    },
    {
        "table": ref('silver_hosts'),
        "columns": "SILVER_hosts.RESPONSE_RATE, SILVER_hosts.RESPONSE_RATE_CATEGORY, SILVER_hosts.HOSTNAME",
        "alias": "SILVER_hosts",
        "join_condition": "SILVER_listings.host_id = SILVER_hosts.host_id",
    },
] %}

select
    {% for config in configs %}
        {{ config["columns"] }} {% if not loop.last %}, {% endif %}
    {% endfor %}
from
{% for config in configs %}
    {% if loop.first %} {{ config["table"] }} as {{ config["alias"] }}
    {% else %}
        left join
            {{ config["table"] }} as {{ config["alias"] }}
            on {{ config["join_condition"] }}
    {% endif %}
{% endfor %}