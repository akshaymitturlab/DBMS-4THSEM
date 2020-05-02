create database lab4;
use lab4;

create table student(
 snum INT,
 sname VARCHAR(10),
 major VARCHAR(2),
 lvl VARCHAR(2),
age INT, PRIMARY KEY(snum));

create table faculty(
 fid INT,fname VARCHAR(20),
 deptid INT,
 PRIMARY KEY(fid));
 
 create table class(
 cname varchar(20),
 meets_at timestamp,
 room varchar(10),
 fid int,
 PRIMARY KEY (cname),
 FOREIGN KEY (fid) REFERENCES faculty (fid));
 
 CREATE TABLE enrolled(
 snum INT,
 cname VARCHAR(20),
 PRIMARY KEY(snum,cname),
 FOREIGN KEY(snum) REFERENCES student(snum),
 FOREIGN KEY(cname) REFERENCES class(cname));
 
 insert into student values(1,'john','cs','sr',19),(2,'smith','cs','jr',20),(3,'jacob','cv','sr',20),(4,'tom','cs','jr',20),(5,'rahul','cs','jr',20),(6,'rita','cs','sr',21);
 insert into faculty values(11,'harish',1000),(12,'mv',1000),(13,'mira',1001),(14,'shiva',1002),(15,'nupur',1000);
 insert into class values('class1','12/11/15 10:15:16','R1',14),('class10','12/11/15 10:15:16','R128',14),('class2','12/11/15 10:15:20','R2',12),('class3','12/11/15 10:15:25','R3',11),('class4','12/11/15 20:15:20','R4',14),('class5','12/11/15 20:15:20','R3',15),('class6','12/11/15 13:20:20','R2',14),('class7','12/11/15 10:10:10','R3',14);
 insert into enrolled values(1,'class1'),(2,'class1'),(3,'class3'),(4,'class3'),(5,'class4'),(1,'class5'),(2,'class5'),(3,'class5'),(4,'class5'),(5,'class5');
 
 select distinct sname from student, enrolled , class ,faculty where faculty.fid = class.fid AND faculty.fname = 'harish' AND enrolled.cname = class.cname AND student.snum = enrolled.snum AND student.lvl = 'jr';
 
 select distinct cname from class where class.room = 'R128' OR cname IN (select cname  from enrolled GROUP BY cname having count(*) >= 5);
 
 select distinct sname from student where student.snum IN (select e1.snum from enrolled e1 , enrolled e2, class c1, class c2 WHERE e1.snum = e2.snum AND e1.cname <> e2.cname AND e1.cname = c1.cname AND e2.cname = c2.cname AND c1.meets_at = c2.meets_at);
 
 select distinct fname from faculty,enrolled,class where 5 > (select count(enrolled.snum) from enrolled , class where enrolled.cname = class.cname AND class.fid = faculty.fid );
 
 select distinct sname from student where snum NOT IN (select distinct snum from enrolled);

 select S.age, S.lvl from student S group by S.age, S.lvl having S.lvl in (select S1.lvl from student S1 where S1.age = S.age group by S1.lvl, S1.age having count(*) >= all (select count(*) from student S2 where s1.age = S2.age group by S2.lvl, S2.age));
 