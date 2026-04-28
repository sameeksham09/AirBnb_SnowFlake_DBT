{{ config(
    severity = "warn"
) }}

SELECT 1
FROM {{ source('staging', 'bookings') }}
where
booking_amount < 200