{{ config(
    materialized = 'incremental'
) }}

SELECT * FROM {{ source('staging', 'hosts') }}
{% if is_incremental() %}
    WHERE CREATED_AT > (
        SELECT COALESCE(MAX(CREATED_AT), '1970-01-01') 
        FROM {{ this }}
    )
{% endif %}