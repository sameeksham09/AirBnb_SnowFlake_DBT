{{ 
    config(
        materialized='incremental' , keys='booking_id')
}}

Select booking_id,listing_id, booking_date,
{{ multiply('nights_booked', 'booking_amount', 2) }} AS total_booking_amount
from {{ ref("bronze_bookings") }}

