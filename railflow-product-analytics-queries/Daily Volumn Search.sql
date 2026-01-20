SELECT
  DATE(timestamp) AS search_day,
  COUNT(search_id) as total_searches
FROM `railflow-484310.railflow_dataset.searches`
GROUP BY  
  1
ORDER BY
  1 DESC;