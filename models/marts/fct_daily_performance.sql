with journey as (
    select * from {{ ref('int_search_bookings') }}
)

select
    search_date,
    origin,
    destination,
    count(distinct search_id) as total_searches,
    sum(case when is_converted then 1 else 0 end) as total_bookings,
    sum(case when is_converted then price else 0 end) as total_revenue
from journey
group by 1, 2, 3