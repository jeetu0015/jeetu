create database if not exists interview_commands_practice;
use interview_commands_practice;

create table employees (
employee_id int primary key,
name varchar(100),
department varchar(50),
city varchar(50),
salary decimal(10,2),
status varchar(20),
phone varchar(15)
) engine = innodb;

insert into employees (employee_id, name, department, city, salary, status, phone) values
(1, 'Rahul Sharma', 'IT', 'Delhi', 45000.00, 'Active', '9000000001'),
(2, 'Priya Singh', 'HR', 'Mumbai', 38000.00, 'Active', '9000000002'),
(3, 'Amit Patel', 'Sales', 'Ahmedabad', 32000.00, 'Active', '9000000003'),
(4, 'Sneha Verma', 'IT', 'Pune', 50000.00, 'Active', '9000000004'),
(5, 'Vijay Kumar', 'Finance', 'Bangalore', 55000.00, 'Active', '9000000005'),
(6, 'Sanjay Reddy', 'Sales', 'Hyderabad', 30000.00, 'Active', '9000000006'),
(7, 'Megha Iyer', 'IT', 'Chennai', 48000.00, 'Active', '9000000007'),
(8, 'Neha Gupta', 'HR', 'Delhi', 32000.00, 'Active', '9000000008'),
(9, 'Arjun Mehta', 'Finance', 'Pune', 52000.00, 'Active', '9000000009'),
(10, 'Pooja Shah', 'Sales', 'Mumbai', 40000.00, 'Active', '9000000010');
commit;

-- q1 - naya banda aaya hai karan, usko ek hi baar me add kar rahe hai
insert into employees (employee_id, name, department, city, salary, status, phone)
values (11, 'Karan Malhotra', 'IT', 'Noida', 41000.00, 'Active', '9000000011');

-- q2 - ab do bande ek sath add kar rahe hai, alag-alag insert nahi likhna hai
insert into employees (employee_id, name, department, city, salary, status, phone) values
(12, 'Simran Kaur', 'HR', 'Delhi', 35000.00, 'Active', '9000000012'),
(13, 'Rohan Das', 'Sales', 'Pune', 33000.00, 'Inactive', '9000000013');

-- q3 - karan gurgaon shift ho gaya hai aur uski salary bhi badh gayi, dono ek sath change kar rahe hai
update employees set city = 'Gurgaon', salary = 46000.00 where employee_id = 11;

-- q4 - 1, 4, 7 walo ki salary me 10% badha rahe hai, baaki ko haath nahi lagana hai
update employees set salary = salary * 1.10 where employee_id in (1, 4, 7);

-- q5 - 6 aur 13 wale job chhod ke chale gaye, unko ek hi delete me uda rahe hai
delete from employees where employee_id in (6, 13);

-- check kar le kya hua
select * from employees;

-- q6 - naya column jod rahe hai email wala, abhi sabke liye khaali rahega
alter table employees add email varchar(100) null;

-- q7 - phone wala column chhota pad raha tha, usko 15 se 20 ka kar rahe hai
alter table employees modify phone varchar(20) null;

-- q8 - city ka naam badal ke work_city kar rahe hai, andar ka data waisa hi rahega
alter table employees rename column city to work_city;

-- q9 - email wala column kaam ka nahi hai, usko hi uda rahe hai, baaki sab rahega
alter table employees drop column email;

-- q10 - ab table ka naam hi badal rahe hai employees se staff, andar ka sab kuch waisa hi rahega
rename table employees to staff;

-- check kar le
select * from staff;

-- q11 - pehle transaction shuru kar rahe hai, nisha ko add karke priya ki salary badha ke, fir commit karke pakka save kar rahe hai
start transaction;
insert into staff (employee_id, name, department, work_city, salary, status, phone)
values (14, 'Nisha Rao', 'IT', 'Noida', 48000.00, 'Active', '9000000014');
update staff set salary = 45000.00 where employee_id = 2;
commit;

-- q12 - ab fir se transaction me vijay ki salary badha ke neha ko delete kar rahe hai, par manager ne mana kar diya to rollback karke sab wapas le rahe hai
start transaction;
update staff set salary = 60000.00 where employee_id = 5;
delete from staff where employee_id = 8;
rollback;

-- check kar le, 5 ki purani salary wapas aur 8 abhi bhi hoga
select * from staff where employee_id in (5, 8);

-- q13 - ab savepoint wala khel hai, aadha save karna hai aadha wapas lena hai
start transaction;
update staff set salary = 47000.00 where employee_id = 14;
savepoint salary_saved;
update staff set work_city = 'Jaipur' where employee_id = 14;
savepoint city_saved;
delete from staff where employee_id = 14;
rollback to city_saved;
rollback to salary_saved;
commit;

-- check kar le, salary wali change rahegi, city wali wapas noida ho jayegi
select * from staff where employee_id = 14;

-- q14 - ab saara data saaf kar rahe hai truncate se, table rahega bas andar khaali ho jayega, aur rollback se wapas nahi aayega
start transaction;
truncate table staff;
rollback;
select * from staff;

-- q15 - sabse last me, pehle table uda rahe hai fir database hi uda rahe hai, isko sabse end me hi chalana
drop table staff;
drop database interview_commands_practice;