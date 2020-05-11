create database lab5;
use lab5;

CREATE TABLE FLIGHTS (
	FLNO INTEGER PRIMARY KEY,
	FFROM VARCHAR(15) NOT NULL,
	TTO VARCHAR(15) NOT NULL,
	DISTANCE INTEGER,
	DEPARTS TIMESTAMP,
	ARRIVES TIMESTAMP,
	PRICE REAL(10,2)
  );

CREATE TABLE AIRCRAFT (
	AID INTEGER PRIMARY KEY,
	ANAME VARCHAR(10),
	CRUISINGRANGE INTEGER
	);

CREATE TABLE EMPLOYEES (
	EID INTEGER PRIMARY KEY,
	ENAME VARCHAR(15),
	SALARY REAL(10,2)
    );
    
CREATE TABLE CERTIFIED (
	EID INTEGER NOT NULL,
	AID INTEGER NOT NULL,
	PRIMARY KEY (EID, AID),
	FOREIGN KEY (EID) REFERENCES EMPLOYEES (EID),
	FOREIGN KEY (AID) REFERENCES AIRCRAFT (AID)
  );

insert into aircraft values(101,'747',3000);
insert into aircraft values(102,'Boeing',900);
insert into aircraft values(103,'647',800);
insert into aircraft values(104,'Dreamliner',10000);
insert into aircraft values(105,'Boeing',3500);
insert into aircraft values(106,'707',1500);
insert into aircraft values(107,'Dream', 120000);

insert into employees values(701,'A',50000);
insert into employees values(702,'B',100000);
insert into employees values(703,'C',150000);
insert into employees values(704,'D',90000);
insert into employees values(705,'E',40000);
insert into employees values(706,'F',60000);
insert into employees values(707,'G',90000);

insert into certified values(701,101);
insert into certified values(701,102);
insert into certified values(701,106);
insert into certified values(701,105);
insert into certified values(702,104);
insert into certified values(703,104);
insert into certified values(704,104);
insert into certified values(702,107);
insert into certified values(703,107);
insert into certified values(704,107);
insert into certified values(702,101);
insert into certified values(703,105);
insert into certified values(704,105);
insert into certified values(705,103);

insert into flights values(101,'Bangalore','Delhi',2500,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 17:15:31',5000);
insert into flights values(102,'Bangalore','Lucknow',3000,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 11:15:31',6000);
insert into flights values(103,'Lucknow','Delhi',500,TIMESTAMP '2005-05-13 12:15:31',TIMESTAMP ' 2005-05-13 17:15:31',3000);
insert into flights values(107,'Bangalore','Frankfurt',8000,TIMESTAMP '2005-05-13  07:15:31',TIMESTAMP '2005-05-13 22:15:31',60000);
insert into flights values(104,'Bangalore','Frankfurt',8500,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 23:15:31',75000);
insert into flights values(105,'Kolkata','Delhi',3400,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP  '2005-05-13 09:15:31',7000);

SELECT DISTINCT A.aname
FROM Aircraft A
WHERE A.Aid IN (SELECT C.aid
 FROM Certified C, Employees E
 WHERE C.eid = E.eid AND
 NOT EXISTS ( SELECT *
 FROM Employees E1
 WHERE E1.eid = E.eid AND E1.salary <80000 )
 );

SELECT C.eid, MAX(A.cruisingrange)
FROM Certified C, Aircraft A
WHERE C.aid = A.aid
GROUP BY C.eid
HAVING COUNT(*) > 3; 

SELECT DISTINCT E.ename
FROM Employees E
WHERE E.salary <( SELECT MIN(F.price)
			FROM Flights F
			WHERE F.ffrom = 'Bangalore' AND F.tto = 'Frankfurt' );

SELECT Temp.name, Temp.AvgSalary
FROM ( SELECT A.aid, A.aname AS name, AVG (E.salary) AS AvgSalary
 FROM Aircraft A, Certified C, Employees E
 WHERE A.aid = C.aid AND C.eid = E.eid AND A.cruisingrange > 1000
 GROUP BY A.aid, A.aname )  Temp; 
 
 SELECT DISTINCT E.ename
FROM Employees E, Certified C, Aircraft A
WHERE E.eid = C.eid AND C.aid = A.aid AND A.aname LIKE 'Boeing%'; 

SELECT A.aid
FROM Aircraft A
WHERE A.cruisingrange > ( SELECT MIN(F.distance)
			FROM Flights F
			WHERE F.ffrom = 'Bangalore' AND F.tto = 'Frankfurt' );

SELECT F.departs
FROM Flights F
WHERE F.flno IN ( ( SELECT F0.flno
 FROM Flights F0
 WHERE F0.ffrom = 'Bangalore' AND F0.tto = 'Delhi'
 AND extract(hour from F0.arrives) < 18 )
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1
 WHERE F0.ffrom = 'Bangalore' AND F0.tto <> 'Delhi'
 AND F0.tto = F1.ffrom AND F1.tto = 'Delhi'
 AND F1.departs > F0.arrives
 AND extract(hour from F1.arrives) < 18)
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1, Flights F2
 WHERE F0.ffrom = 'Bangalore'
 AND F0.tto = F1.ffrom
 AND F1.tto = F2.ffrom
 AND F2.tto = 'Delhi'
 AND F0.tto <> 'Delhi'
 AND F1.tto <> 'Delhi'
 AND F1.departs > F0.arrives
 AND F2.departs > F1.arrives
 AND extract(hour from F2.arrives) < 18));

SELECT E.ename, E.salary
FROM Employees E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
 FROM Certified C )
AND E.salary >( SELECT AVG (E1.salary)
 FROM Employees E1
 WHERE E1.eid IN
( SELECT DISTINCT C1.eid
 FROM Certified C1 ) ); 

