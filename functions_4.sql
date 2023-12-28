use B22DB
go
print getdate() -- Oct  6 2023 10:55AM
print eomonth(getdate()) -- 2023-10-31
print eomonth('2023-02-03') -- 2023-02-28
print eomonth('vhaash') -- error
print eomonth('2023-02-30') -- error
go

-- date datatypes
-- date, time, smalldatetime, datetime, datetime2, datetimeoffset

select datefromparts(2023, 10, 6) -- 2023-10-06
select datefromparts(1990, 9, 16) -- 1990-09-16
select datefromparts(1990, 9, 32) -- error

select timefromparts(11, 53, 45, 856, 3) -- 11:53:45.856
select timefromparts(11, 53, 45, 856, 7) -- 11:53:45.0000856
select timefromparts(11, 53, 45, 0, 0) -- 11:53:45

select smalldatetimefromparts(2023, 10, 6, 11, 53) -- 2023-10-06 11:53:00

select DATETIMEFROMPARTS(2023, 10, 6, 11, 23, 45, 456) -- 2023-10-06 11:23:45.457

select DATETIME2FROMPARTS(2023, 10, 6, 11,12, 52, 458, 4) -- 2023-10-06 11:12:52.0458

select DATETIMEOFFSETFROMPARTS(2023, 10, 6, 11, 12, 56, 587, 5, 30, 3)
-- 2023-10-06 11:12:56.587 +05:30

go

create table InternStudent 
(
Id int primary key identity, 
FirstName varchar(50), 
LastName varchar(50)
)
go
insert into InternStudent values ('vihaan', 'rathod'), ('mihaan', 'rathod'), 
('anup', 'pawar'), ('ajay', 'ade')
go
select Id, FirstName, LastName from InternStudent
select Id, FirstName, LastName, (FirstName + ' ' + LastName) as FullName  from InternStudent

select Id, FirstName, LastName, (Id + '. ' +  FirstName + ' ' + LastName) as FullName  
from InternStudent
-- Conversion failed when converting the varchar value '.' to data type int.

select Id, FirstName, LastName, (cast(Id as varchar(5)) + '. ' +  FirstName + ' ' + LastName) as FullName  
from InternStudent

go
create function fnGetFullName()
returns varchar(200)
as
begin
	declare @fullName varchar(200)
	select @fullName = (cast(Id as varchar(50)) + '. ' + FirstName + ' ' + LastName) 
	from InternStudent

	return @fullName
end

go

-- using function
select Id, FirstName, LastName, dbo.fnGetFullName() from InternStudent

-- we can write parameter to a function


alter function fnGetFullName(@Id int, @FirstName varchar(50), @LastName varchar(50))
returns varchar(200)
as
begin
	declare @fullName varchar(200)
	--select @fullName = (cast(Id as varchar(50)) + '. ' + FirstName + ' ' + LastName) 
	--from InternStudent

	set @fullName = cast(@Id as varchar(50)) + '. ' + @FirstName + ' ' + @LastName

	return @fullName
end
go

select dbo.fnGetFullName(Id, FirstName, LastName) from InternStudent

go
alter function fnGetFullName(@Id int, @FirstName varchar(50), @LastName varchar(50))
returns varchar(200)
as
begin
	declare @fullName varchar(200)
	--select @fullName = (cast(Id as varchar(50)) + '. ' + FirstName + ' ' + LastName) 
	--from InternStudent

	set @fullName = cast(@Id as varchar(50)) + '. ' + @FirstName + ' ' + @LastName

	return upper(@fullName)
end

go

select Id, dbo.fnGetFullName(Id, FirstName, LastName) as FullName from InternStudent

go

alter table InternStudent add DateOfBirth date 

go

select * from InternStudent

go

-- function which takes date of birth and returns age
-- 33 years 0 month 12 days


create function fnAge(@DOB date)
returns varchar(100)
as
begin
	declare @Today date = getdate()
	declare @year int

	set @year = DATEDIFF(year, @DOB, @Today)

	return cast(@year as varchar(5)) + ' years '
end

go

select Id, FirstName, LastName, DateOfBirth, dbo.fnAge(DateOfBirth) as Age from InternStudent

