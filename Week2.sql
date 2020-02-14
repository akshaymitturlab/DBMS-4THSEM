create database banking;
use banking;

create table branch(
					branch_name varchar(20) primary key,
                    branch_city varchar(20),
                    assets real
                    );
create table accounts(
					accno int primary key,
                    branch_name varchar(20),
                    balance real,
                    foreign key(branch_name) references branch(branch_name)
                    );
create table depositor(
					customer_name varchar(20) primary key,
                    customer_street varchar(20),
                    customer_city varchar(20)
                    );
create table loan(
					loan_number int primary key,
                    branch_name varchar(20),
                    amount real,
                    foreign key(branch_name) references branch(branch_name),
                    foreign key(branch_name) references accounts(branch_name)
                    );
create table borrower(
					customer_name varchar(20) primary key,
                    loan_number int,
                    foreign key(customer_name) references depositor(customer_name),
                    foreign key(loan_number) references loan(loan_number)
                    );

insert into branch values("Jalahalli", "Bangalore", 30000);
insert into branch values("Koramangala", "Bangalore", 40000);
insert into branch values("Indiranagar", "Bangalore", 50000);
insert into branch values("Banashankari", "Bangalore", 60000);
insert into branch values("Peenya", "Bangalore", 70000);

insert into accounts values(0001, "Jalahalli", 30000);
insert into accounts values(0002, "Koramangala", 50000);
insert into accounts values(0003, "Indiranagar", 3248000);
insert into accounts values(0004, "Banashankari", 3423500);
insert into accounts values(0005, "Peenya", 3342000);

insert into depositor values("Rahul", "Jalahalli Street", "Bangalore");
insert into depositor values("Rohan", "Koramangala Street", "Bangalore");
insert into depositor values("Akshay", "Indiranagar Street", "Bangalore");
insert into depositor values("Ajay", "Banashankari Street", "Bangalore");
insert into depositor values("Krishh", "Peenya Street", "Bangalore");

insert into loan values(000001, "Jalahalli", 5122151);
insert into loan values(000002, "Koramangala", 2212);
insert into loan values(000003, "Indiranagar", 98851);
insert into loan values(000004, "Banashankari", 100000);
insert into loan values(000005, "Peenya", 2002020);

insert into borrower values("Rahul", 000001);
insert into borrower values("Rohan", 000002);
insert into borrower values("Akshay", 000003);
insert into borrower values("Ajay", 000004);
insert into borrower values("Krishh", 000005);

select borrower.customer_name from borrower, loan where borrower.loan_number = loan.loan_number and loan.branch_name = "Jalahalli";

select borrower.customer_name from borrower, loan where loan.branch_name = "Jalahalli" and borrower.loan_number = loan.loan_number;

delete from accounts, branch where accounts.branch_city = "Bangalore" and branch.branch_city = accounts.branch_city);
