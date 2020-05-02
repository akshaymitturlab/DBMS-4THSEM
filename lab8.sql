create database lab8;
use lab8;

CREATE TABLE student(
     regno VARCHAR(15),
     name VARCHAR(20),
     major VARCHAR(20),
     bdate DATE,
     PRIMARY KEY (regno) 
     );

CREATE TABLE course(
     courseno INT,
     cname VARCHAR(20),
     dept VARCHAR(20),
     PRIMARY KEY (courseno) 
     );
     
CREATE TABLE enroll(
     regno VARCHAR(15),
     courseno INT,
     sem INT(3),
     marks INT(4),
     PRIMARY KEY (regno,courseno),
     FOREIGN KEY (regno) REFERENCES student (regno),
     FOREIGN KEY (courseno) REFERENCES course (courseno) 
     );

CREATE TABLE text(
     book_isbn INT(5),
     book_title VARCHAR(20),
     publisher VARCHAR(20),
     author VARCHAR(20),
     PRIMARY KEY (book_isbn) 
     );


CREATE TABLE book_adoption(
     courseno INT,
     sem INT(3),
     book_isbn INT(5),
     PRIMARY KEY (courseno,book_isbn),
     FOREIGN KEY (courseno) REFERENCES course (courseno),
     FOREIGN KEY (book_isbn) REFERENCES text(book_isbn) 
     );

INSERT INTO student (regno,name,major,bdate) VALUES
     ('1pe11cs002','b','sr','19930924'),
     ('1pe11cs003','c','sr','19931127'),
     ('1pe11cs004','d','sr','19930413'),
     ('1pe11cs005','e','jr','19940824');


INSERT INTO course VALUES (111,'OS','CSE'),
     (112,'EC','CSE'),
     (113,'SS','ISE'),
     (114,'DBMS','CSE'),
     (115,'SIGNALS','ECE');

INSERT INTO text VALUES (book_isbn,book_title,publisher,author),
     (10,'DATABASE SYSTEMS','PEARSON','SCHIELD'),
     (900,'OPERATING SYS','PEARSON','LELAND'),
     (901,'CIRCUITS','HALL INDIA','BOB'),
     (902,'SYSTEM SOFTWARE','PETERSON','JACOB'),
     (903,'SCHEDULING','PEARSON','PATIL'),
     (904,'DATABASE SYSTEMS','PEARSON','JACOB'),
     (905,'DATABASE MANAGER','PEARSON','BOB'),
     (906,'SIGNALS','HALL INDIA','SUMIT');


INSERT INTO enroll (regno,courseno,sem,marks) VALUES
     ('1pe11cs002',114,5,100),
     ('1pe11cs003',113,5,100),
     ('1pe11cs004',111,5,100),
     ('1pe11cs005',112,3,100);


INSERT INTO book_adoption (courseno,sem,book_isbn) VALUES
(111,5,900),
(111,5,903),
(111,5,904),
(112,3,901),
(113,3,10),
(114,5,905),
(113,5,902),
(115,3,906);


SELECT c.courseno,t.book_isbn,t.book_title
     FROM course c,book_adoption ba,text t
     WHERE c.courseno=ba.courseno
     AND ba.book_isbn=t.book_isbn
     AND c.dept='CSE'
     AND 2<(
     SELECT COUNT(book_isbn)
     FROM book_adoption b
     WHERE c.courseno=b.courseno)
     ORDER BY t.book_title;

SELECT DISTINCT c.dept
     FROM course c
     WHERE c.dept IN
     ( SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher='PEARSON')
     AND c.dept NOT IN
     (SELECT c.dept
     FROM course c,book_adoption b,text t
     WHERE c.courseno=b.courseno
     AND t.book_isbn=b.book_isbn
     AND t.publisher != 'PEARSON');


