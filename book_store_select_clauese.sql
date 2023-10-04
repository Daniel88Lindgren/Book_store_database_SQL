
-- Welcome to the Book Store 
-- Here is select item's from both the 'Godkänt' and 'Väl godkänt' tasks from the top to the bottom.'
-- If there's any questions or errors please let me know. Enjoy!



CREATE DATABASE IF NOT EXISTS book_store_Select_and_other;
USE book_store;





-- Get data from orders and who purchage the product----------------------------------------------------------------

SELECT
orders.order_date AS Order_date,
orders.order_status AS Order_status, 
orders.order_id AS Order_id,
costumer.firstName AS First_name, 
costumer.adress AS Shipping_adress,
product_order_link.product_id AS Product_Id,
product.product_name AS Product,
product.product_price AS Price,
product.library_id AS Store_Id

FROM orders

JOIN costumer
ON orders.costumer_id = costumer.costumer_id

JOIN product_order_link
ON orders.order_id = product_order_link.order_id

JOIN product
ON product_order_link.product_id = product.product_id;







-- Get data from the Library wich Employee is working there--------------------------------------------------------------

SELECT
library.library_adress AS Adress,
library.open_hours AS Open_hours,
employee.employee_id AS Emplyee_Id,
employee.firstname AS First_name
FROM library
INNER JOIN employee ON library.library_id = employee.library_id
ORDER BY library.library_adress;






-- Check who of the Employee has salary over 35000 kr------------------------------------------------------------------------

SELECT * FROM employee
WHERE salary > 35000;






-- Check all the Costumers that are members of Book Store on Köpmansgatan 7--------------------------------------------------

SELECT 
firstname AS First_name,
lastname AS Last_name,
library_name AS Library,
library_adress AS Adress
FROM costumer_library_link

JOIN costumer 
ON costumer_library_link.costumer_id = costumer.costumer_id

JOIN library
ON costumer_library_link.library_id = library.library_id

WHERE library.library_adress = "Köpmansgatan 7";






-- Get data from Employees who is manager for each library-----------------------------------------------

SELECT
library.library_id,
library.library_name,
library_adress,
employee.firstname AS Manager
FROM library

LEFT JOIN employee ON library.library_id = employee.library_id AND employee.job_title = 'Manager';




-- Find all costumer who are born in the 2000 and sort them from low to high--------------------------------

SELECT * FROM costumer
WHERE costumer_id IN (SELECT costumer_id FROM costumer WHERE social_security_nr  > 20000000)
ORDER BY social_security_nr;






-- Easy way to look for costumers order data------------------------------------------------------------

CREATE VIEW costumer_order_status AS
SELECT 
costumer.firstname AS First_name,
costumer.email AS E_mail,
costumer.adress AS Delivery_adress,
product.product_name AS Product,
product.product_price AS Price,
orders.order_date AS Order_date,
orders.order_status AS Status_of_order

FROM costumer

JOIN product
ON product.product_id = costumer.costumer_id

JOIN orders
ON orders.order_id = costumer.costumer_id
ORDER BY order_date;


-- Use the costumer_order_status VIEW
SELECT * FROM book_store.costumer_order_status;





-- New product has arrived to one of the stores-----------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE insert_product
(
	IN product_name VARCHAR (30),
    IN product_price INT,
    IN product_genre VARCHAR(30),
    IN library_id INT
)
BEGIN
	
    INSERT INTO product (product_name, product_price, product_genre, library_id)
    VALUES (product_name, product_price, product_genre, library_id);
END$$
DELIMITER ;


CALL insert_product("Star Wars", 599, "Fiction",2);

-- Look at result in bottom column
SELECT * FROM product;





-- The manager raises the income which results a higher tax-----------------------------------------------

DELIMITER $$

CREATE TRIGGER employee_high_income_tax
	BEFORE UPDATE ON employee
    FOR EACH ROW
    
BEGIN
	IF NEW.salary > 59000 THEN
		
		SET SQL_SAFE_UPDATES = 0;
        SET NEW.salary = NEW.salary * 0.65;
        SET SQL_SAFE_UPDATES = 1;
        
	END IF;
	
END $$
    
DELIMITER ;



-- Raised income
UPDATE employee
SET salary = 60000
WHERE employee_id IN (3,6);




-- New income after higher tax. Not so much higher afterall....
SELECT * FROM employee
ORDER BY salary;





