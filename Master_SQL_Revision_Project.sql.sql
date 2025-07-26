CREATE DATABASE revision;
USE revision;
SHOW TABLES;

CREATE Table student(stu_id INTEGER (255) AUTO_INCREMENT PRIMARY KEY,
stu_name VARCHAR (255) NOT NULL ,
stu_email VARCHAR (255) NOT NULL UNIQUE,
stu_add VARCHAR (255) NOT NULL);

INSERT INTO student VALUES (null,'ghanshyam','ghanshyamshekhawat0509@gmail.com','Nagda'),(null,'anand','anand@gmail.com','UP');

SELECT * FROM student WHERE stu_add='UP';

DELETE FROM student WHERE stu_name='anand';
SELECT * FROM student;

UPDATE student SET stu_add='INDORE' WHERE stu_add='Nagda';
SELECT * FROM student;

ALTER TABLE student ADD COLUMN stu_age INTEGER (255) ;
SELECT * FROM student;

ALTER TABLE student ADD CONSTRAINT stu_age CHECK(stu_age>=18);

INSERT INTO student VALUES (NULL,'Raj','raj@gmail.com','Bhopal',20);
SELECT * FROM student;

CREATE TABLE books(book_id INTEGER (255) PRIMARY KEY AUTO_INCREMENT ,
book_title VARCHAR (255) NOT NULL,
author VARCHAR (255) NOT NULL,
price DECIMAL(6,2) NOT NULL);

INSERT INTO books VALUES (NULL,'Sql Fundamentals','John Doe',399.99),(NULL,'Mastering Database','Jane Smith',499.99);
SELECT * FROM books;

UPDATE books SET price=599.99 WHERE book_title='Mastering Database';
DELETE FROM books WHERE book_title='Sql Fundamentals';
SELECT * FROM books;

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category VARCHAR(50) NOT NULL
);

INSERT INTO orders (product_name, price, category) VALUES
('iPhone 15', 75000.00, 'Electronics'),
('Laptop', 55000.00, 'Electronics'),
('Shirt', 1500.00, 'Clothing'),
('Shoes', 2500.00, 'Clothing'),
('Headphones', 3000.00, 'Electronics'),
('Novel', 500.00, 'Books'),
('Notebook Set', 300.00, 'Books'),
('Smartwatch', 10000.00, 'Electronics');

SELECT category,SUM(price) AS 'Total amount' FROM orders GROUP BY category; 
SELECT product_name,price,CASE
WHEN price>30000 THEN 'Higher price'
WHEN price BETWEEN 5000 and 30000 THEN 'Mid-price'
WHEN price<5000 THEN 'Low price' END AS price_category 
FROM orders;

CREATE TABLE orderss(order_id INTEGER (255) PRIMARY KEY AUTO_INCREMENT,
order_name VARCHAR (255) NOT NULL ,
order_brand VARCHAR (255) NOT NULL);

CREATE TABLE customers(CID INTEGER (255) PRIMARY KEY AUTO_INCREMENT,
c_name VARCHAR (255) NOT NULL,
order_id INTEGER (255) NOT NULL,
CONSTRAINT orderss_fk FOREIGN KEY(order_id) REFERENCES orderss(order_id));

ALTER TABLE customers ADD COLUMN c_city VARCHAR (255) AFTER c_name;
ALTER TABLE customers MODIFY c_name VARCHAR (255) NOT NULL;
ALTER TABLE customers DROP COLUMN c_city; 
SELECT * FROM customers;

CREATE TABLE employees (emp_id INTEGER (255) AUTO_INCREMENT PRIMARY KEY,
emp_name VARCHAR (255) NOT NULL UNIQUE,
salary DECIMAL(6,2) CHECK(salary>0),
department VARCHAR (255),
emp_status VARCHAR (255)  DEFAULT 'active');
SELECT * FROM employees;

INSERT INTO employees VALUES (NULL,'jayesh',25000,'sales',DEFAULT),(NULL,'Ghanshyam','30000','Analytics',DEFAULT);
INSERT INTO employees VALUES (NULL,'Anand',-12000,'HR',DEFAULT),(NULL,'Prashant',0,'IT',DEFAULT);

ALTER TABLE employees ADD CONSTRAINT emp_emp_name CHECK(CHAR_LENGTH(emp_name) >=3);
INSERT INTO employees VALUES (NULL, 'Al', 25000, 'Testing', DEFAULT);    -- failed

SELECT * FROM employees;
INSERT INTO employees VALUES (NULL, 'Amit', 27000, 'Testing', DEFAULT);
SELECT * FROM employees;

ALTER TABLE employees DROP CONSTRAINT emp_emp_name;
INSERT INTO employees VALUES(NULL,'AI',24000,'Analyst',DEFAULT);
SELECT * FROM employees;

SELECT CONSTRAINT_NAME 
FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 'employees';

SELECT * FROM employees;
ALTER TABLE employees ADD CONSTRAINT UNIQUE (department);

-- Should succeed
INSERT INTO employees VALUES (NULL, 'Rohit', 30000, 'Finance', DEFAULT);

-- Should fail (duplicate department 'Finance')
INSERT INTO employees VALUES (NULL, 'Virat', 40000, 'Finance', DEFAULT);

SELECT * FROM employees;
ALTER TABLE employees Alter column department SET DEFAULT 'general';

INSERT INTO employees (emp_name, salary, emp_status)
VALUES ('Kunal', 27000, DEFAULT);
SELECT * FROM employees;

ALTER TABLE employees ADD COLUMN emp_joining_date DATE AFTER emp_status ;
SELECT * FROM employees;
ALTER TABLE employees MODIFY emp_joining_date DATETIME;
SELECT * FROM employees;

ALTER TABLE employees DROP COLUMN emp_joining_date;
SELECT * FROM employees;

ALTER TABLE employees ADD CONSTRAINT salary CHECK(salary <1000000);
INSERT INTO employees VALUES(NULL,'Amit',1100000,DEFAULT);

ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'Developer';
SELECT * FROM employees;
INSERT INTO employees (emp_name, salary, emp_status)
VALUES ('Sitaram', 100000, DEFAULT);
SELECT * FROM employees;

-- mini test
-- 1
CREATE TABLE studentss(id INTEGER (255) AUTO_INCREMENT PRIMARY KEY,
s_name VARCHAR (255) NOT NULL UNIQUE,
email VARCHAR (255)  UNIQUE,
age INTEGER (255) CHECK  (age >18));

-- 2
INSERT INTO studentss VALUES (NULL,'Ghanshyam','ghanshyamshekhawat0509@gmail.com',21);
INSERT INTO studentss VALUES (NULL,'Anand','anand@gmail.com',17);

-- 3
UPDATE studentss SET s_name='G. Shekhawat' WHERE s_name='Ghanshyam';
SELECT * FROM studentss;

-- 4
DELETE FROM studentss WHERE s_name='Anand';
SELECT * FROM studentss;

-- 5
CREATE TABLE departments(dept_id INTEGER (255) PRIMARY KEY AUTO_INCREMENT,
dept_name VARCHAR (255) NOT NULL);

CREATE TABLE employee (emp_id INTEGER (255) PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR (255) NOT NULL,
dept_id INTEGER (255) NOT NULL,
CONSTRAINT department_fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id));

-- 6
ALTER TABLE studentss ADD COLUMN city VARCHAR (255) AFTER email;
ALTER TABLE studentss ADD CONSTRAINT CHK_s_name CHECK (CHAR_LENGTH(s_name)<=150);
ALTER TABLE studentss DROP COLUMN city;
SELECT * FROM studentss;

-- 7
ALTER TABLE studentss ADD CONSTRAINT chk_s_name_s_name CHECK (CHAR_LENGTH(s_name)>=3);

-- test completed 
-- next 
RENAME TABLE employee TO staff_members;
SELECT * FROM staff_members;

ALTER TABLE staff_members CHANGE COLUMN emp_name full_name VARCHAR (255);
SELECT * FROM staff_members;

DESCRIBE staff_members;

DELETE FROM staff_members;
SELECT * FROM staff_members;
DROP TABLE staff_members;
SELECT * FROM staff_members;

CREATE TABLE employees_indexed (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_name VARCHAR(100),
  salary DECIMAL(10,2),
  department VARCHAR(50)
);

CREATE INDEX idx_emp_name ON employees_indexed (emp_name);
SELECT * FROM employees_indexed;
DROP INDEX idx_emp_name ON employees_indexed;

CREATE INDEX idx_dept ON employees_indexed (department);

INSERT INTO employees_indexed (emp_name, salary, department) VALUES
('Ghanshyam', 50000, 'Analytics'),
('Jayesh', 60000, 'HR'),
('Anand', 40000, 'Analytics'),
('Amit', 55000, 'Finance');

SELECT * FROM employees_indexed WHERE department = 'Analytics';

explain SELECT * FROM employees_indexed WHERE department = 'Analytics';

-- SELECT STARTED 
SELECT * FROM sm;
SELECT brand_name,model,price,battery_capacity FROM sm;
SELECT * FROM sm WHERE price>30000;
SELECT * FROM sm ORDER BY price DESC;
SELECT * FROM sm ORDER BY price DESC LIMIT 5;

SELECT brand_name,model,price,ram_capacity FROM sm WHERE ram_capacity>=8 AND battery_capacity>=4500 ORDER BY price DESC LIMIT  10;

SELECT * FROM sm WHERE brand_name='oneplus' OR brand_name='apple';

SELECT brand_name,model,price FROM sm WHERE price BETWEEN 30000 AND 60000;

SELECT * FROM sm WHERE brand_name IN ('samsung','motorola','realme');

SELECT * FROM sm WHERE model LIKE '%Pro%';

SELECT brand_name,model,price,ROUND(price-price*(10/100),2) as 'discounted_price' FROM sm;

SELECT brand_name,model,price FROM sm WHERE ram_capacity>=6 AND battery_capacity>=4000 AND has_5g='Yes' ORDER BY price DESC LIMIT 5;

SELECT brand_name AS 'Brand' ,price AS 'MRP',battery_capacity AS 'Battery (mah)' FROM sm ORDER BY MRP DESC;

SELECT brand_name,count(model) AS 'Total_model' FROM sm GROUP BY brand_name;

SELECT brand_name,ROUND(AVG(price),2) AS 'Average_price' FROM sm GROUP BY brand_name;

SELECT ram_capacity,count(*) AS 'Total_phones' FROM sm GROUP BY ram_capacity ORDER BY ram_capacity ;

SELECT brand_name,model,price,CASE 
WHEN price <15000 THEN 'Budget'
WHEN price BETWEEN 15000 AND 30000 THEN 'MID-Range'
WHEN price >30000 THEN 'Premium' END AS price_segment 
FROM sm;

SELECT brand_name,count(model) AS 'Total_models' FROM sm GROUP BY brand_name HAVING COUNT(model)>5;

