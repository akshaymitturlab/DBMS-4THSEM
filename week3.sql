create database supplier;
use supplier;

create table suppliers (
						sid int primary key,
                        sname varchar(20),
                        city varchar(20)
                        );
create table parts (
					pid int primary key,
                    pname varchar(20),
                    color varchar(20)
                    );
create table catalog (
					sid int,
                    pid int,
                    cost int,
                    primary key(sid, pid),
                    foreign key(sid) references suppliers(sid),
					foreign key(pid) references parts(pid)
					);
                    
insert into suppliers values (10001, "Acme Widget", "Bangalore"), (10002, "Johns", "Kolkatta"), (10003, "Vimal", "Mumbai"), (1004, "Reliance", "Delhi");
insert into suppliers values (10004, "Reliance", "Delhi");
insert into parts values (20001, "Book", "Red"), (20002, "Pen", "Red"), (20003, "Pencil", "Green"), (20004, "Mobile", "Green"), (20005, "Charger", "Black");

insert into catalog values (10001, 20001, 10),(10001, 20002, 10),(10001, 20003, 30),(10001, 20004, 10),(10001, 20005, 10), (10002, 20001, 10),(10002, 20002, 20), (10003, 20003, 30), (10004, 20003, 40);
select distinct(catalog.sid) from parts, catalog where parts.pid = catalog.pid and parts.color = "Red";
select distinct(suppliers.sid) from parts, catalog, suppliers where parts.pid = catalog.pid and suppliers.sid = catalog.sid and parts.color = "Red" or suppliers.city = "Bangalore";

select c1.sid, c2.sid from catalog c1, catalog c2 where c1.cost > c2.cost and c1.pid = c2.pid and c1.sid <> c2.sid;
