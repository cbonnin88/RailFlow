SELECT
  user_id,
  timestamp AS current_search,
  -- Looking at the NEXT rows timestamp for the same user
  LEAD(timestamp) OVER(PARTITION BY user_id ORDER BY timestamp) AS next_search,
  DATETIME_DIFF(
    LEAD(timestamp) OVER(PARTITION BY user_id ORDER BY timestamp),
    timestamp,
    MINUTE
  ) AS minutes_until_next_search
FROM `railflow-484310.railflow_dataset.searches`
ORDER BY
  user_id,
  timestamp
LIMIT 100;