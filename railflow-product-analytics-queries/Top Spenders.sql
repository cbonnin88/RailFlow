SELECT
  user_id,
  ROUND(SUM(amount_eur),2) AS total_spend_eur  
FROM `railflow-484310.railflow_dataset.bookings` AS b
JOIN `railflow-484310.railflow_dataset.searches` AS s
  ON b.search_id = s.search_id
GROUP BY
  1
HAVING total_spend_eur > (
  -- Subquery: Calculating global average spend per user
  SELECT AVG(user_total)
  FROM (
    SELECT SUM(amount_eur) AS user_total
    FROM `railflow-484310.railflow_dataset.bookings` AS b2
    JOIN `railflow-484310.railflow_dataset.searches` as s2
      ON b2.search_id = s2.search_id
    GROUP BY
      s2.user_id
  )
)
ORDER BY
  2 DESC
LIMIT 
  5;