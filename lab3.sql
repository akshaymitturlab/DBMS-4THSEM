create database lab3;
use lab3;

create table supplier(
sid int,
sname varchar(30),
city varchar(30),
primary key(sid)
);

create table parts(
pid int,
pname varchar(30),
color varchar(10),
primary key(pid)
);

create table catalog(
sid int,
pid int,
cost float,
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid)
);

insert into supplier values (10001, "Acme Widget", "Bangalore"), (10002, "Johns", "Kolkata"), (10003, "Vimal", "Mumbai"), (10004, "Reliance", "Delhi");

insert into parts values (20001, "Book", "Red"),
						(20002, "Pen", "Red"),
                        (20003, "Pencil", "Green"),
                        (20004, "Mobile", "Green"),
                        (20005, "Charger", "Black");

insert into catalog values (10001, 20001, 10),
						(10001, 20002, 10),
                        (10001, 20003, 30),
                        (10001, 20004, 10),
                        (10001, 20005, 10),
                        (10002, 20001, 10),
                        (10002, 20002, 20),
                        (10003, 20003, 30),
                        (10004, 20003, 40);
                        
select distinct sid
from catalog, parts
where parts.color = 'Red'
or parts.color = 'Green'
and parts.pid = catalog.pid;

select distinct supplier.sid
from supplier, parts, catalog
where catalog.sid = supplier.sid
and catalog.pid = parts.pid
and parts.color = 'Red'
or supplier.city = 'Bangalore';

select distinct c1.sid first, c2.sid second
from catalog c1, catalog c2
where c1.cost > c2.cost
and c1.sid != c2.sid
and c1.pid = c2.pid;

select distinct pname 
from Parts, Catalog
where Parts.pid=Catalog.pid;

select sname 
from Supplier
where not exists( select pid from Parts
					not in (
                    select distinct pid 
                    from Catalog
                    where Catalog.sid=Supplier.sid)
                    );

select sname 
from Supplier
where not exists( select pid from Parts where color='Red'
					not in
                    select distinct Catalog.pid 
                    from Catalog , Parts
                    where Parts.pid=Catalog.pid and Parts.color='Red' and  Catalog.sid=Supplier.sid);
                    

select pname
from Parts,Catalog,Supplier
where Catalog.pid=Parts.pid and Catalog.sid=Supplier.sid 
and Supplier.sname='Acme Widget' and Catalog.pid not in (select c.pid from Catalog c ,Supplier s
							where s.sid=c.sid and s.sname<>'Acme Widget');


select sid
from Catalog c
where c.cost>( select avg(c1.cost)
		from Catalog c1
		where c.pid=c1.pid);
                
                
select p.pid, s.sname
from Parts p, Supplier s, Catalog c
where p.pid=c.pid and s.sid=c.sid
and c.cost=(select max(c1.cost)
	    from Catalog c1
            where c1.pid=c.pid);