SELECT brand_name,model,max(price) AS 'Highest_Price' FROM sm GROUP BY brand_name HAVING MAX(price);
SELECT sm.brand_name, sm.model, sm.price
FROM sm
JOIN (
    SELECT brand_name, MAX(price) AS max_price
    FROM sm
    GROUP BY brand_name
) AS top_price
ON sm.brand_name = top_price.brand_name AND sm.price = top_price.max_price;

SELECT brand_name,model,price FROM(SELECT *,
rank() OVER(PARTITION BY brand_name ORDER BY price DESC)  AS 'Highest_price'
FROM sm )  AS rnk WHERE Highest_price=1;

SELECT model FROM sm WHERE model LIKE '%0' OR model LIKE '%1' OR model LIKE '%2' OR model LIKE '%3' OR model LIKE '%4'
OR model LIKE '%5' OR model LIKE '%6' OR model LIKE '%7' OR model LIKE '%8' OR model LIKE '%9';

SELECT brand_name,model,price,CASE
WHEN model REGEXP '[0-9]$' THEN 'Numbered'
WHEN model REGEXP '[A-Za-z]$' THEN 'Named' END AS model_type 
FROM sm;

SELECT brand_name,model,ram_capacity,price FROM (SELECT *,
RANK() OVER(PARTITION BY ram_capacity ORDER BY price DESC) AS 'Highest_Price'
FROM sm ) as rnk WHERE Highest_Price=1;

SELECT * FROM sm;

SELECT CASE
WHEN price<15000 THEN 'Low-End'
WHEN price BETWEEN 15000 AND 30000 THEN 'Mid-Range'
WHEN price >30000 THEN 'High-End' END AS price_segment , 
COUNT(*) AS 'Total Phones',AVG(price) as 'Average price',MAX(battery_capacity) as 'Maximum battery'
FROM sm GROUP BY price_segment;

CREATE TABLE sales_data (
    model VARCHAR(255),
    region VARCHAR(100),
    units_sold INT
);

INSERT INTO sales_data (model, region, units_sold) VALUES
('Galaxy S23', 'India', 5000),
('Galaxy S23', 'US', 3000),
('Nord 3', 'India', 2000),
('Nord 3', 'UK', 1500),
('iPhone 14', 'US', 4000),
('iPhone 14', 'India', 2500),
('Edge 30', 'India', 1800),
('Edge 30', 'US', 900),
('iPhone 14', 'UK', 3000),
('Note 12', 'India', 3500),
('Note 12', 'UK', 1200),
('Galaxy M13', 'India', 2700),
('Galaxy M13', 'US', 1000),
('Galaxy M13', 'UK', 800),
('Nord CE 3', 'India', 2200);

SELECT count(DISTINCT(s.model)),sd.region,SUM(sd.units_sold),AVG(s.price) FROM sm s join sales_data sd ON s.model=sd.model GROUP BY sd.region;

SELECT brand_name,model,battery_capacity FROM (SELECT *,
RANK() OVER(PARTITION BY brand_name ORDER BY battery_capacity DESC) AS 'Maximum_Battery'
FROM sm) AS rnk WHERE Maximum_Battery=1;

SELECT ram_capacity,COUNT(*) AS 'Total_no_of_mobiles',AVG(price),MAX(battery_capacity) FROM sm GROUP BY ram_capacity;
SELECT * FROM sm;

SELECT CASE 
WHEN price < 15000 THEN 'Low'
WHEN price BETWEEN 15000 AND 30000 THEN 'MID'
WHEN price > 30000 THEN 'High'
END AS price_segment,Count(*) AS 'Total_5g_mobiles' FROM sm WHERE has_5g='TRUE' GROUP BY price_segment;

-- imdb 
-- 1Top 5 highest-grossing movies per genre
SELECT * FROM imdb;
SELECT Genre,Series_Title,Gross FROM(
SELECT *,
RANK() OVER(PARTITION BY Genre ORDER BY Gross DESC) AS 'Highest_movies'
FROM imdb) AS RNK WHERE Highest_movies<=5;

-- 2 Get the top-rated movie(s) per genre using IMDB_Rating.
SELECT Genre,Series_Title,IMDB_Rating FROM (
SELECT *,
RANK() OVER (PARTITION BY Genre ORDER BY IMDB_Rating DESC) AS 'Top_rated_movie'
FROM imdb) AS RNK WHERE Top_rated_movie=1;

-- 3 Get the most voted movie (highest No_of_Votes) per genre.
SELECT * FROM imdb;
SELECT Series_Title,Genre,No_of_Votes FROM(
SELECT *,
RANK() OVER (PARTITION BY Genre ORDER BY No_of_Votes DESC) AS 'Most_voted_movies'
FROM imdb) AS RNK WHERE Most_voted_movies=1;

-- 4 Get the top 3 IMDB-rated movies (overall, not genre-wise).
SELECT Series_Title,IMDB_Rating FROM imdb ORDER BY IMDB_Rating DESC LIMIT 3;

-- 5 Average IMDB rating and total votes per genre, order by avg rating desc.
SELECT * FROM imdb;
SELECT Genre,AVG(IMDB_Rating) AS 'Average_rating',SUM(No_of_Votes) AS 'Total_votes' FROM imdb GROUP BY Genre ORDER BY Average_rating DESC;

-- 6 Find the movie(s) with the highest gross (worldwide) in the entire dataset.
SELECT Series_Title,Gross FROM(
SELECT *,
RANK() OVER(ORDER BY Gross DESC) AS 'Highest_movie_by_gross'
FROM imdb) AS rnk WHERE Highest_movie_by_gross=1;

-- 7 Find the lowest-rated movie(s) per genre based on IMDB_Rating
SELECT Genre,Series_Title,IMDB_Rating FROM (
SELECT *,
RANK() OVER(PARTITION BY Genre ORDER BY IMDB_Rating ASC) AS 'Lowest_rated_movie'
FROM imdb) AS rnk WHERE Lowest_rated_movie=1;

-- 8 Find the movie(s) with the longest runtime in the entire IMDb dataset.
SELECT * FROM imdb;
SELECT Series_Title,Runtime FROM (
SELECT *,
RANK() OVER(ORDER BY Runtime DESC ) AS 'Longest_runtime' 
FROM imdb) AS rnk WHERE Longest_runtime=1;

-- 9. Top 3 movies per genre based on IMDb rating (include ties).
SELECT Genre,IMDB_Rating FROM(
SELECT *,
RANK() OVER(PARTITION BY Genre ORDER BY IMDB_Rating DESC) AS 'Top_Three_movie'
FROM imdb) AS RNK WHERE Top_Three_movie<=3;

--  10. List all genres where the average IMDb rating is less than 7.
SELECT Genre, AVG(IMDB_Rating) AS avg_rating
FROM imdb
GROUP BY Genre
HAVING AVG(IMDB_Rating) < 7;

-- 11. Find 5 movies with the largest absolute difference between IMDb rating and Metascore.
SELECT Series_Title,ABS(IMDB_Rating - Metascore) AS 'Absolute_difference' FROM imdb ORDER BY Absolute_difference DESC LIMIT 5;

-- 12. Count number of movies released in each decade (e.g., 1990s, 2000s).
SELECT * FROM imdb;
SELECT CONCAT(ROUND((Released_Year/10)*10),'s') AS 'Decade',COUNT(Series_Title) AS 'Total_movies' FROM imdb GROUP BY Decade ORDER BY Total_movies DESC;

-- 13. Find the top-rated movie (IMDB rating) by each director.
SELECT Director,Series_Title,IMDB_Rating FROM(
SELECT *,
RANK() OVER(PARTITION BY Director ORDER BY IMDB_Rating DESC) AS 'Top_rated_movie'
FROM imdb) AS RNK WHERE Top_rated_movie=1;

-- 14. Find the director with the most movies in the dataset.
SELECT Director,COUNT(Series_Title) AS 'No_of_movies' FROM imdb GROUP BY Director ORDER BY No_of_movies DESC limit 1;

-- 15. Find movies that are in the top 10 by votes but have IMDb rating less than 7.
SELECT * FROM imdb;
SELECT Series_Title,No_of_Votes,IMDB_Rating FROM (
SELECT *,
RANK() OVER(ORDER BY No_of_Votes DESC) AS 'top_ten_by_votes'
FROM imdb) AS RNK WHERE top_ten_by_votes<=10 AND IMDB_Rating<7; 

-- 16. List all genres where the total number of movies is more than 10 and the average gross is more than 100 million.
SELECT * FROM imdb;
SELECT Genre,COUNT(Series_Title) AS 'Total_movies',AVG(Gross) AS 'Average_Gross' FROM imdb 
 GROUP BY Genre HAVING COUNT(Series_Title)>10 AND AVG(Gross)>100000000;
 
-- 17. Which actor appears in the most movies in the dataset? (Consider all 3 actor columns.)
SELECT * FROM imdb;
DESCRIBE imdb;
SELECT Star1,COUNT(Series_Title) AS 'Total_movies' FROM imdb GROUP BY Star1 ORDER BY Total_movies DESC LIMIT 1; 

-- 18. Find all movies where the title contains a number (e.g., “Se7en”, “Ocean’s 11”).
SELECT Series_Title FROM imdb WHERE Series_Title REGEXP  '[0-9]' ;

-- 19. For each genre, find the percentage of movies with IMDb rating above 8.
SELECT Genre,CONCAT(ROUND(SUM(CASE WHEN IMDB_Rating>8 THEN 1 ELSE 0 END)*100/COUNT(*),2),'%') AS 
'Percentage_of_movies' FROM imdb GROUP BY Genre;

-- 20. Which year had the highest average IMDb rating across all movies?
SELECT Released_Year,AVG(IMDB_Rating) AS 'Average_IMDB_Rating' FROM imdb GROUP BY Released_Year ORDER BY Average_IMDB_Rating DESC LIMIT 1;

-- 21. Find the top 3 actors (across all Star columns) who have appeared in the most high-rated movies (IMDb rating > 8).
WITH HighRated AS (
    SELECT Star1
    FROM imdb
    WHERE IMDB_Rating > 8
),
ActorCounts AS (
    SELECT Star1, COUNT(*) AS High_rated_movie
    FROM HighRated
    GROUP BY Star1
),
RankedActors AS (
    SELECT *, RANK() OVER (ORDER BY High_rated_movie DESC) AS RNK
    FROM ActorCounts
)
SELECT Star1, High_rated_movie
FROM RankedActors
WHERE RNK <= 3;

-- 22. For each director, calculate the average gross and only include those who have directed at least 3 movies.
SELECT Director,AVG(Gross) AS 'Average_Gross',COUNT(*) AS 'Total_movies' FROM imdb GROUP BY Director HAVING COUNT(*)>=3;

--  23. Create a new column: Movie_Category based on IMDb rating:

-- "Excellent" if rating >= 8.5

-- "Good" if between 7 and 8.5

-- "Average" if < 7

SELECT Series_Title,IMDB_Rating, CASE
WHEN IMDB_Rating>=8.5 THEN 'Excellent'
WHEN IMDB_Rating BETWEEN 7 AND 8.5 THEN 'Good'
WHEN IMDB_Rating <=7 THEN 'Average' END AS Movie_category
FROM imdb;

