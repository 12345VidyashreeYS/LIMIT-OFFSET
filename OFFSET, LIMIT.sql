USE QUERIES1;

-- 1. Display the first 3 fruits ordered by QUANTITY descending, with the limit stored in a variable @n.

SELECT *FROM FRUITS;

SET @N = 3;

PREPARE STMT FROM 'SELECT *FROM FRUITS
					ORDER BY QUANTITY DESC
					LIMIT ?';
                    
EXECUTE STMT USING @N;

-- 2. Display fruits from the 4th record onwards (skip 3), ordered by FRUIT_ID, with the offset in a variable.

SET @OFFSET = 3;

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY FRUIT_ID
LIMIT ?, 7';

EXECUTE STMT USING @OFFSET;

-- 3. Display the last 2 fruits by QUANTITY (lowest 2), with the offset calculated as COUNT(*)- 2.

SET @OFFSET = (SELECT COUNT(*) -2 FROM FRUITS);

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY QUANTITY DESC
LIMIT ?, 2';

EXECUTE STMT USING @OFFSET;

-- 4. Display the 3rd highest priced fruit using a dynamic offset.

SET @OFFSET = 2;

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY PRICE DESC
LIMIT ?, 1';

EXECUTE STMT USING @OFFSET;

-- 5. Display the 2nd lowest QUANTITY fruit using a variable for the offset.

SET @OFFSET = 1;

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY QUANTITY ASC
LIMIT ?, 1';

EXECUTE STMT USING @OFFSET;

-- 6. Display 4 fruits starting after the first 2, ordered by NAME ascending, with both limit and offset as variables.

SET @OFFEST = 2;
SET @LIMITS = 4;

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY NAME ASC
LIMIT ?, ?';

EXECUTE STMT USING @OFFEST, @LIMITS;

-- 7. Skip the top 2 most expensive fruits and display the next 3.

SELECT *FROM FRUITS
order by PRICE DESC
LIMIT 2, 3;

-- 8. Display the middle record of the FRUITS table, with the offset calculated as FLOOR (COUNT(*) / 2).

SET @OFFSET = (SELECT FLOOR(COUNT(*) / 2) FROM FRUITS);
SET @ROW_COUNT  = 1;

PREPARE STMT8 FROM 'SELECT *FROM FRUITS
LIMIT ?, ?';

EXECUTE STMT8 USING @OFFSET, @ROW_COUNT;

SELECT @OFFSET;

SET @a = 5;
SET @b = 1;

PREPARE middle_stmt FROM
'SELECT * FROM FRUITS LIMIT ?, ?';

EXECUTE middle_stmt USING @a, @b;

SET @a = (SELECT FLOOR(COUNT(*) / 2) FROM FRUITS);
SET @b = 1;

PREPARE middle_stmt FROM
'SELECT * FROM FRUITS LIMIT ?, ?';

EXECUTE middle_stmt USING @a, @b;

-- 9. Display all fruits except the first 2 and last 2, ordered by FRUIT_ID, using a dynamic offset and limit.

SET @A = 2;
SET @B = 6;

PREPARE STMT FROM 'SELECT *FROM FRUITS
ORDER BY FRUIT_ID ASC
LIMIT ?, ?';

EXECUTE STMT USING @A, @B;

-- 10. Display the page 3 records of FRUITS (page size 3), with @page and @size as variables.

-- 11. Display the top 5 highest-paid employees, with the limit passed through @n.

SELECT *FROM EMPLOYEES;

SET @N = 5;

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
					order by SALARY DESC
					LIMIT ?';
                    
EXECUTE STMT USING @N;

-- 12. Display the 2nd highest salary employee using a dynamic offset.

SET @OFF = 1;

PREPARE STMR FROM 'SELECT *FROM EMPLOYEES
ORDER BY SALARY DESC
LIMIT ?, 1';

EXECUTE STMR USING @OFF;

-- 13. Display the 4th most recently hired employee (HIRE_DATE descending).

SELECT *FROM EMPLOYEES
order by HIRE_DATE DESC
LIMIT 3, 1;

-- 14. Display the 3 lowest-paid employees using an offset calculated from COUNT(*).

SET @O = (SELECT COUNT(*) -3 FROM EMPLOYEES);

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
ORDER BY SALARY DESC 
LIMIT ?, 3';

EXECUTE STMT USING @O;

-- 16. Display the 3 employees starting from the 5th highest salary, ordered by SALARY descending.

SELECT *FROM EMPLOYEES
order by SALARY DESC
LIMIT 4, 3;

-- 17. Display the 2 earliest hired employees from the IT department using a dynamic limit.

SET @LIM = 2;

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
WHERE DEPARTMENT = "IT"
ORDER BY HIRE_DATE ASC
LIMIT ?';

EXECUTE STMT USING @LIM;

-- 18. Display the second-highest-paid employee in the Sales department using a dynamic offset.

SET @OFF = 1;

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
WHERE DEPARTMENT = "SALES"
ORDER BY SALARY DESC
LIMIT ?, 1';

EXECUTE STMT USING @OFF;

-- 19. Display the last 3 employees by EMP_ID using an offset based on a count subquery.

SET @OFFSET = (SELECT COUNT(*) -3 FROM EMPLOYEES);

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
ORDER BY EMP_ID ASC
LIMIT ?, 3';

EXECUTE STMT USING @OFFSET;

-- 20. Display the employee at the exact middle position when ordered by SALARY, with the offset calculated dynamically.

SELECT COUNT(*) FROM EMPLOYEES;

