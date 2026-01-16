select
    booking_id,
    search_id,
    amount_eur as price,
    payment_status,
    ticket_class,
    case when payment_status = 'Success' then 1 else 0 end as is_successful
from {{ source('railflow_raw', 'bookings') }}