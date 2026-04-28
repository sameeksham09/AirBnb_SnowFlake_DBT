{{ config (
    materialized = 'incremental',
    unique_key = 'host_id')
}}

SELECT 
    host_id,
    REPLACE(host_name, ' ', '_') AS hostname,
    response_rate AS response_rate,
    CASE 
        WHEN response_rate > 90 THEN 'good'
        WHEN response_rate > 80 THEN 'average'
        WHEN response_rate > 60 THEN 'fair'
        ELSE 'bad'
    END AS response_rate_category
FROM {{ ref("bronze_hosts") }}