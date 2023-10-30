-- Hello daniel
-- Welcome to the Book Store! 
-- 1 all tables along with their values
-- 2 all link tables
-- 3 CRUD
-- If there's any questions or errors please let me know. Enjoy!

CREATE DATABASE IF NOT EXISTS book_store;
USE book_store;





CREATE TABLE IF NOT EXISTS library
(
	library_id INT PRIMARY KEY AUTO_INCREMENT,
    library_name VARCHAR(30),
    library_adress VARCHAR(30),
    open_hours VARCHAR(30)
);

INSERT INTO library VALUES
	(DEFAULT, "Book Store", "Köpmansgatan 7", "Open 08:00 Close 18:00"),
    (DEFAULT, "Book Store", "Klostervägen 23", "Open 09:00 Close 20:00");




CREATE TABLE IF NOT EXISTS product
(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(30),
    product_price INT,
    product_genre VARCHAR (20),
    library_id INT,
    FOREIGN KEY (library_id)
    REFERENCES library (library_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO product VALUES
	(DEFAULT, "Kameler", 320, "Facts",1),
    (DEFAULT, "Rymdraketer", 299, "Facts",2),
    (DEFAULT, "Harry Potter", 499, "Fiction",1),
    (DEFAULT, "Sagan om ringen", 360, "Fiction",2),
    (DEFAULT, "Michael Jacksson", 400, "Autobiography",1),
    (DEFAULT, "Donald Trump", 390, "Autobiography",2);




CREATE TABLE IF NOT EXISTS costumer
(
	costumer_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    email VARCHAR(30),
    social_security_nr INT,
    adress VARCHAR(30),
    phone_nr INT
);

INSERT INTO costumer VALUES
	(DEFAULT, "Kalle", "Sunesson", "sune@gmail.com", 19880302, "Stengatan 7", 0764323567),
    (DEFAULT, "Bert", "Karlsson", "bert@gmail.com", 19890412, "Furuvögen 7", 0703245678),
    (DEFAULT, "Krister", "Karlsson", "krister@gmail.com", 20030517, "Kvistvägen 22", 0706124356),
    (DEFAULT, "Kajsa", "Andersson", "kajsa@gmail.com", 20150912, "Kråkvägen 11", 0706564433),
    (DEFAULT, "Måns", "Herrgren", "mans@gmail.com", 20180911, "Stråkvägen 21", 0765439966),
    (DEFAULT, "Rebecka", "Ullvesson", "becca@gmail.com", 19680912, "Krusgatan 1", 0703454234),
    (DEFAULT, "Sonja", "Turesson", "sonja@gmail.com", 19761224, "Urvägen 23", 0765889922),
    (DEFAULT, "Kristina", "Kristensson", "kriss@gmail.com", 20000101, "Skogatan 5", 0765339988);




CREATE TABLE IF NOT EXISTS orders
(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    amount INT,
    order_date DATE,
    order_status VARCHAR(30),
    costumer_id INT,
    
    FOREIGN KEY (costumer_id)
    REFERENCES costumer(costumer_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO orders VALUES
	(DEFAULT, 1, "2023-09-20", "Package on the way", 1),
    (DEFAULT, 2, "2023-09-25", "Package waiting for transport", 2),
    (DEFAULT, 1, "2023-09-28", "Order recived", 3);

    
        

CREATE TABLE IF NOT EXISTS employee
(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	firstname VARCHAR(30),
    lastname VARCHAR(30),
    email VARCHAR(30),
    social_security_nr INT,
    adress VARCHAR(30),
    phone_nr INT,
    salary INT,
    job_title VARCHAR(30),
    
    library_id INT,
    FOREIGN KEY (library_id)
    REFERENCES library(library_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO employee VALUES
	(DEFAULT, "Berit", "Herrsson", "berra@gmail.com", 19880702, "Örevägen 7", 0706598374, 32000, "Librarian",1),
    (DEFAULT, "Tårsten", "Brunnberg", "tosse@gmail.com", 19720921, "Örlogsgatan 11", 0706593821, 29000, "Janitor",1),
    (DEFAULT, "Maja", "Majsson", "maja@gmail.com", 20160616, "Trasstvägen 8b", 0705436789, 46000, "Manager",1),
	(DEFAULT, "Kalle", "Kållered", "kalle@gmail.com", 19760925, "Snöregatan 7", 0706948372, 32000, "Librarian",2),
    (DEFAULT, "Julia", "Åkesson", "jullan@gmail.com", 20090909, "kaptensvägen 1", 0706948372, 29000, "Janitor",2),
    (DEFAULT, "Kristina", "Suresson", "krissan@gmail.com", 20010101, "Kuddvägen 9b", 0705999331, 46000, "Manager",2);




CREATE TABLE IF NOT EXISTS product_order_link
(
	order_id INT  DEFAULT 0,
    product_id INT ,
    
    PRIMARY KEY (order_id, product_id) ,
    
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    
    FOREIGN KEY (product_id)
    REFERENCES product(product_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
    
    
);

INSERT INTO product_order_link (product_id, order_id) VALUES
	(1,1),
	(2,2),
	(3,3);




CREATE TABLE IF NOT EXISTS costumer_library_link
	(	
    costumer_id INT,
    library_id INT,
    
    PRIMARY KEY (costumer_id, library_id),
    
    FOREIGN KEY (costumer_id)
    REFERENCES costumer(costumer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    
    FOREIGN KEY (library_id)
    REFERENCES library(library_id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
	);
    
    INSERT INTO costumer_library_link (costumer_id, library_id) VALUES
		(1,1),
        (2,1),
        (3,1),
        (4,1),
        (5,2),
        (6,2),
        (7,2),
        (8,2);

  
 -- Change the order status--------------------------------------------------------------------------------------------------------------
 
UPDATE orders
SET order_status = "Package missing in trasport!"
WHERE order_id = 2;
 
 
-- Insert a new order to orders----------------------------------------------------------------------------------------------------------

INSERT INTO orders VALUES
	(DEFAULT, 1, "2023-09-27", "Order recived", 4);
INSERT INTO product_order_link VALUES
(4,4);


-- Delete a order_id from orders----------------------------------------------------------------------------------------------------------

DELETE FROM orders
WHERE order_id = 3;


-- Change column order_status max char to 50-----------------------------------------------------------------------------------------------

ALTER TABLE orders
MODIFY order_status VARCHAR (50);


