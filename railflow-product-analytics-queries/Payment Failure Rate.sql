SELECT
  FORMAT_DATE('%A',s.timestamp) AS day_of_week, -- e.g 'Monday'
  COUNT(*) AS total_attempts,
  COUNTIF(b.payment_status = 'Failed') AS fail_attempts,
  ROUND(COUNTIF(b.payment_status = 'Failed') / COUNT(*), 4) AS failure_rate
FROM `railflow-484310.railflow_dataset.searches` AS s
JOIN `railflow-484310.railflow_dataset.bookings` AS b
  ON s.search_id = B.search_id
GROUP BY  
  1
ORDER BY
  failure_rate DESC;