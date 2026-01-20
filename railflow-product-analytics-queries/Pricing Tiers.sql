SELECT 
  ticket_class,
  ROUND(AVG(amount_eur),2) AS avg_price,
  ROUND(MIN(amount_eur),2) AS min_price,
  ROUND(MAX(amount_eur),2) AS max_price
FROM `railflow-484310.railflow_dataset.bookings`
GROUP BY
  1;