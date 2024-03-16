use B22DB
go
declare @Mobile tinyint = 256
print @Mobile
go
create table B22Student
(
RollNumber int,
Name varchar(50),
Gender varchar(10),
City varchar(50),
Age int,
PaidFees int,
IsConfirmed bit
)
go
select * from B22Student
go
select 1
select 'ajay'
select 'ajay' as Name, 'pune' as City
-- all columns all data from table
select * from B22Student 
-- it is not recommended
-- * means all and it is not good for performance
-- even if we want to select all columns we need to specify all column name instead *
-- it is good for maintainability
select RollNumber, Name, Gender, City, Age, PaidFees, IsConfirmed from B22Student
select Name, PaidFees, IsConfirmed from B22Student

-- select only 5 records
select top 5 RollNumber, Name, Gender, City, Age, PaidFees, IsConfirmed from B22Student

insert into B22Student values
(9,	'ajay',	'male',	'pune',	22,	25000,	1)

select RollNumber, Name, Gender, City, Age, PaidFees, IsConfirmed from B22Student

select Name, PaidFees, IsConfirmed from B22Student

-- unique records
select distinct Name, PaidFees, IsConfirmed from B22Student

select distinct RollNumber, Name, Gender, City, Age, PaidFees, IsConfirmed from B22Student

-- where clause
