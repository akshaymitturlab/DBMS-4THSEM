create database lab9;
use lab9;

create table ACTOR (
	id int primary key, 
	name varchar(10), 
	gender varchar(1)
);

create table DIRECTOR (
	id int primary key, 
	name varchar(10), 
	phone varchar(10)
);

create table MOVIE (
	id int primary key, 
	title varchar(20), 
	year int, 
	lang varchar(10), 
	dir_id int, 
	foreign key(dir_id) references DIRECTOR(id)
);
create table CAST (
	act_id int, 
	mov_id int, 
	role varchar(20), 
	primary key(act_id, mov_id), 
	foreign key(act_id) references ACTOR(id), 
	foreign key(mov_id) references MOVIE(id)
);
create table RATING(
	mov_id int, 
	stars int, 
	foreign key(mov_id) references MOVIE(id),
	check (stars > 0 and stars <= 5)
);

insert into ACTOR values (301,'anushka','f'),
(302,'prabhas','m'),
(303,'punith','m'),
(304,'jermy','m');

insert into DIRECTOR values (60,'rajamouli',8751611001),
(61,'hitchcock',7766138911),
(62,'faran',9986776531),
(63,'spielberg',8989776530);

insert into MOVIE values (1001,'bahubali-2',2017,'telugu',60),
(1002,'bahubali-1',2015,'telugu',60),
(1003,'akash',2008,'kannada',61),
(1004,'war horse',2011,'english',63);

insert into CAST values (1001,4),
(1002,2),(1003,5),(1004,4);

insert into RATING values (301,1002,5),
(301,1001,4),
(303,1003,3),
(303,1002,2),
(304,1004,1);

select title from MOVIE m, DIRECTOR d where d.name='Hitchcock' and d.id=m.dir_id;

select distinct title from MOVIE m, CAST c where m.id=c.mov_id and c.act_id in (select act_id from CAST group by act_id having COUNT(mov_id) > 1);

select distinct name from ACTOR a, CAST c where c.act_id=a.id and c.mov_id in (select id from MOVIE m where year NOT BETWEEN 2000 and 2015);
/*or*/
select distinct name from ACTOR a inner join CAST c on a.id=c.act_id and c.mov_id in (select id from MOVIE m where year NOT BETWEEN 2000 and 2015);

select title, stars from MOVIE m inner join (select mov_id, max(stars) as stars from RATING group by mov_id) r on m.id=r.mov_id order by title;

SET SQL_SAFE_UPDATES=0;

update RATING set stars=5 where mov_id in (select m.id from MOVIE m, DIRECTOR d where m.dir_id = d.id and d.name='spielberg');
select * from RATING;