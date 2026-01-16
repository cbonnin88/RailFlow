select
    search_id,
    user_id,
    timestamp as search_at,
    date(timestamp) as search_date,
    origin_station as origin,
    destination_station as destination,
    departure_date
from {{ source('railflow_raw', 'searches') }}