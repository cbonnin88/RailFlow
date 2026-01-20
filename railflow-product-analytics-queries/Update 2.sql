UPDATE `railflow-484310.railflow_dataset.searches`
SET user_id = (
    SELECT user_id 
    FROM `railflow-484310.railflow_dataset.valid_user_pool`
    ORDER BY RAND() 
    LIMIT 1
)
WHERE TRUE;