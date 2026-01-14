select
    user_id,
    -- standardized casing
    lower(subscription_type) as subscription_type, 
    age,
    device_os,
    -- Handle missing signup dates if any
    coalesce(signup_date, '2023-01-01') as signup_date
from {{ source('railflow_raw', 'users') }}