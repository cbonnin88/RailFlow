WITH DailyRevenue AS (
  SELECT
    DATE(s.timestamp) AS day,
    ROUND(SUM(b.amount_eur),2) AS daily_revenue
  FROM `railflow-484310.railflow_dataset.searches` AS s
  JOIN `railflow-484310.railflow_dataset.bookings` AS b
    ON s.search_id = b.search_id
  GROUP BY  
    1
)
SELECT *
FROM DailyRevenue
WHERE DailyRevenue.daily_revenue > 500 -- Adjusting the threshold based on my data volume
ORDER BY
  daily_revenue DESC;