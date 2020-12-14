create database assignment7;
use assignment7;
drop database assignment7;
create table ord_master(ord_no int(4), cust_cd varchar (10), Status varchar(10));
alter table ord_master add primary key (ord_no);
insert into ord_master values(1,'C1','P');
select *from ord_master;
desc ord_master;
truncate table ord_dtl;
drop table ord_dtl;
create table ord_dtl(ord_no int(4),prod_cd varchar(4),Qty int(10),constraint fk_key foreign key (ord_no) references ord_master(ord_no));
alter table ord_dtl add primary key (prod_cd);
desc ord_dtl;
insert into ord_dtl values(1, 'P1',100),(1,'P2',200);
select * from ord_dtl;

create table Prod_master(prod_cd varchar (5), Prod_name varchar (20), Qty_in_stock int (10), Booked_qty int(10));
insert into Prod_master values('P1','Floppies',10000,1000),('P2','Printers',5000,600),('P3','Modems',3000,200);
select * from Prod_master;
drop table  Prod_master;

delimiter %%
create trigger trig_insert3 before insert on ord_dtl 
for each row
begin
update prod_master set Booked_qty =Booked_qty+new.qty where prod_cd=new.prod_cd;
end %%
drop trigger trig_insert;

insert into ord_dtl values (1,"P3",200);

select * from prod_master;
 select * from  ord_dtl;

-- question2 --
delimiter $$
create trigger before_dlt before delete on ord_dtl
for each row
begin 
update prod_master set Booked_qty=Booked_qty-new.qty where prod_cd=old.prod_cd;
end $$

delete from ord_dtl WHERE prod_cd='P3';
select *from prod_master;

-- question3 --
create table dept_sal(dept_no int,total_salary int (4 ) );
insert into dept_sal values(31,50000),(32,100000);
use assignment3;
select *from employee;

delimiter##
create trigger after_insert after insert on employee
for each row
begin
update dept_sal set total_salary=total_salary+new.salary where dept_id=new.dept_id;
end ##

insert into employee values(6,'kshitija',2,10000,1);

-- question 4--
delimiter $$
CREATE TRIGGER QUE4 AFTER DELETE ON EMP
FOR EACH ROW
BEGIN
UPDATE DEPT_SAL SET tota_salary=tota_salary - OLD.SAL WHERE DEPT_NO=OLD.DEPTNO;
END$$