-- 24. Identify movies where the gross is NULL, but the IMDb rating is among the top 10% — do any high-rated movies lack gross data?

-- “I analyzed movies in the top 20% by IMDb rating using PERCENT_RANK(). Initially, I checked if any of these high-rated movies had missing gross data. However, no such records existed. So, I adapted the analysis to explore all high-rated movies and their revenue performance — revealing which acclaimed films underperformed or lacked data.”
 
SELECT Series_Title,IMDB_Rating,Gross,Top_ten_percent FROM (
SELECT *,
PERCENT_RANK() OVER(ORDER BY IMDB_Rating DESC) AS per_rank,
CONCAT(ROUND(PERCENT_RANK() OVER(ORDER BY IMDB_Rating DESC) *100,2),'%') AS 'Top_ten_percent'
FROM imdb) AS RNK WHERE per_rank>=0.8;

-- 25. Using CTEs, find directors whose lowest-rated movie is still above 8.
WITH Director_Movies AS (
    SELECT Director, Series_Title, IMDB_Rating,
           RANK() OVER (PARTITION BY Director ORDER BY IMDB_Rating ASC) AS rating_rank
    FROM imdb
),
Lowest_Rated_Per_Director AS (
    SELECT Director, Series_Title, IMDB_Rating AS Lowest_Rating
    FROM Director_Movies
    WHERE rating_rank = 1
)
SELECT Director, Series_Title AS Movie_With_Lowest_Rating, Lowest_Rating
FROM Lowest_Rated_Per_Director
WHERE Lowest_Rating > 8;

-- 26. List all movies where the difference between year of release and year in the title is more than
-- 5 years (e.g., “1917” released in 2020).
SELECT * FROM imdb;
SELECT
  Series_Title,
  Released_Year,
  Title_Year,
  ABS(Released_Year - Title_Year) AS Year_Diff
FROM (
  SELECT
    Series_Title,
    Released_Year,
    CASE
      WHEN LOCATE('19', Series_Title) BETWEEN 1 AND LENGTH(Series_Title)-3 THEN CAST(SUBSTR(Series_Title, LOCATE('19', Series_Title), 4) AS SIGNED)
      WHEN LOCATE('20', Series_Title) BETWEEN 1 AND LENGTH(Series_Title)-3 THEN CAST(SUBSTR(Series_Title, LOCATE('20', Series_Title), 4) AS SIGNED)
      ELSE NULL
    END AS Title_Year
  FROM imdb
) AS sub
WHERE
  Title_Year IS NOT NULL
  AND Released_Year IS NOT NULL
  AND ABS(Released_Year - Title_Year) > 5;


SELECT 
  Series_Title,
  Released_Year,
  CAST(REGEXP_SUBSTR(Series_Title, '[1-2][0-9]{3}') AS SIGNED) AS Title_Year,
  ABS(Released_Year - CAST(REGEXP_SUBSTR(Series_Title, '[1-2][0-9]{3}') AS SIGNED)) AS Year_Diff
FROM imdb
WHERE 
  Series_Title REGEXP '[1-2][0-9]{3}'
  AND Released_Year IS NOT NULL
  AND ABS(Released_Year - CAST(REGEXP_SUBSTR(Series_Title, '[1-2][0-9]{3}') AS SIGNED)) > 5;
  
-- 27 Find all movies where the gross revenue is below average, 
-- but they still received a rating higher than 8. Sort them by rating descending.
SELECT * FROM imdb;
SELECT Series_Title,Gross,IMDB_Rating,(SELECT AVG(Gross) FROM imdb) AS 'Average_Grosee' FROM imdb WHERE Gross<(SELECT AVG(Gross) FROM imdb) AND IMDB_Rating>8;

-- 28 Find the top 5 genres (based on number of movies). For each genre, show:

-- Genre name (use only the first genre if it’s a comma-separated list like 'Action,Drama')

-- Total number of movies in that genre

-- Average IMDB rating

-- Most recent year (MAX(Year))
SELECT * FROM imdb;
SELECT Genre,COUNT(*) AS 'Total_movie',AVG(IMDB_Rating),MAX(Released_Year) AS 'Most_recent_Year' FROM imdb
GROUP BY Genre ORDER BY Total_movie DESC LIMIT 5; 

