{{ config(
    materialized = 'ephemeral'
) }}

WITH hosts AS (
    SELECT 
        host_id,
        host_name,
        host_since,
        response_rate
    FROM {{ ref('bronze_hosts') }}
) 
SELECT * FROM hosts