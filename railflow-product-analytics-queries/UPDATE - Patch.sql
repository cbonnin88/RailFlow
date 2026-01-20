CREATE OR REPLACE TABLE `railflow-484310.railflow_dataset.valid_user_pool` AS
SELECT user_id, 
       subscription_type
FROM `railflow-484310.railflow_dataset.users` LIMIT 1000;