-- Q29 – First and Last Movie per Genre 
SELECT Genre, Series_Title, Released_Year,First_movie,Last_movie FROM (
SELECT *,
FIRST_VALUE(Series_Title) OVER (PARTITION BY Genre ORDER BY Released_Year ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'First_movie',
LAST_VALUE(Series_Title) OVER(PARTITION BY Genre ORDER BY Released_Year ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Last_movie'
FROM imdb) AS RNk WHERE Series_Title = First_movie
   OR Series_Title = Last_movie;
   
-- 30 For each genre, compare every movie’s IMDB rating with the previous movie (based on release year).
-- Show the movies where the IMDB rating dropped compared to the previous one in the same genre.
-- Show these columns:
-- Genre
-- Series_Title
-- Released_Year
-- IMDB_Rating
-- Previous_Rating
-- Difference (Previous - Current)
SELECT Genre,Series_Title,Released_Year,IMDB_Rating,Previous_Rating,(Previous_Rating-IMDB_Rating) AS 'Difference' FROM(
SELECT *,
LAG(IMDB_Rating) OVER (PARTITION BY Genre ORDER BY Released_Year) AS 'Previous_Rating'
FROM imdb) AS RNK WHERE IMDB_Rating<Previous_Rating;

-- join+subquery+CTEs+window_function
-- 1. Create Table: customers
CREATE TABLE customer (
  cust_id INT PRIMARY KEY,
  cust_name VARCHAR(100),
  city VARCHAR(100)
);

-- 2. Create Table: orders
CREATE TABLE Orders1 (
  order_id INT PRIMARY KEY,
  cust_id INT,
  order_date DATE,
  FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

-- 3. Create Table: products
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  base_price DECIMAL(10,2)
);

-- 4. Create Table: order_items
CREATE TABLE order_items (
  order_id INT,
  product_id INT,
  quantity INT,
  item_price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders1(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Insert customers
INSERT INTO customer VALUES
(1, 'Ghanshyam', 'Indore'),
(2, 'Ramesh', 'Mumbai'),
(3, 'Sita', 'Delhi'),
(4, 'Aman', 'Bhopal');

-- Insert orders
INSERT INTO Orders1 VALUES
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 1, '2024-06-10'),
(104, 3, '2024-06-15');

-- Insert products
INSERT INTO products VALUES
(501, 'Mouse', 'Electronics', 500),
(502, 'Keyboard', 'Electronics', 700),
(503, 'Book', 'Stationery', 300),
(504, 'Pen Drive', 'Electronics', 450),
(505, 'Notebook', 'Stationery', 150);

-- Insert order_items
INSERT INTO order_items VALUES
(101, 501, 2, 500),
(101, 502, 1, 700),
(102, 503, 3, 300),
(103, 504, 1, 450),
(103, 503, 2, 300),
(104, 505, 4, 150);

INSERT INTO customer VALUES 
(5, 'Radha', 'Kolkata'),
(6, 'Dev', 'Jaipur'),
(7, 'Meera', 'Lucknow');

INSERT INTO orders1 VALUES
(105, 5, '2024-06-18'),   -- Radha's order (no items)
(106, 6, '2024-06-19'),   -- Dev's order (we’ll add item)
(107, 7, '2024-06-20');   -- Meera's order (no items)

INSERT INTO products VALUES 
(506, 'Headphones', 'Electronics', 1200),
(507, 'Calculator', 'Stationery', 600),
(508, 'Charger', 'Electronics', 550),
(509, 'Tablet', 'Electronics', 8000);

INSERT INTO order_items VALUES
(106, 506, 1, 1200),     -- Dev bought Headphones
(106, 507, 2, 600);      -- Dev also bought Calculator



-- 1 List each customer’s name, their city, and the total number of orders they have placed.
-- (Sorted by customer name)
SELECT C.cust_name,C.city,COUNT(O.order_id) AS 'Total_Number_of_order' FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id 
GROUP BY C.cust_name ORDER BY C.cust_name ;

-- 2 List each customer’s name and the total amount they have spent on all orders.;
SELECT C.cust_name,SUM(OI.item_price*OI.quantity) AS 'Total_amount' FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id JOIN order_items OI ON O.order_id=OI.order_id
JOIN products P ON OI.product_id=P.product_id GROUP BY C.cust_name ORDER BY Total_amount DESC;

-- 3 List each product’s name and the total quantity sold.
SELECT P.product_name,SUM(OI.quantity) AS 'Total_quantity_sold' FROM products P JOIN order_items OI ON P.product_id=OI.product_id GROUP BY P.product_name;

-- 4 List all customers who have purchased at least one product from the ‘Electronics’ category.
-- Show: cust_name, product_name, category
SELECT C.cust_name,P.product_name,P.category FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id JOIN order_items OI ON O.order_id=
OI.order_id JOIN products P ON OI.product_id=P.product_id WHERE P.category='Electronics' ;

-- 5 List all customers and the total number of orders they placed. Include those who haven’t placed any orders.
SELECT C.cust_name,COUNT(O.order_id) AS 'Total_no_of_orders' FROM customer C LEFT JOIN Orders1 O ON C.cust_id=O.cust_id GROUP BY C.cust_name ;

-- 6 List all products and the total quantity sold for each. Include products that were never sold.
SELECT P.product_name,SUM(OI.quantity) AS 'Total_qantity' FROM products P LEFT JOIN order_items OI ON P.product_id=OI.product_id 
GROUP BY P.product_name;

-- 7 List all customers who have never placed any order.
SELECT C.cust_name,O.order_id FROM customer C LEFT JOIN Orders1 O ON C.cust_id=O.cust_id WHERE O.order_id IS NULL;

-- 8 List all products that have never been sold (i.e., no entry in order_items).
SELECT P.product_name,OI.product_id FROM products P LEFT JOIN order_items OI ON P.product_id=OI.product_id 
WHERE OI.product_id IS NULL GROUP BY P.product_name ;

-- 9 List all orders that were placed but have no items in them.
SELECT O.order_id,OI.order_id FROM Orders1 O LEFT JOIN order_items OI ON O.order_id=OI.order_id WHERE OI.order_id IS NULL GROUP BY O.order_id;

-- 10 List all products along with their total quantity sold and total revenue (quantity × item_price).
-- Include products that were never sold.
SELECT P.product_name,SUM(OI.quantity) AS 'Total_quantity',SUM(OI.quantity*OI.item_price) AS 'Total_revenue' FROM
products P LEFT JOIN order_items OI ON P.product_id=OI.product_id  GROUP BY P.product_name;

-- 11 List each customer’s name, and for each order they placed, show:
-- Order ID
-- Number of distinct products in that order
-- Total quantity
-- Total bill (quantity × item_price)
-- Only include customers who have placed at least one order.
-- Sorted by customer name and order ID.

SELECT 
    COUNT(DISTINCT (P.product_id)) AS 'NO_OF_DISTINCT_PRODUCT',
    C.cust_name,
    O.order_id,
    SUM(OI.quantity) AS 'Total_quantity',
    SUM(OI.quantity * OI.item_price) AS 'Total_bill'
FROM
    customer C
        JOIN
    Orders1 O ON C.cust_id = O.cust_id
        JOIN
    order_items OI ON O.order_id = OI.order_id
        JOIN
    products P ON OI.product_id = P.product_id
GROUP BY C.cust_name , O.order_id
ORDER BY C.cust_name , O.order_id;

-- 12 Using a CTE, list all customers who have spent more than ₹1000 across all their orders.
-- Show: cust_name, total_spent
WITH Customer_money_spent AS (
							  SELECT C.cust_name,SUM(OI.quantity*OI.item_price) AS 'Total_Spent'
                              FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id JOIN order_items OI ON O.order_id=OI.order_id
                              GROUP BY C.cust_name
                              )
SELECT cust_name,Total_Spent FROM Customer_money_spent WHERE Total_Spent>1000;

-- 13 Using a CTE, list product categories where the average quantity sold per order item is greater than 1.5
-- Show: category, avg_quantity
WITH Category_average AS (
						  SELECT P.category,AVG(OI.quantity) AS 'Average_of_quantity' FROM products P JOIN order_items OI ON 
                          P.product_id=OI.product_id GROUP BY P.category
                          )
	SELECT category,Average_of_quantity FROM Category_average WHERE Average_of_quantity>1.5;
    
-- 14 List customers who have placed more than one order and also show the total number of items they’ve purchased (across all orders).
-- Show: cust_name, no_of_orders, total_items
SELECT C.cust_name,Count(DISTINCT(O.order_id)) AS 'Total_no_of_orders',SUM(OI.quantity) AS 'Total_items'
 FROM customer C JOIN Orders1 O ON C.cust_id=O.Cust_id JOIN order_items OI ON O.order_id=OI.order_id GROUP BY C.cust_name;
 
-- 15 List all products that have been sold in more than one order.
SELECT P.product_name,COUNT(OI.order_id) FROM products P JOIN order_items OI ON P.product_id=OI.product_id GROUP BY P.product_name 
Having COUNT(OI.order_id)>1;

-- 16 List all customers along with the number of different product categories they’ve purchased from.
-- Show: cust_name, category_count
SELECT C.cust_name,COUNT(DISTINCT(P.category)) AS 'No_of_different_product_category' FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id
JOIN order_items OI ON O.order_id=OI.order_id JOIN products P ON OI.product_id=P.product_id GROUP BY C.cust_name;

-- 17 For each customer, list their most expensive product purchase (based on item price).
-- Show: cust_name, product_name, item_price
SELECT cust_name,product_name,item_price FROM (SELECT C.cust_name,P.product_name,OI.item_price,
RANK() OVER(PARTITION BY C.cust_name ORDER BY OI.item_price DESC) AS 'Most_expensive_product'
 FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id
JOIN order_items OI ON O.order_id=OI.order_id JOIN products P ON OI.product_id=P.product_id GROUP BY C.cust_name)
AS RRRNK WHERE Most_expensive_product=1;

-- 18 List all customers who have only ordered products from a single category.
-- Show: cust_name, category
SELECT C.cust_name,P.category FROM customer C JOIN Orders1 O ON C.cust_id=O.cust_id
JOIN order_items OI ON O.order_id=OI.order_id JOIN products P ON OI.product_id=P.product_id GROUP BY C.cust_name HAVING
COUNT(DISTINCT(P.category)) <2;

-- 19 List the top 2 most selling products (by total quantity) per category.
-- Show: category, product_name, total_quantity
WITH product_sales AS (
  SELECT 
    P.category,
    P.product_name,
    SUM(OI.quantity) AS total_quantity
  FROM products P
  JOIN order_items OI ON P.product_id = OI.product_id
  GROUP BY P.category, P.product_name
),
ranked_products AS (
  SELECT *,
         RANK() OVER (PARTITION BY category ORDER BY total_quantity DESC) AS rank_in_category
  FROM product_sales
)
SELECT category, product_name, total_quantity
FROM ranked_products
WHERE rank_in_category <= 2;

-- 20 List each product and the number of customers who have purchased it.
-- Show: product_name, customer_count
SELECT P.product_name,COUNT(DISTINCT(C.cust_id)) AS 'Customer_count' FROM customer C JOIN Orders1 O  ON C.cust_id=O.cust_id
JOIN order_items OI ON O.order_id=OI.order_id JOIN products P ON OI.product_id=P.product_id GROUP BY P.product_name;

-- mock
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE productss (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO employees VALUES (1, 'John', 'Doe', 60000, 10);
INSERT INTO employees VALUES (2, 'Jane', 'Smith', 45000, 20);
INSERT INTO employees VALUES (3, 'Mike', 'Brown', 70000, 10);
INSERT INTO employees VALUES (4, 'Sara', 'White', 40000, 30);
INSERT INTO employees VALUES (5, 'Raj', 'Patel', 52000, 10);
INSERT INTO employees VALUES (6, 'Simran', 'Kaur', 50000, 20);
INSERT INTO employees VALUES (7, 'Ali', 'Khan', 55000, 30);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'HR');
INSERT INTO departments VALUES (30, 'Marketing');

INSERT INTO customers VALUES (1, 'Amit Kumar', 'Delhi');
INSERT INTO customers VALUES (2, 'Ravi Verma', 'Mumbai');
INSERT INTO customers VALUES (3, 'Sneha Singh', 'Bangalore');

INSERT INTO orders VALUES (101, 1, '2024-01-10', 1000);
INSERT INTO orders VALUES (102, 2, '2024-02-15', 1500);
INSERT INTO orders VALUES (103, 3, '2024-02-20', 2000);
INSERT INTO orders VALUES (104, 1, '2024-03-05', 2500);

INSERT INTO productss VALUES (201, 'Laptop', 'Electronics', 50000);
INSERT INTO productss VALUES (202, 'Phone', 'Electronics', 20000);
INSERT INTO productss VALUES (203, 'Desk', 'Furniture', 10000);
INSERT INTO productss VALUES (204, 'Chair', 'Furniture', 5000);


-- Q1:
-- Fetch the first_name, last_name, and salary of employees who earn more than 50000 and belong to department_id = 10.
-- Sort the result by salary in descending order.
Select * FROM employees;
SELECT first_name,last_name,salary FROM employees WHERE salary>50000 AND department_id=10 ORDER BY salary DESC;

-- Q2 find the department_id-wise average salary.
-- Show only those departments where the average salary is greater than 50000.
-- Output columns: department_id, avg_salary
SELECT department_id,AVG(salary) AS 'Average_salary' FROM employees GROUP BY department_id HAVING AVG(salary) >50000;

-- Q3:
-- Get the first_name, department_name, and salary of all employees who work in the 'Finance' department.
-- Tables: employees, departments
SELECT * FROM employees;
SELECT * FROM departments;
SELECT E.first_name,D.department_name,E.salary FROM employees E JOIN departments D ON E.department_id=D.department_id WHERE D.department_name=
'Finance';

-- Q4:
-- Show the customer_name, order_date, and total_amount for all orders placed by customers from Delhi.
-- Tables: customers, orders
SELECT * FROM customers;
SELECT * FROM orders;
SELECT C.customer_name,O.order_date,O.total_amount FROM customers C JOIN orders O ON C.customer_id=O.customer_id 
WHERE C.city='Delhi' ;

-- Q5 Get the product name and price of all products in the 'Furniture' category.
-- Table: productss
SELECT * FROM productss;
SELECT product_name,price FROM productss WHERE category ='Furniture';

-- Q6 Show the first_name, salary, and a new column called Status that displays:

-- 'High Earner' if salary > 60000

-- 'Mid Earner' if salary between 50000 and 60000

-- 'Low Earner' if salary < 50000

SELECT * FROM employees;
SELECT first_name,salary,CASE
WHEN salary>60000 THEN 'High Earner'
WHEN salary BETWEEN 50000 AND 60000 THEN 'Mid Earner'
WHEN salary < 50000 THEN 'Low Earner'
END AS Status FROM employees;

-- Q7 Display the department_name and the number of employees in each department.
-- Also show departments even if they have no employees.
SELECT D.department_name,Count(E.emp_id) AS 'Total_employees' FROM employees E RIGHT JOIN departments D ON 
E.department_id=D.department_id GROUP BY D.department_name;

-- Q8 Show the names of customers who have never placed any orders.
SELECT * FROM customers;
SELECT * FROM orders;
SELECT C.customer_name FROM customers C LEFT JOIN orders O ON C.customer_id=O.customer_id WHERE order_id IS NULL;

-- Q9)Show the order_id, customer_name, and total_amount for orders where the total_amount is greater than
-- the average of all orders.
SELECT * FROM customers;
SELECT * FROM orders;
SELECT O.order_id,C.customer_name,O.total_amount FROM customers C JOIN orders O ON C.customer_id=O.customer_id  
WHERE O.total_amount>(SELECT Avg(O.total_amount) FROM orders);

-- Q10) For each employee, show their first_name, salary, and the average salary of their department.
-- Columns: first_name, salary, avg_dept_salary
SELECT * FROM employees;
SELECT * FROM departments;
SELECT first_name, salary,
  (SELECT AVG(salary)
   FROM employees E2
   WHERE E2.department_id = E1.department_id) AS avg_dept_salary FROM employees E1;
   
-- Q11) Show the month-wise total order amount.
-- Output columns: order_month, total_amount
-- Format the order_month as YYYY-MM.
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       SUM(total_amount) AS total_amount
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- Q12) Show the product(s) from the productss table that has the highest price.
-- Output: product_name, price
SELECT product_name,price FROM productss WHERE price=(SELECT MAX(price) FROM productss);

-- Q13) List the first_name, salary, and the rank of each employee based on salary (highest salary = Rank 1).
-- Table: employees
SELECT first_name,salary,
RANK() OVER(ORDER BY salary DESC) AS RNK
FROM employees;

-- Q14) Show the department-wise highest salary, along with the department_name and employee first_name.
-- Only show the top earner(s) per department.
SELECT  department_name,first_name FROM (SELECT D.department_name,E.first_name,
RANK() OVER(PARTITION BY D.department_name ORDER BY E.salary DESC ) AS 'Highest_salary'
FROM employees E JOIN departments D ON E.department_id=D.department_id) AS RNK WHERE Highest_salary=1;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Revision again:
-- Write the full SQL query to create student table.
CREATE DATABASE revision3;
USE revision3;
CREATE TABLE student(
stu_id INTEGER(255) AUTO_INCREMENT PRIMARY KEY,
stu_name VARCHAR(255) NOT NULL,
stu_email VARCHAR(255) NOT NULL UNIQUE,
stu_add VARCHAR(255) NOT NULL);
SELECT * FROM student;

