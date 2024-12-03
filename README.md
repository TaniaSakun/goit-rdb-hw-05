# goit-rdb-hw-05
The repository for the 5th GoItNeo Relational Databases homework

Homework Description

### Task 1
Write an SQL query that will display the order_details table and the customer_id field from the orders table according to each field of a record from the order_details table.
This should be done using a nested query in the SELECT statement.

```
SELECT
    od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM order_details od;
```
<img width="753" alt="p1" src="https://github.com/user-attachments/assets/af579baa-faaa-4bb5-ac79-f0b58502354e">

### Task 2
Write an SQL query that will display the order_details table. Filter the result so that the corresponding record from the orders table satisfies the condition shipper_id=3.
This should be done using a nested query in the WHERE statement.

```
SELECT *
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);
```
<img width="716" alt="p2" src="https://github.com/user-attachments/assets/b00f31c0-e577-4abc-a705-317ba61639e6">

### Task 3
Write an SQL query nested in FROM statements that will select rows with the condition quantity > 10 from the order_details table. To obtain the data, find the average value of the quantity field—group by order_id.

```
SELECT 
    sub.order_id,
    AVG(sub.quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS sub
GROUP BY sub.order_id;
```
<img width="779" alt="p3" src="https://github.com/user-attachments/assets/a7a99878-88bb-4c7f-a60e-3ecac07a008e">

### Task 4
Solve problem 3 using the WITH statement to create a temporary table temp. If your MySQL version is earlier than 8.0, create a query similar to this one, as done in the abstract.

```
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
```
<img width="468" alt="p4" src="https://github.com/user-attachments/assets/ff504d57-7258-4831-9cbb-fc99b9113440">

### Task 5
Create a two-parameter function that will split the first parameter into the second. Both parameters and the return value must be of type FLOAT.
Use the DROP FUNCTION IF EXISTS construct. Apply the function to the quantity attribute of the order_details table. The second parameter can be a free number of your choice.

```
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
```
<img width="726" alt="p5" src="https://github.com/user-attachments/assets/b7f1d146-e72d-4559-99f7-aa57c7cbd234">
