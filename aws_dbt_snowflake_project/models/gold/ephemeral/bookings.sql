{{ config(
    materialized = 'ephemeral'
) }}

WITH bookings AS (
    SELECT 
        booking_id, 
        booking_date, 
        booking_status, 
        created_at
    FROM {{ ref('bronze_bookings') }}
) 
SELECT * FROM bookings