/*Task 1: Create a database named employee, then import data_science_team.csv proj_table.csv 
and emp_record_table.csv into the employee database from the given resources.*/
Create Database Employee;

/*Task 3: Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT 
from the employee record table, and make a list of employees and details of their department.*/
Select Emp_ID, First_name, last_name, Gender, Dept
  From emp_record_table;

/*Task 4: Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, 
and EMP_RATING if the EMP_RATING is: */
# less than 2
Select Emp_ID, First_name, last_name, Gender, Dept, emp_rating
From emp_record_table
Where emp_rating<2;

#greater than four
Select Emp_ID, First_name, last_name, Gender, Dept, emp_rating
From emp_record_table
Where emp_rating>4;

#between two and four
Select Emp_ID, First_name, last_name, Gender, Dept, emp_rating
From emp_record_table
Where emp_rating between 2 and 4;


/*Task 5: Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees 
in the Finance department from the employee table and then give the resultant column 
alias as NAME.*/
Select concat (First_name, ' ', last_name) as Name
From emp_record_table
Where Dept='Finance';

/*Task 6: Write a query to list only those employees who have someone 
reporting to them. Also, show the number of reporters (including the President)*/
Select Emp_ID, First_name, last_name, ROLE, Dept, Manager_id
From emp_record_table
Where manager_id IN ('E001','E083','E103','E428','E583','E612');

#Number of Reporters:
Select Emp_ID, First_name, last_name, ROLE, Dept
From emp_record_table
Where Emp_ID IN ('E001','E083','E103','E428','E583','E612');


/*Task 7: Write a query to list down all the employees from the healthcare and finance 
departments using union. Take data from the employee record table.*/
Select Emp_ID, First_name, last_name, ROLE, Dept
From emp_record_table
Where dept='Healthcare'
Union
Select Emp_ID, First_name, last_name, ROLE, Dept
From emp_record_table
Where dept='Finance';


/*Task 8: Write a query to list down employee details such as EMP_ID, FIRST_NAME, 
LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
Also include the respective employee rating along with the max emp rating for the department.*/
Select Emp_ID, First_name, last_name, ROLE, Dept, emp_rating
From emp_record_table
Where emp_rating >3
Group by Dept;

/*Task 9: Write a query to calculate the minimum and the maximum salary of the employees in each role. 
Take data from the employee record table.*/
Select ROLE, Dept, min(Salary) as Min_Salary, max(salary) as Max_Salary
From emp_record_table
Group by ROLE;

/*Task 10: Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.*/
Select emp_ID, concat(first_name, ' ', last_name) as Name, ROLE, Dept, Exp, RANK() OVER (ORDER BY exp DESC)
From emp_record_table;

/*Task 11: Write a query to create a view that displays employees in various countries whose salary is more than six thousand. 
Take data from the employee record table.*/
Create View high_salary As
Select emp_ID, concat(first_name, ' ',  last_name) as Name, ROLE, Dept, Country, Salary
From emp_record_table
Where Salary > 6000;

/*Task 12: Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.*/
Select Emp_ID, concat(First_name,' ',last_name) as Name, ROLE, Dept, Exp
From emp_record_table
Where exp IN (Select exp From emp_record_table where exp > 10);

/*Task 13:  Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. 
Take data from the employee record table*/
DELIMITER &&
Create procedure exp_greater_than_3yrs()
Begin
Select*  From emp_record_table  Where exp>3;
End &&

#For calling the result
Call exp_greater_than_3yrs();

/*Task 14: Write a query using stored functions in the project table to check whether the 
job profile assigned to each employee in the data science team matches the organization’s 
set standard.
The standard is: 
•	For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
•	For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
•	For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
•	For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
*/
DELIMITER &&
Create procedure check_standard(
emp_exp int,
emp_Role varchar(20))
Begin
Select exp INTO emp_exp;
Select Role INTO emp_Role
From data_science_team;

IF emp_exp<=2 Then
	Set emp_Role= 'JUNIOR DATA SCIENTIST';
Elseif emp_exp Between 2 and 5 Then
	Set emp_Role= 'ASSOCIATE DATA SCIENTIST';
Elseif emp_exp Between 5 And 10 Then
	Set emp_Role= 'SENIOR DATA SCIENTIST';
Else
	Set emp_Role= 'LEAD DATA SCIENTIST';
End if;
End &&


/*Task 15: Create an index to improve the cost and performance of the query to find 
the employee whose FIRST_NAME is ‘Eric’ in the employee table after 
checking the execution plan.*/
Create Index names_aesc ON emp_record_table(FIRST_NAME(200));
Select * 
From emp_record_table
where first_name = 'eric';


/*Task 16: Write a query to calculate the bonus for all the employees, based on their 
ratings and salaries (Use the formula: 5% of salary * employee rating).*/
Select Emp_ID, concat(First_name,' ',last_name) as Name, ROLE, Salary, emp_rating, salary* .05 * emp_rating as Bonus
From emp_record_table;


/*Task 17: Write a query to calculate the average salary distribution based on the 
continent and country. Take data from the employee record table.*/

Select Country, Continent, avg(salary)
From emp_record_table
Group by Country;