go

alter function fnAge(@DOB date)
returns varchar(100)
as
begin
	declare @Today date = getdate()
	declare @year int, @month int

	set @year = DATEDIFF(year, @DOB, @Today) - 
	(
	case 
	when month(@DOB) > month(@Today) or 
	(month(@DOB) = month(@Today) and day(@DOB) > day(@Today)) then 1
	else 0
	end
	)

	set @month = DATEDIFF(month, @DOB, @Today) 

	return cast(@year as varchar(5)) + ' years ' + cast(@month as varchar(10)) + ' months '
end

go

select Id, FirstName, LastName, DateOfBirth, dbo.fnAge(DateOfBirth) as Age from InternStudent

go

alter function Age(@DOB date)
returns varchar(100)
as
begin
	declare @Today date = getdate(), @TempDOB date = @DOB
	declare @year int, @month int

	set @year = DATEDIFF(year, @DOB, @Today) - 
	(
	case 
	when month(@DOB) > month(@Today) or 
	(month(@DOB) = month(@Today) and day(@DOB) > day(@Today)) then 1
	else 0
	end
	)

	set @TempDOB = dateadd(year, @year, @TempDOB)

	set @month = DATEDIFF(month, @TempDOB, @Today) 

	return cast(@year as varchar(5)) + ' years ' + cast(@month as varchar(10)) + ' months '
end

go

select Id, FirstName, LastName, DateOfBirth, dbo.Age(DateOfBirth) as Age from InternStudent

go

alter function fnAge(@DOB date)
returns varchar(100)
as
begin
	declare @Today date = getdate(), @TempDOB date = @DOB
	declare @year int, @month int, @days int

	set @year = DATEDIFF(year, @DOB, @Today) - 
	(
	case 
	when month(@DOB) > month(@Today) or 
	(month(@DOB) = month(@Today) and day(@DOB) > day(@Today)) then 1
	else 0
	end
	)

	set @TempDOB = dateadd(year, @year, @TempDOB)

	set @month = DATEDIFF(month, @TempDOB, @Today) 

	set @TempDOB = DATEADD(month, @month, @TempDOB)

	set @days = DATEDIFF(day, @TempDOB, @Today)	

	return cast(@year as varchar(5)) + ' years ' + cast(@month as varchar(10)) + ' months ' +
	cast(@days as varchar(5)) + ' days'
end

go

select Id, FirstName, LastName, DateOfBirth, dbo.fnAge(DateOfBirth) as Age from InternStudent

go

alter function fnAge(@DOB date)
returns varchar(100)
as
begin
	declare @Today date = getdate(), @TempDOB date = @DOB
	declare @year int, @month int, @days int

	set @year = DATEDIFF(year, @DOB, @Today) - 
	(
	case 
	when month(@DOB) > month(@Today) or 
	(month(@DOB) = month(@Today) and day(@DOB) > day(@Today)) then 1
	else 0
	end
	)

	set @TempDOB = dateadd(year, @year, @TempDOB)

	set @month = DATEDIFF(month, @TempDOB, @Today) - 
	(
	case
	when day(@TempDOB) > day(@Today) then 1 else 0
	end	
	)

	set @TempDOB = DATEADD(month, @month, @TempDOB)

	set @days = DATEDIFF(day, @TempDOB, @Today)	

	return cast(@year as varchar(5)) + ' years ' + cast(@month as varchar(10)) + ' months ' +
	cast(@days as varchar(5)) + ' days'
end

go

select Id, FirstName, LastName, DateOfBirth, dbo.fnAge(DateOfBirth) as Age from InternStudent

go

select dbo.fnAge('2001-01-04') -- 22 years 9 months 2 days
select dbo.fnAge('2003-03-29') -- 20 years 6 months 7 days

select dbo.fnAge('2007-12-02') -- 15 years 10 months 4 days

select DATEADD(year, 18, '2007-12-02') -- 2025-12-02 00:00:00.000

select dbo.fnAge('2000-02-02') -- 23 years 8 months 4 days

select EOMONTH('2000-02-02')

-- Aap year month or day dho tho date calculation ho sakte hai kya birthday date
