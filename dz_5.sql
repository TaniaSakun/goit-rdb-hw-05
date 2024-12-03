-- Task 1: Display order_details with customer_id Using a Subquery in SELECT
SELECT
    od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM order_details od;

-- Task 2: Filter order_details Where shipper_id = 3 Using a Subquery in WHERE
SELECT *
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);

-- Task 3: Use a Subquery in FROM to Find Average Quantity Grouped by order_id
SELECT 
    sub.order_id,
    AVG(sub.quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS sub
GROUP BY sub.order_id;

-- Task 4: Solve Task 3 Using WITH
WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM temp
GROUP BY temp.order_id;

-- Task 5: Create a Function to Divide Two FLOAT Parameters
DROP FUNCTION IF EXISTS divide_float;

DELIMITER $$

CREATE FUNCTION divide_float(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF b = 0 THEN
        RETURN NULL;
    ELSE
        RETURN a / b;
    END IF;
END$$

DELIMITER ;

SELECT 
    od.*,
    divide_float(od.quantity, 2.0) AS divided_quantity
FROM order_details od;