-- You want to insert these 2 records into the student table:
INSERT INTO student VALUES (NULL,'Ghanshyam','ghanshyam0509@gmail.com','Nagda'),(NULL,'Anand','anand@gmail.com','UP');

--  Write the INSERT statements, then write a SELECT query to fetch only students from 'UP'.
SELECT * FROM student WHERE stu_add='UP';

-- Student named Anand wants to be removed from the system.
-- ✍️ Write a query to delete him, then verify the table contents.
DELETE FROM student WHERE stu_name='Anand';
SELECT * FROM student;

-- You now want to update all students whose address is 'Nagda' and change it to 'Indore'.
UPDATE  student SET stu_add='Indore' WHERE stu_add='Nagda';
SELECT * FROM student;

-- You now want to add a new column to the student table called stu_age, which stores student age as an integer.
ALTER TABLE student ADD COLUMN stu_age INTEGER(255) NOT NULL;
SELECT * FROM student;

--  Write an ALTER TABLE query to add a CHECK constraint on stu_age column that enforces stu_age >= 18.
SELECT * FROM student;
INSERT INTO student VALUES (NULL,'Amit','Amit@gmail.com','Dewas','20');
ALTER TABLE student ADD CONSTRAINT chkkk_stu_age CHECK(stu_age>=18);

-- You have to create a table called books with these columns:
-- Write a query to create this table

-- Then insert the following 2 records:

-- "SQL Fundamentals" by John Doe – ₹399.99

-- "Mastering Database" by Jane Smith – ₹499.99

-- Select all records from the books table

CREATE TABLE books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
book_title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
price DECIMAL(6,2) NOT NULL);

INSERT INTO books (book_title,author,price) VALUES ('"SQL Fundamentals"','John Doe',399.99),('"Mastering Database"','Jane Smith',499);
SELECT * FROM books;

-- 🧠 Question 9:
-- Update the price of "Mastering Database" to ₹599.99
-- Then delete the book "SQL Fundamentals" from the table
-- Show remaining records
UPDATE books SET price=599 WHERE book_title='"Mastering Database"';
DELETE FROM books WHERE book_title ='"SQL Fundamentals"';
SELECT * FROM books;

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category VARCHAR(50) NOT NULL
);

INSERT INTO orders (product_name, price, category) VALUES
('iPhone 15', 75000.00, 'Electronics'),
('Laptop', 55000.00, 'Electronics'),
('Shirt', 1500.00, 'Clothing'),
('Shoes', 2500.00, 'Clothing'),
('Headphones', 3000.00, 'Electronics'),
('Novel', 500.00, 'Books'),
('Notebook Set', 300.00, 'Books'),
('Smartwatch', 10000.00, 'Electronics');

--  Write a query to:
-- Show each category and the total amount spent in that category.
-- Use GROUP BY category
-- Alias the column as 'Total amount'
SELECT * FROM orders;
SELECT Category,SUM(price) AS 'Total amount' FROM orders GROUP BY category;

-- Write a query to display product_name, price, and a column price_category based on:
-- 'Higher price' → if price > 30000
-- 'Mid-price' → if price between 5000 and 30000
-- 'Low price' → if price < 5000
USE revision3;
SELECT * FROM orders;
SELECT 
    product_name,
    price,
    CASE
        WHEN price > 30000 THEN 'Higher price'
        WHEN price BETWEEN 5000 AND 30000 THEN 'Mid-price'
        WHEN price < 5000 THEN 'Low price'
    END AS price_category
FROM
    orders;
    
-- Question 12 (Already Given Earlier):
-- Display top 5 most expensive products
-- Only if category is 'Electronics' or 'Books' and price > 5000
-- Also show a price_tag: 'Expensive' if price > 20000, 'Affordable' otherwise
-- Columns to show:
-- product_name, price, category, price_tag

SELECT * FROM orders;
SELECT 
    product_name,
    price,
    category,
    CASE
        WHEN price > 20000 THEN 'Expensive'
        WHEN price <= 20000 THEN 'Affordable'
    END AS price_tag
FROM
    orders
WHERE
    (category = 'Electronics'
        OR category = 'Books')
        AND price > 5000
ORDER BY price DESC
LIMIT 5; 

-- Write a query to show the number of products in each category,
-- but only include categories that have more than 2 products.
-- Table: orders
-- Columns to display: category, Total_Products
SELECT * FROM orders;
SELECT category,COUNT(order_id) AS 'Total_Products' FROM orders GROUP BY category HAVING COUNT(order_id)>2;

-- Write a query to get the most expensive product from each category.
-- Table: orders
SELECT * FROM orders;
SELECT * FROM(
SELECT *,
RANK() OVER(PARTITION BY category ORDER BY price DESC ) AS rnk
FROM orders) AS RRNK WHERE rnk=1;

-- Write a query to fetch the product(s) with the highest price from the orders table.
-- Bhai teri baari.
SELECT * FROM orders WHERE price=(SELECT MAX(price) FROM orders);

-- Get the second most expensive product from the orders table.
SELECT * FROM orders;
SELECT * FROM orders ORDER BY price DESC LIMIT 1,1;

-- Get the names of all products that belong to categories having more than 2 products.
SELECT * FROM orders;
SELECT product_name FROM orders WHERE category IN (SELECT category FROM orders GROUP BY category HAVING COUNT(order_id)>2);

-- Get the name and price of each product along with its price rank (1 = most expensive).
SELECT * FROM orders;
SELECT product_name,price,RNK FROM (
SELECT * ,
RANK() OVER(ORDER BY price DESC) AS RNK
FROM orders) AS RRNK WHERE RNK=1;

-- Show the product(s) with the second highest price.
SELECT * FROM orders ORDER BY price DESC LIMIT 1,1;

-- Get all product(s) that are tied at second highest price.
SELECT * FROM (SELECT * ,
RANK() OVER(ORDER BY price DESC) AS RNK
FROM orders) AS RRNK WHERE RNK=2;

-- Show each category and the average price of products in it.
-- Only include categories where the average price is above ₹5000.
SELECT category,AVG(price) AS 'Average_price' FROM orders GROUP BY category HAVING AVG(price)>5000;

-- Show the category that has the highest total price across all its products.
-- Return both category name and total price.
SELECT category,SUM(price) AS 'Highest Total price' FROM orders GROUP BY category ORDER BY SUM(price) DESC LIMIT 1;

-- Get all products from the orders table that have a price greater than the average price of all products.
SELECT product_name,price FROM orders WHERE price>(SELECT AVG(price) FROM orders);

-- Get all products whose price is above the average price of their own category.
SELECT * FROM orders;
SELECT category,product_name,price,Average_price FROM (
SELECT *,
AVG(price) OVER(PARTITION BY category) 	AS 	Average_price 
FROM orders) AS RRNK WHERE price>Average_price;

-- Get the product(s) with the lowest price in each category.
SELECT category,product_name,price FROM (
SELECT *,
RANK() OVER(PARTITION BY category ORDER BY price ASC) AS RNK
FROM orders) AS RRNK WHERE RNK=1;

-- Display the total number of products and total price category-wise,
-- but only for those categories where total products are more than 2.
SELECT category,COUNT(order_id) AS 'Total Number of products',SUM(price) AS 'Total price' FROM orders GROUP BY category HAVING COUNT(order_id)>2;

-- Show the category-wise most expensive product's name and price.
-- ✅ Return all tied products if multiple exist at same top price
SELECT category,product_name,price FROM (SELECT *,
RANK() OVER(PARTITION BY category ORDER BY price DESC) AS RNK
FROM orders) AS RRNK WHERE RNK=1;

-- Show each category with the total price of its products and its percentage contribution to the grand total price.
WITH category_total AS (
  SELECT category, SUM(price) AS Categorical_total
  FROM orders
  GROUP BY category
),
Grand_total AS (
  SELECT SUM(price) AS Grand_total FROM orders
)

SELECT 
  C.category,
  C.Categorical_total,
  CONCAT(ROUND((C.Categorical_total / G.Grand_total) * 100, 2),'%') AS Percentage_Contribution
FROM category_total C, Grand_total G;

-- Show all products with the average price of their category, and
-- a column Above_Avg showing 'Yes' if price > avg of that category, else 'No'.
SELECT category,price,Average_price_category_wise,
CASE
WHEN price>Average_price_category_wise THEN 'Yes'
WHEN price<=Average_price_category_wise THEN 'No'
END AS Above_Avg
 FROM (SELECT *,
AVG(price) OVER(PARTITION BY category) AS Average_price_category_wise
FROM orders) AS RRNK;


-- Show the category, number of products in that category,
-- and a flag High_Density which shows 'Yes' if number of products > 3, else 'No';
SELECT category,COUNT(order_id) AS Total_no_of_product,
CASE 
WHEN COUNT(order_id)>3 THEN 'Yes'
WHEN COUNT(order_id)<=3 THEN 'No' END AS High_Density
 FROM orders GROUP BY category;
 
-- Ecommerce Demo Data
CREATE TABLE orderss (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    amount DECIMAL(10,2),
    order_date DATE
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    signup_date DATE,
    location VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    sale_date DATE
);


-- orderss
INSERT INTO orderss (user_id, product_id, amount, order_date) VALUES
(1, 101, 1500.00, '2024-06-10'),
(2, 102, 2500.00, '2024-06-11'),
(1, 103, 1800.00, '2024-06-15'),
(3, 101, 1500.00, '2024-06-20'),
(4, 104, 7000.00, '2024-07-01'),
(2, 104, 7000.00, '2024-07-02');

-- users
INSERT INTO users (user_id, user_name, signup_date, location) VALUES
(1, 'Ghanshyam', '2024-01-01', 'Indore'),
(2, 'Ananya', '2024-02-10', 'Mumbai'),
(3, 'Ravi', '2024-03-15', 'Delhi'),
(4, 'Sneha', '2024-04-20', 'Bangalore');

-- products
INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Bluetooth Speaker', 'Electronics', 1500.00),
(102, 'Running Shoes', 'Footwear', 2500.00),
(103, 'Wired Earphones', 'Electronics', 1800.00),
(104, 'Smartphone', 'Electronics', 7000.00);

-- sales
INSERT INTO sales (product_id, quantity, sale_date) VALUES
(101, 3, '2024-06-10'),
(102, 2, '2024-06-11'),
(103, 1, '2024-06-15'),
(104, 4, '2024-07-01'),
(101, 1, '2024-07-03');


-- Show each user’s total order amount, and classify them as:
-- 'High Spender' if total amount > ₹10,000
-- 'Medium Spender' if between ₹5000 and ₹10000
-- 'Low Spender' otherwise
-- Columns to show: user_id, user_name, Total_Amount, Spending_Level
SELECT * FROM users;
SELECT * FROM orderss;
SELECT 
    U.user_id,
    U.user_name,
    SUM(O.amount) AS Total_Amount,
    CASE
        WHEN SUM(O.amount) > 10000 THEN 'High Spender'
        WHEN SUM(O.amount) BETWEEN 5000 AND 10000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS Spending_Level
