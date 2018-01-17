 /* joins and 1 to many exercises */
 
 -- creating customers and orders tables and insert information into tables
 CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

-- finding orders places by George
SELECT * FROM orders WHERE customer_id =
    (SELECT id from customers WHERE last_name= 'George');
    
-- implicit inner join

SELECT * FROM customers, orders 
    WHERE customers.id = orders.customer_id;
    
-- explicit inner join, order matters in how data is presented 
SELECT 
first_name, 
last_name,
SUM(amount) AS total_spent
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;
    
-- left join, (join everything to customers table, it's the left table)

SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id; 
    
SELECT 
    first_name, 
    last_name,
    IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

-- right join
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.custmer_id
    
SELECT 
    IFNULL(first_name,'MISSING') AS first, 
    IFNULL(last_name,'USER') as last, 
    order_date, 
    amount, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- Section exercise
CREATE TABLE students (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100)
    );
    
CREATE TABLE papers(
title VARCHAR(100),
grade INT,
student_id INT,
    FOREIGN KEY (student_id) 
    REFERENCES students (id)
    ON DELETE CASCADE
    );
    
INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade
FROM students
JOIN papers
ON students.id = papers.student_id;
    

SELECT first_name, title, grade
FROM students
LEFT JOIN papers
ON students.id = papers.student_id;

SELECT 
first_name, 
IFNULL(title,'MISSING') as 'title', 
IFNULL(grade, 0) as 'grade'
FROM students
LEFT JOIN papers
ON students.id = papers.student_id;

SELECT
first_name,
IFNULL(AVG(grade), 0) as average
FROM students
LEFT JOIN papers
ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average;
    
    
SELECT
first_name,
IFNULL(AVG(grade), 0) as 'average',
CASE
    WHEN AVG(grade) IS NULL then 'FAILING'
    WHEN AVG(grade) <= 75 then 'FAILING'
    ELSE 'PASSING'
 END AS 'passing_status'
FROM students
LEFT JOIN papers
ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average;
    