use arbaaj
create table department1
(
department_id int,
department_name varchar(50)
)
insert into department1 values (1,'IT'),
(2,'HR'),
(3,'ADMIN')
GO
create table employee1
(
employee_id int,
employee_name varchar(50),
department_id int 
)
insert into employee1 values (1,'ashsish',1),
(2,'ritesh',2),
(3,'jyoti',2),
(4,'archana',null),
(5,'dheeraj',null),
(6,'satish',2)
go
--1.	Select all employees whose name starts with ‘A’ [use all possible ways]
select employee_id ,employee_name, department_id  from employee1 
where employee_name like 'a%'
go
select * from employee1 where employee_name like '%a'
go
select * from employee1 where  left(employee_name,1)='a'
go
--2.	Select all employees whose name ends with ‘h’ [use all possible ways]
select * from employee1 where employee_name like '%h'
select * from employee1 where employee_name like 'h%'
--3. Find department name that does not have any employee.
select department1.department_id,employee1.employee_name,department1.department_name
from department1 left join employee1
on employee1.department_id=department1.department_id
go
select department1.department_id,employee1.employee_name,department1.department_name
from department1 left join employee1
on employee1.department_id=department1.department_id
where employee1.department_id is null
go
select department_name
from department1 
 
where not exists
(
select employee_name
from employee1
where  employee1.department_id=department1.department_id
)
go
select department1.department_id,employee1.employee_name,department1.department_name
from department1 left join employee1
on employee1.department_id=department1.department_id
go
select employee1.employee_name,department1.department_name,department1.department_id
from department1 right join employee1
on employee1.department_id=department1.department_id
go
--4.Find all employees who do not belong to any department.
select department1.department_id,employee1.employee_name,employee1.employee_id
from department1 left join employee1
on employee1.department_id=department1.department_id
where employee1.department_id is null
go
select * from employee1 where department_id is null
go
--5.Compute employee count by its department name.
SELECT department1.department_name, COUNT(employee1.employee_id) AS employee_count
FROM department1 LEFT JOIN employee1
ON department1.department_id = employee1.department_id
GROUP BY department1.department_name
go
--6.Retrieve Department Id & Name who has more than 2 employees.
select department1.department_name,department1.department_id
from department1 inner join employee1
on department1.department_id=employee1.department_id
group by department1.department_name,department1.department_id
having count(employee1.employee_id)>2
go
--7.Find Department ID and Name who has at least one employee.
select department1.department_name,department1.department_id
from department1 inner join employee1
on department1.department_id=employee1.department_id
group by department1.department_name,department1.department_id
having count(employee1.employee_id)>=1
go
SELECT department_id, department_name
FROM department1
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM employee1
)
go
--8.Write a query for below output use function wherever required.
 

select employee1.employee_name, COALESCE(department1.department_name, 'NO department')as department_name
from Employee1 left join department1
on department1.department_id=employee1.department_id
go
select employee1.employee_name, employee_id,COALESCE(department1.department_name, 'NO department')as department_name,
coalesce(department1.department_id,'0')as department_id
from Employee1 left join department1
on department1.department_id=employee1.department_id
 go
 --1.	Retrieve all customer names with product name and total price,
 --[Consider only those customers who has bought products]
 create table product1 
 (
 product_id int,
 product_name varchar(50),
 unit_price int
 )
 insert into product1 values(1,'tv',450),
 (2,'laptop',500),
 (3,'desktop',1000)
 go
 select * from product1
 go
 create table customer1
 (
 customer_id int,
 customer_name varchar(50),
 )
 insert into customer1 values(1,'ashsish'),
(2,'ritesh'),
(3,'jyoti'),
(4,'archana'),
(5,'satish')
go 
select * from customer1
go
 drop table orders
create table orders1
(
order_id int,
product_id int,
customer_id int,
quantity int
)
insert into orders1 values(1,1,1,10),
(2,1,2,15),
(3,2,3,5),
(4,3,2,1)
go
select * from orders1

SELECT
    p.product_name,
    SUM(o.quantity * p.unit_price) AS total_price,
    c.customer_name
FROM
    product1 p
JOIN
    orders1 o ON p.product_id = o.product_id
JOIN
    customer1 c ON o.customer_id = c.customer_id
GROUP BY
    p.product_name, c.customer_name;
go
--a.	Write a query for below o/p :
--Product Name	TotalQuantitySale	TotalSalePrice

 SELECT
    product1.Product_Name,
    SUM(orders1.Quantity) AS TotalQuantitySale,
    SUM(orders1.Quantity * product1.unit_Price) AS TotalSalePrice