FROM
    orderss O
        INNER JOIN
    users U ON O.user_id = U.user_id
GROUP BY U.user_id , U.user_name;

-- Show total quantity sold and total revenue for each product.
-- Return: product_name, category, total_quantity, total_revenue
SELECT * FROM sales;
SELECT * FROM products;
SELECT P.product_name,P.category,SUM(S.quantity) AS 'Total_quantity',SUM(P.price * S.quantity) AS 'Total_revenue' FROM products P INNER JOIN sales S
ON P.product_id=S.product_id GROUP BY P.product_id;

-- List each user's total number of orders and the total amount spent.
-- Return: user_id, user_name, total_orders, total_amount
SELECT * FROM users;
SELECT * FROM orderss;
SELECT U.user_id,U.user_name,COUNT(O.order_id) AS 'Total_orders',SUM(O.amount) AS 'Total_amount' FROM 
users U INNER JOIN orderss O ON U.user_id=O.user_id GROUP BY U.user_id,U.user_name;

-- Show each category and its total revenue generated through sales.
-- Return: category, total_revenue
SELECT * FROM products;
SELECT * FROM sales;
SELECT P.category,SUM(P.price*S.quantity) AS 'Total_revenue' FROM products P INNER JOIN Sales S ON P.product_id=S.product_id
GROUP BY P.category;

-- Find the top 2 products with the highest total revenue in each category.
-- Return: category, product_name, total_revenue
SELECT * FROM products;
SELECT * FROM sales;
SELECT category,product_name,RNK,Total_revenue FROM (
SELECT P.category,P.product_name,SUM(P.price * S.quantity) AS Total_revenue,
RANK() OVER(PARTITION BY P.category ORDER BY SUM(P.price * S.quantity) DESC) AS RNK
FROM products P INNER JOIN Sales S ON P.product_id=S.product_id GROUP BY P.category,P.product_name) AS RRNK WHERE RNK<=2;

-- Show the average order amount for each user,
-- and flag them as 'Consistent' if they’ve placed more than 1 order, otherwise 'One-timer'.
-- Return: user_id, user_name, avg_order_amount, order_count, user_type
SELECT * FROM users;
SELECT * FROM orderss;
SELECT U.user_id,U.user_name,AVG(O.amount) AS Avg_order_amount,COUNT(O.order_id) AS order_count,CASE
WHEN COUNT(O.order_id) >1 THEN 'Consistent'
ELSE 'One-timer' END AS user_type FROM users U INNER JOIN orderss O ON U.user_id=O.user_id GROUP BY U.user_id,U.user_name;

-- List all users who have ordered products worth more than ₹5000 in a single order.
-- Return: user_id, user_name, order_id, amount
SELECT * FROM users;
SELECT * FROM orderss;
SELECT * FROM products;

SELECT U.user_id,U.user_name,O.order_id,O.amount FROM users U INNER JOIN orderss O ON U.user_id=O.user_id 
WHERE O.amount>5000 ;

-- Show each product’s total number of orders placed and the number of unique users who ordered it.
-- Return: product_id, product_name, total_orders, unique_users
SELECT * FROM products;
SELECT * FROM orderss;
SELECT * FROM users;
SELECT P.product_id,P.product_name,COUNT(O.order_id) AS Total_orders,COUNT(DISTINCT(U.user_id)) AS Unique_users FROM users U INNER JOIN orderss O 
ON U.user_id=O.user_id INNER JOIN products P ON O.product_id=P.product_id GROUP BY P.product_id,P.product_name;

-- Find the top-spending user in each city (location).
-- Return: location, user_name, total_spent
SELECT * FROM users;
SELECT * FROM orderss;
SELECT * FROM (SELECT U.location,U.user_name,SUM(O.amount) AS Total_spent ,
RANK() OVER(PARTITION BY U.location ORDER BY SUM(O.amount) DESC) AS RNK
FROM users U INNER JOIN orderss O ON U.user_id=O.user_id GROUP BY U.location,U.user_name) AS RRNK;

-- For each product, show the total revenue and what percentage it contributes to the overall revenue across all products.
-- Return: product_name, total_revenue, revenue_percentage
SELECT * FROM products;
SELECT * FROM sales;
WITH Total_revenues AS (SELECT P.product_name,SUM(P.price * S.quantity) AS Total_revenue FROM products P INNER JOIN sales S 
GROUP BY P.product_id,P.product_name),
Grand_revenue AS (SELECT P.product_name,SUM(P.price * S.quantity) AS Grand_revenue FROM products P INNER JOIN sales S )

SELECT TR.product_name,TR.Total_revenue,CONCAT(ROUND((TR.Total_revenue/GR.Grand_revenue)*100,2),"%") AS 'Revenue_percentage' FROM 
Total_revenues TR,Grand_revenue GR; 

-- Show all users who have placed orders in multiple months.
-- Return: user_id, user_name, months_active
-- Only include users with more than 1 distinct month.
SELECT * FROM users;
SELECT * FROM orderss;
SELECT U.user_id,U.user_name, COUNT(DISTINCT DATE_FORMAT(O.order_date, '%Y-%m')) AS months_active
FROM users U INNER JOIN orderss O ON U.user_id=O.user_id GROUP BY U.user_id,U.user_name HAVING 
COUNT(DISTINCT DATE_FORMAT(O.order_date, '%Y-%m'))>1;

-- Show each product category and how many unique users purchased from that category.
-- Return: category, unique_buyers
SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orderss;
SELECT P.category,COUNT(DISTINCT(O.user_id)) AS Unique_buyers FROM users U INNER JOIN orderss O ON U.user_id=O.user_id INNER JOIN
 products P ON O.product_id=P.product_id GROUP BY P.category;

-- Show each user's most expensive order — if there are multiple with the same highest amount, return all.
-- Return: user_id, user_name, order_id, amount
SELECT * FROM users;
SELECT * FROM orderss;
SELECT * FROM (SELECT U.user_id,U.user_name,O.order_id,O.amount,
RANK() OVER(PARTITION BY U.user_id ORDER BY O.amount DESC) AS RNK
FROM users U INNER JOIN orderss O ON U.user_id=O.user_id) AS RRNK WHERE RNK=1;

-- For each user, show their first ever order (based on order date).
-- Return: user_id, user_name, order_id, order_date
SELECT * FROM ( SELECT U.user_id,U.user_name,O.order_id,O.order_date,
ROW_Number() OVER(PARTITION BY U.user_id ORDER BY O.order_date ASC) AS RNK
 FROM users U INNER JOIN orderss O ON U.user_id=O.user_id) AS RRNK WHERE RNK=1;
 
 -- For each user, show the total number of products they’ve ordered and their total amount spent.
-- Return: user_id, user_name, total_products, total_amount
SELECT * FROM users;
SELECT * FROM orderss;
SELECT * FROM products;
SELECT * FROM sales;
SELECT U.user_id,U.user_name,COUNT(P.product_id) AS Total_products,SUM(O.amount) AS Total_amount FROM users U INNER JOIN orderss O ON U.user_id=O.user_id 
INNER JOIN products P ON O.product_id=P.product_id GROUP BY U.user_id,U.user_name;

-- For each category, show the top product (by total revenue).
-- If multiple products are tied at top, return all.
-- Return: category, product_name, total_revenue
SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orderss;
SELECT * FROM sales;
SELECT * FROM ( SELECT P.category,P.product_name,SUM(P.price * S.quantity) AS Total_revenue,
RANK() OVER(PARTITION BY P.category ORDER BY SUM(P.price * S.quantity) DESC) AS RNK
FROM orderss O INNER JOIN products P ON O.product_id=P.product_id
INNER JOIN sales S ON P.product_id=S.product_id GROUP BY P.category,P.product_id) AS RRNK WHERE RNK=1 ;

-- ye rank k ande aggregate use krne se error de skta h all over database platform ki baat kre toh that,s why option 2 solution
WITH Total_revenue AS ( SELECT P.category,P.product_name,SUM(P.price * S.quantity) AS total_revenue FROM orderss O INNER JOIN products P ON O.product_id=P.product_id
INNER JOIN sales S ON P.product_id=S.product_id GROUP BY P.category,P.product_id),
Top_product AS (SELECT category,product_name,
RANK() OVER(PARTITION BY category ORDER BY total_revenue DESC) AS RNK
FROM Total_revenue )