SET @OFF = (SELECT FLOOR(COUNT(*) / 2) FROM EMPLOYEES);

PREPARE STMT FROM 'SELECT *FROM EMPLOYEES
LIMIT ?, 1';

EXECUTE STMT USING @OFF;

SET @OFF = (
    SELECT CAST(FLOOR(COUNT(*) / 2) AS UNSIGNED)
    FROM EMPLOYEES
);

SET @ROW_COUNT = 1;

PREPARE MIDDLE_EMP FROM
'SELECT * FROM EMPLOYEES
LIMIT ?, ?';

EXECUTE MIDDLE_EMP USING @OFF, @ROW_COUNT;

-- 21. Display the top 3 scorers (MARKS) using a limit variable.

SELECT *FROM STUDENTS;

SET @LIMIT = 3;

PREPARE STMT FROM 'SELECT *FROM STUDENTS
ORDER BY MARKS DESC
LIMIT ?';

EXECUTE STMT USING @LIMIT;

-- 22. Display the 2nd, 3rd and 4th rank students by MARKS (skip 1, take 3).

SELECT *FROM STUDENTS
ORDER BY MARKS DESC
LIMIT 1, 3;

-- 23. Display the bottom 3 students by MARKS using a dynamic offset from COUNT(*).

SET @OFFSET = (SELECT COUNT(*) -3 FROM STUDENTS);

PREPARE STMT FROM 'SELECT *FROM STUDENTS
ORDER BY MARKS DESC
LIMIT ?, 3';

EXECUTE STMT USING @OFFSET;

-- 24. Display the 5th rank student using a variable for the offset.

SET @OFF = 4;

PREPARE STMT FROM 'SELECT *FROM STUDENTS
ORDER BY MARKS DESC
LIMIT ?, 1';

EXECUTE STMT USING @OFF;

-- 25. Display students from the BCA course, skipping the first one, ordered by MARKS descending.

SELECT *FROM STUDENTS
WHERE COURSE = 'BCA'
ORDER BY MARKS DESC
LIMIT 1, 18446744073709551615;

-- 26. Display page 2 of students (page size 5), ordered by NAME ascending.

-- 27. Display the youngest 4 students by AGE using a dynamic limit.

SET @OAGE = 4;

PREPARE STMT FROM 'SELECT *FROM STUDENTS
ORDER BY AGE ASC
LIMIT ?';

EXECUTE STMT USING @OAGE;

-- 28. Display the student who stood last (lowest marks) in the BSc course using a count-based offset.

SET @OFF = (SELECT COUNT(*) -5 FROM STUDENTS);

PREPARE STMT FROM 'SELECT *FROM STUDENTS
WHERE COURSE = "BSc"
ORDER BY MARKS DESC
LIMIT ?, 1';

EXECUTE STMT USING @OFF;

CREATE TABLE PRODUCTS (
PRODUCT_ID INT PRIMARY KEY AUTO_INCREMENT,
PRODUCT_NAME CHAR(40),
CATEGORY VARCHAR(20),
PRICE DECIMAL(10,2),
STOCK INT,
RATING DECIMAL(2,1)
);

INSERT INTO PRODUCTS (PRODUCT_NAME, CATEGORY, PRICE, STOCK, RATING)
VALUES
('Laptop','Electronics',55000,25,4.5),
('Mouse','Electronics',500,200,4.1),
('Keyboard','Electronics',1200,150,4.3),
('Office Chair','Furniture',7500,40,4.0),
('Desk','Furniture',12000,15,4.4),
('Notebook','Stationery',60,500,3.9),
('Pen Pack','Stationery',120,350,4.2),
('Monitor','Electronics',14000,30,4.6),
('Bookshelf','Furniture',9000,12,3.8),
('Stapler','Stationery',250,90,4.0);

-- 29. Display the 3 most expensive products using a limit variable.

SELECT *FROM PRODUCTS;

SET @LIM = 3;

PREPARE STMT FROM 'SELECT *FROM PRODUCTS
ORDER BY PRICE DESC
LIMIT ?';

EXECUTE STMT USING @LIM;

-- 30. Display the 2nd cheapest product using a dynamic offset.

SET @OFF = 1;

PREPARE STMT FROM 'SELECT *FROM PRODUCTS
ORDER BY PRICE ASC
LIMIT ?, 1';

EXECUTE STMT USING @OFF;

-- 31. Display the 3rd highest-rated product, using RATING descending and a variable offset.

SET @OFFSET = 2;

PREPARE STMT FROM 'SELECT *FROM PRODUCTS
ORDER BY RATING DESC
LIMIT ?, 1';

EXECUTE STMT USING @OFFSET;

-- 32. Display the products on page 2 (page size 3), ordered by PRICE descending.

-- 33. Display the 2 products with the lowest stock, skipping the very lowest one.

SELECT *FROM PRODUCTS
ORDER BY STOCK asc
LIMIT 1, 2;

-- 34. Display the top 2 Electronics products by price after skipping the most expensive one.

SELECT *FROM PRODUCTS
WHERE CATEGORY = 'ELECTRONICS'
ORDER BY PRICE DESC
LIMIT 1, 2;

-- 35. Display the last 4 products by PRODUCT_ID using an offset calculated from COUNT(*).

SET @OFFSET = (SELECT COUNT(*) -4 FROM PRODUCTS);

PREPARE STMT FROM 'SELECT *FROM PRODUCTS
ORDER BY PRODUCT_ID
LIMIT ?, 4';

EXECUTE STMT USING @OFFSET;












