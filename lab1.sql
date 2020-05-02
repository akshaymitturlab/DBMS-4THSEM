create database lab1;
use lab1;

create table person(
driver_id varchar(20),
name varchar(20),
address varchar(30),
primary key(driver_id)
);

insert into person values ('A01', 'Richard', 'Srinivas Nagar');
insert into person values ('A02', 'Pradeep', 'Rajaji Nagar');
insert into person values ('A03', 'Smith', 'Ashok Nagar');
insert into person values ('A04', 'Venu', 'NR Colony');
insert into person values ('A05', 'Jhon', 'Hanumanth Nagar');

select * from person;

create table car(
reg_num varchar(20),
model varchar(10),
year int,
primary key(reg_num)
);

insert into car values ('KAO52250', 'Indica', 1990);
insert into car values ('KAO52232', 'Lancer', 1957);
insert into car values ('KAO52794', 'Toyota', 1998);
insert into car values ('KAO52468', 'Honda', 2008);
insert into car values ('KAO52542', 'Audi', 2005);

create table accident(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num)
);

insert into accident values (11, '03-01-01', 'Mysore Road');
insert into accident values (12, '04-02-02', 'South End Circle');
insert into accident values (13, '03-01-21', 'Bull Temple Road');
insert into accident values (14, '08-02-17', 'Mysore Road');
insert into accident values (15, '05-03-04', 'Kanakpura Road');

create table owns(
driver_id varchar(20),
reg_num varchar(20),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num)
);

insert into owns values ('A01', 'KAO52250');
insert into owns values ('A02', 'KAO52232');
insert into owns values ('A03', 'KAO52794');
insert into owns values ('A04', 'KAO52468');
insert into owns values ('A05', 'KAO52542');

create table participated(
driver_id varchar(20),
reg_num varchar(20),
report_num int, 
damage_amount int,
primary key(driver_id, reg_num, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num)
);

insert into participated values ('A01', 'KAO52250', 11, 10000);
insert into participated values ('A02', 'KAO52232', 12, 50000);
insert into participated values ('A03', 'KAO52794', 13, 25000);
insert into participated values ('A04', 'KAO52468', 14, 33000);
insert into participated values ('A05', 'KAO52542', 15, 12400);

update participated 
set damage_amount = 25000
where report_num = 12;

insert into accident values (16, '04-02-02', 'MG Road');

select count(driver_id) 
from participated, accident
where participated.report_num = accident.report_num
and accident_date like '%08';

select count(participated.reg_num)
from participated, car, accident
where participated.reg_num = car.reg_num
and participated.report_num = accident.report_num
and car.model = 'Audi';