SELECT TR.category,TR.product_name,TR.total_revenue FROM Total_revenue TR JOIN Top_product TP ON TR.category = TP.category AND TR.product_name = TP.product_name
WHERE TP.rnk = 1;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Built IN Functions Covering all functions 
CREATE TABLE userss (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE productss (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO userss (user_id, name, email, join_date) VALUES
(1, 'Rahul', 'rahul@gmail.com', '2023-01-10'),
(2, 'Priya', 'priya@yahoo.com', '2023-02-15'),
(3, 'Amit', 'amit@outlook.com', '2023-03-01'),
(4, 'Sneha', 'sneha@gmail.com', '2023-03-25');

INSERT INTO productss (product_id, product_name, category, price) VALUES
(101, 'iPhone 13', 'Mobile', 70000),
(102, 'Galaxy S21', 'Mobile', 60000),
(103, 'Dell XPS 13', 'Laptop', 90000),
(104, 'MacBook Air', 'Laptop', 95000),
(105, 'Sony WH-1000XM4', 'Headphones', 25000);

CREATE TABLE orderss_1 (
    order_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    amount DECIMAL(10, 2),
    status VARCHAR(20),
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES userss(user_id),
    FOREIGN KEY (product_id) REFERENCES productss(product_id)
);

INSERT INTO orderss_1 (order_id, user_id, product_id, amount, status, order_date) VALUES
(1001, 1, 101, 70000, 'Delivered', '2023-03-05'),
(1002, 2, 102, 60000, 'Pending', '2023-03-07'),
(1003, 1, 105, 25000, 'Delivered', '2023-03-10'),
(1004, 3, 103, 90000, 'Cancelled', '2023-04-01'),
(1005, 4, 104, 95000, 'Delivered', '2023-04-15'),
(1006, 2, 101, 70000, 'Delivered', '2023-05-01'),
(1007, 3, 102, 60000, 'Delivered', '2023-05-02'),
(1008, 4, 105, 25000, 'Pending', '2023-05-05'),
(1009, 2, 104, 95000, 'Delivered', '2023-06-01'),
(1010, 1, 103, 90000, 'Cancelled', '2023-06-10');

SELECT * FROM orderss_1;

-- ✅ AGGREGATE FUNCTIONS – FINAL MASTER SET (INTERVIEW-READY)
-- 1 Display the total number of orders placed by each user.
SELECT * FROM userss;
SELECT * FROM orderss_1;
SELECT U.user_id,U.name,COUNT(O.order_id) AS Total_No_of_orders FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id GROUP BY U.user_id,U.name;

-- 2 Show the average product price in each category.
 SELECT * FROM productss;
 SELECT category,AVG(price) AS Average_product_price FROM productss GROUP BY category;

-- 3 Find the total amount spent by every user.
SELECT * FROM userss;
SELECT * FROM orderss_1;
SELECT U.user_id,U.name,SUM(O.amount) AS Total_amount FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id GROUP BY U.user_id,U.name;

-- 4 Identify the maximum order amount placed in any single transaction.
SELECT * FROM orderss_1;
SELECT MAX(amount) AS Maximum_amount FROM orderss_1;

-- 5 List the number of orders grouped by order status.
SELECT * FROM orderss_1;
SELECT status,COUNT(order_id) AS Number_of_orders FROM orderss_1 GROUP BY status;

-- 6 Show users who have placed more than two orders.
SELECT * FROM userss;
SELECT * FROM orderss_1;
SELECT U.user_id,U.name,COUNT(O.order_id) AS No_of_orders FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id GROUP BY 
U.user_id,U.name HAVING COUNT(O.order_id)>2;

-- 7 Display the top two users by total spending.
SELECT * FROM userss;
SELECT * FROM orderss_1;
WITH Total_spending AS (SELECT U.user_id,U.name,SUM(O.amount) AS Total_spending FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id GROUP BY 
U.user_id,U.name),
Top_two AS (SELECT *,
RANK() OVER( ORDER BY Total_spending DESC) AS RNK 
FROM Total_spending )

SELECT user_id,name,Total_spending,RNK FROM Top_two  WHERE RNK<=2 ;

-- For each user, show total number of orders and total amount spent, sorted by total amount descending.
SELECT * FROM userss;
SELECT * FROM orderss_1;
SELECT U.user_id,U.name,COUNT(O.order_id) AS Total_orders,SUM(O.amount) AS Total_amount_spent FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id
GROUP BY U.user_id,U.name ORDER BY Total_amount_spent DESC;

-- Display category-wise minimum, maximum, and average product prices.
SELECT * FROM productss;
SELECT category,
MIN(price) OVER(PARTITION BY category) AS Minimum,
MAX(price) OVER(PARTITION BY category) AS Maximum,
AVG(price) OVER(PARTITION BY category) AS Average 
FROM productss;

-- or 
SELECT category,MIN(price) AS MINIMUM,MAX(price) AS MAXIMUM,AVG(price) AS Average FROM productss GROUP BY category;

-- List product names along with how many times they were ordered and their average order amount.
SELECT * FROM productss;
SELECT * FROM orderss_1;
SELECT P.product_name,COUNT(O.order_id) AS Total_orders,AVG(O.amount) AS Total_average_order FROM productss P INNER JOIN orderss_1 O ON P.product_id=O.product_id 
GROUP BY P.product_name,P.product_id;

-- Identify the product that generated the highest total revenue.
SELECT * FROM productss;
SELECT P.product_id,P.product_name,ROUND((COUNT(O.order_id)) * (P.price),2) AS Highest_Total_revenue FROM productss P INNER JOIN orderss_1 O ON
P.product_id=O.product_id GROUP BY P.product_id,P.product_name ORDER BY Highest_Total_Revenue DESC LIMIT 1;

-- Show names of users who have spent more than ₹1,50,000.
SELECT * FROM userss;
SELECT * FROM orderss_1;
SELECT U.user_id,U.name,SUM(O.amount) AS Total_spending FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id GROUP BY U.user_id,U.name HAVING 
SUM(O.amount)>150000 ORDER BY Total_spending DESC;

-- Find categories where the average product price exceeds ₹70,000.
SELECT * FROM productss;
SELECT category,AVG(price) AS Average_price FROM productss GROUP BY category HAVING AVG(price)>70000;

-- Display month-wise total revenue from all orders.
SELECT * FROM orderss_1;
SELECT EXTRACT(MONTH FROM order_date) AS Month,SUM(amount) AS Total_revenue FROM orderss_1 GROUP BY Month;

-- Show users who placed at least 2 Delivered orders and spent more than ₹1,00,000 in total.
SELECT U.user_id,U.name,COUNT(O.order_id) AS Total_orders,SUM(O.amount) AS Total_spent FROM userss U INNER JOIN orderss_1 O ON U.user_id=O.user_id
WHERE O.status='Delivered' GROUP BY U.user_id,U.name HAVING COUNT(O.order_id)>=2 AND SUM(O.amount) >100000;

-- String functions concept 
-- ✅ Q1. Show all user names in uppercase.
SELECT * FROM userss;
SELECT UPPER(name) AS name FROM userss;

-- Q2. Show all product names in lowercase.
SELECT * FROM productss;
SELECT LOWER(product_name) AS product_name FROM productss;

-- Q3. Display the length of each user's name.
SELECT name,LENGTH(name) AS Length_of_name FROM userss;

-- Q4. Extract the first 3 characters of each product name.
SELECT * FROM productss;
SELECT product_name,LEFT(product_name,3) AS First_3_characters FROM productss;

-- Q5. Display users' email domains (everything after @ symbol).
SELECT * FROM userss;
SELECT email,SUBSTRING_INDEX(email,'@',-1) AS Email_domain FROM userss;

-- Q6. List product names where category is 'Mobile' and name starts with 'G'.
SELECT category,product_name FROM productss WHERE category='mobile' AND product_name LIKE 'G%';

-- ✅ Q7. Show each user's name, and how many characters their name contains
SELECT * FROM userss;
SELECT name,LENGTH(name) AS Character_length_before,LENGTH(TRIM(name)) AS Character_excluding_leading_trailing FROM userss;

--  Q8. Display each product name along with a version of it where all spaces are replaced with hyphens (-), like a URL slug.
SELECT * FROM productss;
SELECT product_name AS Before_replace,REPLACE(product_name,' ','-') AS After_replace FROM productss;

-- Q9. Show each user’s email, and extract only the username part (everything before the @ symbol).
SELECT * FROM userss;
SELECT email AS Before_EXTRACT,SUBSTRING_INDEX(email,'@',1) AS After_EXTRACT FROM userss;

-- Q10. Show each product name and extract only the last 4 characters from the name.
SELECT product_name,RIGHT(product_name,4) AS Last_four_characters FROM productss;

-- Q11. Show each product name along with the number of characters in the product name excluding any internal or trailing spaces.
SELECT product_name,length(replace(product_name,' ','')) FROM productss;

-- Q12. Show each user's name and return only the first 3 characters of their name.
SELECT name,LEFT(name,3) AS First_three_characters FROM userss;

--  Q13. Show the product names that contain the word "Air" anywhere in the name.
SELECT product_name FROM productss WHERE product_name LIKE '%Air%';

-- Q14. Show the name and email of all users whose email ends with .com.
SELECT * FROM userss;
SELECT name,email FROM userss WHERE email LIKE '%.com';

--  Q15. Display the category and product name where the product name has exactly 2 words.
SELECT * FROM productss;
SELECT category,product_name FROM products WHERE (LENGTH(product_name)-LENGTH(REPLACE(product_name,' ','')))=1;

-- Q16 Show each user’s name and reverse their name characters.
SELECT name,REVERSE(name) AS Reversed_name FROM userss;

-- Q17 Show product names that end with a digit (0–9).
SELECT product_name FROM products WHERE product_name REGEXP '[0-9]$';

-- Q18. Show names of all users whose name is a palindrome (same forward and backward).
SELECT name FROM userss WHERE name=REVERSE(name) ;

--  Q19. Show each product name and return how many words it contains.
SELECT product_name,SUM((LENGTH(product_name))-(LENGTH(Replace(product_name,' ',''))))+1 AS Total_words FROM productss GROUP BY product_name;

-- Q20. Show each user’s email, and return only the domain extension (e.g., gmail.com, yahoo.com).
SELECT email,SUBSTRING_INDEX(email,'@',-1) AS Domain_extensions FROM userss;

-- Q21. Show the first 5 characters from each user's email address.
SELECT email,LEFT(email,5) AS first_five_characters FROM userss;

-- Q22. Show the position of @ symbol in each user's email address.
SELECT email,INSTR(email,'@') AS position FROM userss;

-- Q23. For each product name, return the position of the word "Pro" if it exists.
SELECT product_name,INSTR(product_name,'Pro') AS Position_of_pro FROM productss WHERE product_name LIKE '%Pro%';

--  Q24. Concatenate product name and category with a hyphen (-) between them.
SELECT * FROM productss;
SELECT product_name,category,CONCAT(product_name,'-',category) AS Combined_product_name_and_category FROM productss;

--  Q25. Display product names padded on the left with * to make all names exactly 20 characters long.
SELECT product_name,LPAD(product_name,20,'*') AS Left_padded_product_name FROM productss;

-- Q26. Display product names padded on the right with . (dot) to make them 25 characters long.
SELECT product_name,RPAD(product_name,25,'.') AS Right_padded FROM productss;

-- Q27. Display each user’s name with all spaces removed.
SELECT REPLACE(name,' ','') AS name FROM userss;

--  Q28. Show each product name with:
-- First character in uppercase
-- All remaining characters in lowercase
SELECT * FROM productss;
SELECT product_name,CONCAT(UPPER(LEFT(product_name,1)),'',SUBSTRING(product_name,2)) AS First_character_uppercase FROM productss;

-- Q29. Show only those product names which:
-- Have at least one uppercase letter
-- AND contain at least one digit
SELECT * FROM productss;
SELECT product_name FROM productss WHERE product_name REGEXP '[A-Z]' AND product_name REGEXP '[0-9]';

-- Q30. Show the total number of vowels in each product name.
SELECT product_name,
       (LENGTH(product_name) - LENGTH(REPLACE(LOWER(product_name), 'a', ''))) +
       (LENGTH(product_name) - LENGTH(REPLACE(LOWER(product_name), 'e', ''))) +
       (LENGTH(product_name) - LENGTH(REPLACE(LOWER(product_name), 'i', ''))) +
       (LENGTH(product_name) - LENGTH(REPLACE(LOWER(product_name), 'o', ''))) +
       (LENGTH(product_name) - LENGTH(REPLACE(LOWER(product_name), 'u', ''))) AS vowel_count
FROM productss;

-- Show all product names whose reversed version is the same as the original name (i.e., palindromes), ignoring case and spaces.
SELECT product_name 
FROM productss 
WHERE LOWER(REPLACE(product_name, ' ', '')) = REVERSE(LOWER(REPLACE(product_name, ' ', '')));

-- ----------------------------------------------------------------------------------------------------------------------
-- DATE TIME FUNCTION 
-- Q1. Show all orders placed in the month of March.
SELECT * FROM orderss_1;
SELECT * FROM orderss_1 WHERE EXTRACT(MONTH FROM order_date)=3;

-- Q1. Show the current date and current timestamp of the system.
SELECT CURDATE(),NOW();

--  Q2. Show all orders placed today.
SELECT * FROM orderss_1 WHERE order_date=CURDATE();

-- Q3. Show the year in which each user joined.
SELECT * FROM userss;
SELECT *,YEAR(join_date) FROM userss;
SELECT *,EXTRACT(YEAR FROM join_date) as Years FROM userss;

-- Q4. List all orders placed in the year 2023.
SELECT * FROM orderss_1 WHERE YEAR(order_date)=2023;

-- Q5 Show all orders placed in April (month 4), across any year.
SELECT * FROM orderss_1 WHERE EXTRACT(MONTH FROM order_date)=4;

-- Q6 Show all orders placed in the first quarter of any year (i.e., Jan, Feb, Mar).
-- Write the query using any method you prefer 
SELECT * FROM orderss_1;
SELECT * FROM orderss_1 WHERE MONTH(order_date) IN (1,2,3);

-- Q7 Show all orders placed in the second half of the year (July to December).
-- Use whichever method you like
SELECT * FROM orderss_1 WHERE MONTH(order_date) BETWEEN 7 AND 12;

-- Q8:
-- For each order, display:
-- order_id
-- order_date
-- day name (like Monday, Tuesday, etc.)
-- month name (like January, February, etc.)
-- Use appropriate functions — your way.
SELECT order_id,order_date,DATE_fORMAT(order_date,'%W,%M,%y') AS order_date FROM orderss_1;

-- Q9:
-- For each order, show how many days have passed since it was placed (compared to today).
-- Use a function to get today's date and subtract accordingly.
SELECT * FROM orderss_1;
SELECT *,DATEDIFF(CURDATE(),order_date) AS Days_passsed FROM orderss_1 ;

-- Show only those orders which were placed within the last 60 days from today.
-- Use an appropriate filter in the WHERE clause.
SELECT * FROM orderss_1 WHERE DATEDIFF(CURDATE(),order_date)<=60;

-- Q11 For each user, show how many months have passed since they joined.
-- Use a proper function to calculate the month difference between today and their join_date
SELECT * FROM userss;
SELECT *,TIMESTAMPDIFF(MONTH,join_date,CURDATE()) AS Months_passed_from_joined FROM userss;

-- Q12 Show the number of full weeks passed since each order was placed.
SELECT * FROM orderss_1;
SELECT *,TIMESTAMPDIFF(WEEK,order_date,CURDATE()) AS 'Weeks_paased_since_order_placed' FROM orderss_1;

-- Q13. Display all orders placed on a weekend (Saturday or Sunday)
SELECT * FROM orderss_1;
SELECT *,DAYNAME(order_date) AS Day_name FROM orderss_1 WHERE DAYNAME(order_date) IN ('Saturday','Sunday');

-- Q14:
-- Show the total revenue generated in each quarter of the year 2023.
-- Quarter number
-- Total revenue in that quarter
-- Only for year 2023
SELECT * FROM orderss_1;
SELECT QUARTER(order_date) AS Quarter_number,SUM(amount) AS Total_revenue_quarter_wise FROM orderss_1 WHERE YEAR(order_date)=2023 GROUP BY Quarter_number 
ORDER BY Quarter_number;

--  Q15. Show the number of orders placed in each month of 2023, along with the full month name.
-- Expected Output Columns:
-- Month_Name (e.g., January, February)
-- Total_Orders
-- Condition:
-- Only consider orders from the year 2023.
SELECT * FROM orderss_1;
SELECT MONTHNAME(order_date) AS Month_Name,COUNT(order_id) AS Total_Orders FROM orderss_1 WHERE YEAR(order_date)=2023 GROUP BY Month_Name ORDER BY Month_Name;

-- Q16 Show the average order amount placed in each weekday (Monday to Sunday), based only on orders from the year 2023.
-- Expected Columns:
-- Weekday_Name (e.g., Monday, Tuesday...)
-- Average_Amount
SELECT * FROM orderss_1;
SELECT DAYNAME(order_date) AS Weekday_Name,AVG(amount) AS Average_Amount FROM orderss_1 WHERE YEAR(order_date)=2023 GROUP BY Weekday_Name ORDER BY Weekday_Name;

--  Q17.Show the number of orders and total revenue for each day of the week, based only on orders from the year 2023.
-- Expected Columns:
-- Weekday_Name (e.g., Monday, Tuesday…)
-- Total_Orders
-- Total_Revenue
-- Sort Output: Monday → Sunday (natural weekday order)
SELECT * FROM orderss_1;
SELECT DAYNAME(order_date) AS Weekday_Name,COUNT(order_id) AS Total_orders,SUM(amount) AS Total_Revenue FROM orderss_1 GROUP BY Weekday_Name,WEEKDAY(order_date) 
ORDER BY WEEKDAY(order_date);

-- Show the number of orders and total revenue for each month in 2023, grouped by month name, but sorted in proper calendar order (Jan to Dec).
-- 🧠 Output Columns:
-- Month_Name (e.g., January, February...)
-- Total_Orders
-- Total_Revenue
SELECT * FROM orderss_1;
SELECT MONTHNAME(order_date) AS Month_Name,COUNT(order_id) AS Total_orders,SUM(amount) AS Total_Revenue FROM orderss_1 GROUP BY Month_Name,MONTH(order_date)
ORDER BY MONTH(order_date);
SELECT * FROM orderss_1;
-- Q19. Show for each user:
-- Their user_id and name
-- The first order date they ever placed
-- The last order date they ever placed
-- Total number of orders they placed
-- 🎯 Output Columns:
-- user_id, name, First_Order_Date, Last_Order_Date, Total_Orders
SELECT * FROM userss;
USE revision3;
SHOW TABLES;
-- Q1. Get the current date and current timestamp (date + time) in two columns.
SELECT CURRENT_DATE(),CURRENT_TIMESTAMP();

--  Q2.
-- Get the day name and day of the week number from today’s date.
-- 📌 Output format:
-- day_name	weekday_number
-- Monday	2
SELECT DAYNAME(CURRENT_DATE()) AS day_name,DAYOFWEEK(CURRENT_DATE()) AS week_number;

-- Q3 Get the date after 15 days from today.
SELECT ADDDATE(CURRENT_DATE(),15) AS future_date;

-- Q4 Get the number of days between these two dates:
-- '2025-07-14'
-- '2025-05-20'
SELECT DATEDIFF('2025-07-14','2025-05-20') AS day_difference;

-- Q5 Get today’s month number, month name, and year in three columns.
-- 📌 Output format:
-- month_number	month_name	year
-- 7	July	2025
SELECT MONTH(CURRENT_DATE()) AS MONTH_NUMBER,MONTHNAME(CURRENT_DATE()) AS MONTH_NAME,YEAR(CURRENT_DATE()) AS YEAR;

-- Q6 Get the week number of the year for today's date.
SELECT WEEK(CURRENT_DATE()) AS Week_Number;

-- ---------------------------------------------------------------------------------------------------------------------------------
-- REGEXP FUNCTIONS PRACTISE FOR PATTERN MATCHING 
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO employees (name) VALUES 
('Ankit'),
('Ajay'),
('Aman'),
('ankita'),
('Zara'),
('Mohan'),
('123Ravi'),
('A$hwin'),
('Manoj'),
('Arvind'),
('Ritika'),
('Priya'),
('Aman01'),
('Am!t'),
('Jatin'),
('Amrita');
 
 
 CREATE TABLE usersss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100),
    username VARCHAR(50)
);

