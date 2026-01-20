SELECT
  u.user_id,
  COUNT(b.booking_id) AS total_bookings,
  CASE
    WHEN COUNT(b.booking_id) >= 5 THEN 'Power user'
    WHEN COUNT(b.booking_id) BETWEEN 2 AND 4 THEN 'Regular'
    ELSE 'One-time'
  END AS user_segment
FROM `railflow-484310.railflow_dataset.users` AS u
LEFT JOIN `railflow-484310.railflow_dataset.searches` AS s
  ON u.user_id = s.user_id
LEFT JOIN `railflow-484310.railflow_dataset.bookings` AS b
  ON s.search_id = b.search_id
GROUP BY
  1
ORDER BY 
  2 DESC
LIMIT 10;