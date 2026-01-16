with searches as (
    select * from {{ ref('stg_searches') }}
),
bookings as (
    select * from {{ ref('stg_bookings') }}
)

select
    s.search_id,
    s.user_id,
    s.search_at,
    s.search_date,
    s.origin,
    s.destination,
    b.booking_id,
    b.price,
    b.ticket_class,
    -- Core Product Logic: A search is converted if it has a successful booking
    case when b.booking_id is not null and b.is_successful = 1 then true else false end as is_converted
from searches s
left join bookings b on s.search_id = b.search_id