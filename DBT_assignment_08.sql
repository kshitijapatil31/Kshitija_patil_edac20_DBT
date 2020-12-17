create database assignment_08;
use assignment_08;

use assignment_03;
select * from emp;

delimiter $$
create procedure my_cursor_1_demo (in job_name varchar(20))
begin 
declare emp_name varchar(20);
declare e_sal int(10);
declare finished int(2) default 0;
declare curs_1 cursor for select ename,sal from emp where job=job_name;
declare continue handler for not found set finished = 1;
open curs_1;
test_loop:Loop
fetch curs_1 into emp_name,e_sal; 
	if finished = 1 then
	leave test_loop;
    else
    select emp_name,e_sal;
	end if;
    iterate test_loop;
end loop test_loop;
close curs_1;
end $$
drop procedure my_cursor_1_demo;

-- select ename,sal from emp;
call my_cursor_1_demo('Analyst');
select * from emp;

delimiter $$
create procedure my_cursor_2a()
begin 
declare e_id int;
declare e_name varchar(20);
declare e_sal numeric;
declare done  int default 0;
declare top_5_cursor cursor  for select  empno,ename,sal from  emp order by sal limit 5;
declare exit handler  for not  found  set done=1;
open top_5_cursor;
test_loop:loop
fetch top_5_cursor into e_id,e_name,e_sal;

	if done=1 then
	leave test_loop;
    else
    select e_id,e_name,e_sal;
	end if;
    iterate test_loop;
end  loop;
close top_5_cursor; 
end $$
call my_cursor_2a();

drop procedure my_cursor_2a;

select * from emp;

create table emp3(
emp_id int primary key,
fname varchar(20),
lname varchar(20),
salary int
);

insert into emp3 
values(111,"kshitija","patil",25000),
      (107,"nihal","patil",10000),
      (108,"sharvin","chavan",19000),
      (089,"onkar","shinde",25000),
      (110,"aarvi","chavan",20000);
-- drop table emp3;

delimiter $$
create procedure Concat_Name()
begin
declare f_name varchar(20);
declare l_name varchar(20);
declare done int default 0;
declare Concat_Names cursor for select fname,lname from emp3;
declare exit handler for not found set done=1;
open Concat_Names ;
l1:loop
fetch Concat_Names into f_name,l_name;
if done=1 then
leave l1;
else
select concat(f_name," ",l_name);
end if;
end loop;
close Concat_Names;
end $$
call Concat_Name();
drop procedure concat_name;

select * from emp3;

delimiter $$
create procedure Concat_Name()
begin
declare f_name varchar(20);
declare l_name varchar(20);
declare done int default 0;
declare Concat_Names cursor for select fname,lname from emp3;
declare exit handler for not found set done=1;
open Concat_Names ;
l1:loop
fetch Concat_Names into f_name,l_name;
if done=1 then
leave l1;
else
select concat(f_name," ",l_name);
end if;
end loop;
close Concat_Names;
end $$

call Concat_Name();
drop procedure concat_name;

select * from emp3;

delimiter $$
create procedure my_cursor_4()
begin 
declare e_id int;
declare f_name varchar(20);
declare l_name varchar(20);
declare sal int;
declare finished int default 0;
declare  show_cursor_data cursor for select * from emp3;
declare exit handler for not found set finished =1;
open show_cursor_data;
test_loop:repeat
fetch show_cursor_data into e_id,f_name,l_name,sal;
if f_name='Somnath' then
select * from emp3 where fname='Somnath';
end if;
until finished
end repeat;
close show_cursor_data;
end $$

call my_cursor_4();

create table emp2(
emp_id int primary key, 
ename varchar(20), 
salary int
);
insert into emp2 
values(101,'Kshitija',30000),
      (102,'nihal',60000),
      (103,'onkar',70000),
      (104,'aarvi',20000),
      (105,'sharvin',100000);
      
delimiter $$
create procedure my_cursor_5()
begin
declare id int;
declare e_name varchar(20);
declare sal int;
declare finished int default 0;
declare del_cursor cursor for select * from emp2 where salary<100000;
declare continue handler  for not  found set finished=1;
open del_cursor;
repeat
fetch del_cursor into id,e_name,sal;
delete from emp2 where emp_id=id;
until finished
end repeat;
close del_cursor;
end $$
drop procedure my_cursor_5;

call my_cursor_5();
select * from emp2;