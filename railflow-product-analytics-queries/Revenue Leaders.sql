SELECT 
  s.origin_station,
  s.destination_station,
  ROUND(SUM(b.amount_eur),2) AS total_revenue
FROM `railflow-484310.railflow_dataset.bookings` AS b
INNER JOIN `railflow-484310.railflow_dataset.searches` AS s
  ON b.search_id = s.search_id
GROUP BY 
  1,2
ORDER BY
 3 DESC
LIMIT 5;