with users as (
    select * from {{ ref('stg_users') }}
),
user_stats as (
    select
        user_id,
        count(distinct search_id) as lifetime_searches,
        sum(case when is_converted then price else 0 end) as lifetime_revenue
    from {{ ref('int_search_bookings') }}
    group by 1
)

select
    u.user_id,
    u.subscription_type,
    u.age,
    coalesce(s.lifetime_revenue, 0) as ltv,
    case 
        when s.lifetime_revenue > 150 then 'VIP'
        when s.lifetime_revenue > 0 then 'Active'
        else 'Window Shopper'
    end as user_segment
from users u
left join user_stats s on u.user_id = s.user_id