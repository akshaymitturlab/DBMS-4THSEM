create database students;
use students;

create table student (
					snum int primary key,
                    sname varchar(20),
                    major varchar(20),
                    lvl varchar(20),
                    age int
                    );
create table faculty (
					fid int primary key,
                    fname varchar(20),
                    deptid int
                    );
create table class (
					cname varchar(20) primary key,
                    meetsat time,
                    room varchar(20),
                    fid int,
                    foreign key(fid) references faculty(fid)
                    );
create table enrolled (
					snum int,
                    cname varchar(20),
                    primary key(snum, cname),
                    foreign key(snum) references student(snum),
                    foreign key(cname) references class(cname)
					);
                    
insert into student values (0001, "Akshay", "CSE", "JR", 19), (0002, "Ajay", "CSE", "JR", 19),(0003, "Ray", "ISE", "SR", 20),(0004, "Shay", "EEE", "JR", 19), (0005, "Rahul", "CSE", "SR", 20);
insert into faculty values (1001, "KVN", 01), (1002, "UV", 01), (1003, "PVP", 02), (1004, "PS", 03), (1005, "NM", 01);
insert into class values ("DBMS", "09:10:00", "Seminar Hall", 1001), ("COA", "09:30:00", "Auditorium", 1002), ("Management", "10:10:00", "AV Room", 1003), ("OS", "10:30:00", "Seminar Hall", 1004), ("ADA", "11:10:00", "Auditorium", 1005);
insert into enrolled values (0001, "DBMS"), (0002, "COA"), (0003, "Management"), (0004, "OS"), (0005, "ADA");\

select s.sname from enrolled e, student s, class c, faculty f where s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and s.lvl = "JR" and f.fname = "KVN";   