INSERT INTO usersss (email, username) VALUES 
('ankit123@gmail.com', 'ankit123'),
('ravi_kumar@yahoo.com', 'ravi_kumar'),
('bad-email.com', 'baduser'),
('priya@domain.in', 'priya'),
('manoj@site', 'manoj99'),
('test.user@company.org', 'test.user'),
('user123@web.net', 'user123'),
('admin@invalid', 'admin$'),
('abc@abc@abc.com', 'abcabc'),
('!user@hack.com', 'danger!'),
('hello@ok.com', 'hello123');

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(20)
);

INSERT INTO contacts (phone) VALUES
('9876543210'),
('1234567890'),
('999-888-7777'),
('+91-98765-43210'),
('0000000000'),
('phone123'),
('9999999999'),
('9123456789'),
('98765abc210'),
('88888 77777');

CREATE TABLE productsss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_code VARCHAR(50)
);

INSERT INTO productsss (product_code) VALUES
('P1001'),
('P200A'),
('X-500'),
('123-ABC'),
('ABC123'),
('PROD001'),
('a1b2c3'),
('SKU#123'),
('p@55'),
('0000');

--  Q1.Select all employee names that start with capital letter 'A'.
SELECT * FROM employees WHERE BINARY name REGEXP '^A';

-- Q2.Select all employee names from employees table that contain at least one digit (0–9).
SELECT  name FROM employees WHERE name REGEXP '[0-9]';

--  Q3.Select all employee names that contain only alphabets (A–Z or a–z) — no digits, no special characters allowed.
SELECT name FROM employees WHERE name REGEXP '[A-Z]' OR name REGEXP '[a-z]';

--  Q4 Select all employee names starting with capital vowel (A, E, I, O, U)
SELECT name FROM employees WHERE BINARY name REGEXP '^[AEIOU]';

-- Q5 Get all employee names that have at least 2 digits continuously anywhere in the name.
SELECT name FROM employees WHERE name REGEXP '[0-9]{2,}';

--  Q6.Find all employee names that contain at least one special character
SELECT name FROM employees WHERE name REGEXP '[^A-Za-z0-9]';

-- Q7 Get all phone numbers that are exactly 10 digits (only digits, no dashes or +91 etc.)
SELECT * FROM contacts;
SELECT phone FROM contacts WHERE phone REGEXP '^[0-9]{10}$';

-- Q8 Get all valid email addresses from the usersss table where:
-- It contains exactly one @
-- There is at least one . after the @
-- Only valid characters allowed before @: letters, digits, ., _, %, +, -
-- Domain part must be like: domain.com, gmail.co.in, etc.
SELECT * FROM usersss;
SELECT email FROM usersss WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2,}$';

-- Q9  Goal: Validate Indian phone numbers that are in any of the below formats:
-- Format	Valid?	Notes
-- 9876543210	✅	Pure 10-digit number
-- +91-9876543210	✅	With country code & hyphen
-- 919876543210	✅	With country code, no symbol
-- 0919876543210	✅	With 0 prefix
SELECT * FROM contacts;
SELECT phone
FROM contacts
WHERE
    (phone REGEXP '^\\+91-[6-9][0-9]{9}$' AND LENGTH(phone) = 14)
    OR (phone REGEXP '^91[6-9][0-9]{9}$' AND LENGTH(phone) = 12)
    OR (phone REGEXP '^091[6-9][0-9]{9}$' AND LENGTH(phone) = 13)
    OR (phone REGEXP '^[6-9][0-9]{9}$'
        AND LENGTH(phone) = 10
        AND phone NOT REGEXP '^91');  -- ❌ Filter out 91-starting 10-digit numbers

-- Q10. Get all employee names that:
-- ✅ Start with a capital letter
-- ✅ End with a digit
-- ✅ And contain only alphabets or digits in between (no special characters)
SELECT * FROM employees;
SELECT name 
FROM employees 
WHERE name REGEXP '^[A-Z][A-Za-z0-9]*[0-9]$';
