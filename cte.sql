use arbaaj
go
select * from internstudent
go
create table intern 
(
rollnumber int,
intern_name varchar(50),
gender varchar(50),
age int,
)
insert into intern (rollnumber, intern_name, age)
values (1,'arbaj',22),(2,'novfil',23),(3,'suraj',24)
 select * from intern
 update intern 
 set gender='male'
 where gender is null
 go
  select * from intern
  go
insert into intern values(4,'jishan','male',24),(5,'sohel','male',25),(6,'swapnil','male',25)
  select * from intern
go
select intern_name,age from intern
go
create table #temp (intern_name varchar(50),age int,licence bit)

declare interncursor cursor for
select intern_name,age from intern

open interncursor

declare @intern_name varchar(50),@age int
fetch next from interncursor into @intern_name ,@age
while (@@FETCH_STATUS=0)
begin 
   if (@age >=25)
   begin
      insert into #temp values (@intern_name,@age,1)
   end 
   else
   begin
       insert into #temp values ( @intern_name,@age,0)
   end 
fetch next from interncursor into @intern_name ,@age 
end
close interncursor
deallocate interncursor
select * from #temp
go
select intern_name,age ,
(
case when age>=24 then 1 else 0 end
)from intern

--cte
select * from student 
select * from teacher
 
 select teacher.teachername as teacher_name,count(student.rollnumber)
 from student  right join teacher 
 on student.rollnumber=teacher.id
 group by teacher.teachername
 go
  select teacher.teachername as teacher_name,count(student.rollnumber)as total,student.name
 from student  right join teacher 
 on student.rollnumber=teacher.id
 group by teacher.teachername,student.name
 go
   select teacher.teachername as teacher_name,count(student.rollnumber)as total,student.name into #temp
 from student  right join teacher 
 on student.rollnumber=teacher.id
 group by teacher.teachername,student.name
 go
 select * from #temp 
 select * from #temp where total>=3
 --cte
 with cte
 as
 (
 select teacher.teachername as teacher_name,count(student.rollnumber)as total
 from student  right join teacher 
 on student.rollnumber=teacher.id
 group by teacher.teachername
 )
 select * from cte where total>=1
 
go
select * from employee2
go
 SELECT 
    e1.employee_Name AS EmployeeName, 
    Coalesce(e2.employee_Name ,null) AS ManagerName
FROM Employee2 AS e1 LEFT JOIN Employee2 AS e2
ON e1.Manager_ID = e2.Employee_ID
go
select e.employee_name as employeename,m.employee_name as managername
from employee2 e left join employee2 m
on e.manager_id=m.employee_id
go
---- manager name | number of employees reporting
select m.employee_name as managername,count(m.employee_id)as total
from employee2 e right join employee2 m
on e.manager_id=m.employee_id
group by m.employee_name
go
with cte (employee_Id, EmployeeName, ManagerId, Level)
as 
(
select employee_id,employee_name,manager_id,1 as level from employee2 
where manager_id is null
union all
select employee2.employee_id,employee2.employee_name,employee2.manager_id ,(cte.level+1)as level
from employee2 join cte
on employee2.manager_id=cte.employee_id
 
)
select * from cte
select * from employee2

 insert into employee2 values(7,'arbaj',1)