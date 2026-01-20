SELECT 
  s.origin_station,
  s.destination_station,
  COUNT(s.search_id) AS total_bookings,
  -- SAFE DIVIDE handles division by zero automatically
  ROUND(SAFE_DIVIDE(COUNT(b.booking_id), COUNT(s.search_id)),4) AS conversion_rate
FROM `railflow-484310.railflow_dataset.searches` AS s
LEFT JOIN `railflow-484310.railflow_dataset.bookings` as b
  ON s.search_id = b.search_id
GROUP BY
  1,2
ORDER BY
  3 DESC
LIMIT 10;