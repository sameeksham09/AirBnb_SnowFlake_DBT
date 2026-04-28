{{ config(
    materialized = 'ephemeral'
) }}

WITH listings AS (
    SELECT 
        listing_id,
        property_type,
        room_type,
        city,
        country,
        accommodates
    FROM {{ ref('bronze_listings') }}
) 
SELECT * FROM listings