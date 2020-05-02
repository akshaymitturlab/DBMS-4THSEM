create database lab6;
use lab6;

CREATE TABLE SALESMAN (
	SALESMAN_ID INT(4), 
	NAME VARCHAR (20), 
	CITY VARCHAR (20), 
	COMMISSION VARCHAR (20), 
	PRIMARY KEY (SALESMAN_ID)
);

CREATE TABLE CUSTOMER1 (
	CUSTOMER_ID INT(4), 
	CUST_NAME VARCHAR (20), 
	CITY VARCHAR (20), 
	GRADE INT (3), 
    SALESMAN_ID INT(4), 
	PRIMARY KEY (CUSTOMER_ID), 
	FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE SET NULL
);

CREATE TABLE ORDERS (
	ORD_NO INT (5), 
	PURCHASE_AMT INT (10), 
	ORD_DATE DATE, 
    CUSTOMER_ID INT(4), 
	SALESMAN_ID INT(4), 
	PRIMARY KEY (ORD_NO), 
	FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER1 (CUSTOMER_ID) ON DELETE CASCADE, 
	FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE
);

INSERT INTO SALESMAN VALUES (1000, 'JOHN','BANGALORE','25 %'); 
INSERT INTO SALESMAN VALUES (2000, 'RAVI','BANGALORE','20 %'); 
INSERT INTO SALESMAN VALUES (3000, 'KUMAR','MYSORE','15 %'); 
INSERT INTO SALESMAN VALUES (4000, 'SMITH','DELHI','30 %'); 
INSERT INTO SALESMAN VALUES (5000, 'HARSHA','HYDRABAD','15 %'); 

INSERT INTO CUSTOMER1 VALUES (10, 'PREETHI','BANGALORE', 100, 1000); 
INSERT INTO CUSTOMER1 VALUES (11,'VIVEK','MANGALORE', 300, 1000); 
INSERT INTO CUSTOMER1 VALUES (12, 'BHASKAR','CHENNAI', 400, 2000); 
INSERT INTO CUSTOMER1 VALUES (13, 'CHETHAN','BANGALORE', 200, 2000); 
INSERT INTO CUSTOMER1 VALUES (14, 'MAMATHA','BANGALORE', 400, 3000); 

INSERT INTO ORDERS VALUES (50, 5000, '04-06-17', 10, 1000); 
INSERT INTO ORDERS VALUES (51, 450, '20-01-17', 10, 2000);
INSERT INTO ORDERS VALUES (52, 1000, '24-02-17', 13, 2000); 
INSERT INTO ORDERS VALUES (53, 3500, '13-04-17', 14, 3000); 
INSERT INTO ORDERS VALUES (54, 550, '09-03-17', 12, 2000);

SELECT GRADE, COUNT(DISTINCT CUSTOMER_ID) 
FROM CUSTOMER1 
GROUP BY GRADE 
HAVING GRADE > (SELECT AVG(GRADE) 
FROM CUSTOMER1 
WHERE CITY='BANGALORE'
);

SELECT SALESMAN_ID, NAME 
FROM SALESMAN A 
WHERE 1 < (SELECT COUNT(*) 
FROM CUSTOMER1 
WHERE SALESMAN_ID=A.SALESMAN_ID
);

SELECT SALESMAN.SALESMAN_ID, NAME, CUST_NAME, COMMISSION 
FROM SALESMAN, CUSTOMER1 
WHERE SALESMAN.CITY = CUSTOMER1.CITY 
UNION 
SELECT SALESMAN_ID, NAME, 'NO MATCH', COMMISSION 
FROM SALESMAN 
WHERE NOT CITY = ANY 
(SELECT CITY 
FROM CUSTOMER1) 
ORDER BY 2 DESC;

CREATE VIEW ELITSALESMAN AS 
SELECT B.ORD_DATE, A.SALESMAN_ID, A.NAME 
FROM SALESMAN A, ORDERS B
WHERE A.SALESMAN_ID = B.SALESMAN_ID 
AND B.PURCHASE_AMT=(SELECT MAX(PURCHASE_AMT) 
FROM ORDERS C 
WHERE C.ORD_DATE = B.ORD_DATE
);

DELETE FROM SALESMAN 
WHERE SALESMAN_ID=1000;






