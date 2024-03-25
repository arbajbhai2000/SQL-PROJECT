select scope_identity()
select @@identity 
select ident_current('schoolstudent')

create procedure usp_insertStudent
as
begin
	  insert into schoolstudent values ('abc','solapur')
end
 insert into schoolstudent values ('bcd','sangli')

 insert into schoolstudent values ('edc','uhb')
 select scope_identity()

 insert into schoolstudent values ('asd','lkj')
 select ident_current('schoolstudent')

 
 insert into schoolstudent values ('rfv','okm')
 select @@identity