FROM
    Product1
JOIN
    orders1  ON product1.Product_ID = orders1.Product_ID
GROUP BY
    product1.Product_Name
ORDER BY
    product1.Product_Name desc
go
--2.Select all Customer Id and Name who has not yet bought any product.
SELECT
customer1.Customer_ID, customer1.Customer_Name
FROM Customer1 
LEFT JOIN product1 
ON customer1.Customer_ID = product1.product_ID
WHERE product_ID IS NULL;
go
--3.Select all products Id and Name which are not yet sold a single product.
SELECT
product1.product_ID, product1.product_Name
FROM product1
LEFT JOIN orders1
ON   product1.Product_ID=orders1.product_ID
 WHERE orders1.Product_id Is NULL

go
--4.Select all product names with their total quantity sold.
select product1.product_name,
sum (orders1.quantity)
from product1 inner join orders1
on product1.product_id =orders1.product_id
group by product_name
go
--Consider below Employee table:
/*Eid	Name	Mid
1	Jyoti	2
2	Vikul	4
3	Dheeraj	2
4	Ashish	5
5	Sangram	NULL
6	Ritesh	2*/
go 
create table employee2
(
employee_id int,
employee_name varchar(50),
manager_id int 
)
insert into employee2 values(1,'jyoti',2),
(2,'vikul',4),
(3,'dheeraj',2),
(4,'ashish',5),
(5,'sangram',null),
(6,'ritesh',2)
go
/*Write a query to fetch beow o/p (Create a function if required):
EmployeeName	ManagerName
Jyoti	Vikul
Vikul	Ashish
Dheeraj	Vikul
Ashish	Sangram
Sangram	No Manager
Ritesh	Vikul*/
go

 SELECT 
    e1.employee_Name AS EmployeeName, 
    COALESCE(e2.employee_Name, 'no manager') AS ManagerName
FROM Employee2 AS e1 LEFT JOIN Employee2 AS e2
ON e1.Manager_ID = e2.Employee_ID
go
/*--1.Write a query to find all Employee Names, Gender Name and Department Name. 
If it’s gender not mentioned it should come as ‘No Gender’, If he does not belongs to
any department the it should come as ‘No Department*/
select * from department1
go
create table gender1
(
gender_id int,
gender_name varchar(50)
)
insert into gender1 values(1,'male'),
(2,'female'),
(3,'unknown')
select * from gender1
go
drop table employee1
create table employee1
(
employee_id int,
employee_name varchar(50),
gender_id int,
Salary INT,
department_id int
)
go
insert into employee1 values (1,'ashsish',1,9000,3),
(2,'ritesh',1,9500,null),
(3,'jyoti',2,5000,1),
(4,'archana',1,5200,1),
(5,'dheeraj',null,5200,1),
(6,'satish',2,9000,1)
go
 
 go
 select * from employee1
  /*-1.Write a query to find all Employee Names, Gender Name and Department Name. 
If it’s gender not mentioned it should come as ‘No Gender’, If he does not belongs to
any department the it should come as ‘No Department*/
	select employee1.employee_name,
	coalesce(gender1.gender_name,'no gender') as gender_name,
	coalesce(department1.department_name,'no department') as department_name
	from employee1
	left join gender1
	on employee1.gender_id=gender1.gender_id
	left join department1
	on employee1.department_id=department1.department_ID
go
--2.Retrieve all employee count by their Gender.
go
select gender1.gender_name,count(employee1.employee_id)
from employee1
inner join gender1
on employee1.gender_id=gender1.gender_id
group by gender1.gender_name
go
--3.Retrieve all employee count by their Department.
select department1.department_name,count(employee1.employee_id)
from employee1
inner join department1
on employee1.department_id=department1.department_id
group by department1.department_name
--4.Retrieve all employee count by their Gender and Department Both.
SELECT
    gender1.Gender_Name,
    department1.Department_Name,
    COUNT(employee1.Employee_ID) AS EmployeeCount
FROM Employee1 
LEFT JOIN Gender1  ON employee1.Gender_ID = gender1.Gender_ID
LEFT JOIN Department1  ON employee1.Department_ID = department1.Department_ID
GROUP BY gender1.Gender_Name, department1.Department_Name;
go
--5.Write a query to find max salary given to a male and female employee.

select gender_name,(max(salary))
as maxsalary
from employee1 e join gender1 g
on e.gender_id=g.gender_id
group by g.gender_name



select * from employee1
select * from gender1
select * from department1









