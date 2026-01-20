SELECT * FROM (
  SELECT
    u.subscription_type,
    s.destination_station,
    COUNT(*) AS search_count,
    -- RANK destinations within each subscription type group
    RANK() OVER(PARTITION BY u.subscription_type ORDER BY COUNT(*) DESC) AS ranking
  FROM `railflow-484310.railflow_dataset.searches` AS s
  LEFT JOIN `railflow-484310.railflow_dataset.users` AS u
    ON s.user_id = u.user_id
  GROUP BY
    1,2
)
WHERE ranking <= 3 -- only showing the top 3 destinations per persona
ORDER BY
  subscription_type,
  ranking