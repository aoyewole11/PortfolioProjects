
--Finding the date range
Select Min(StartDate) as MinStartDate, max(StartDate) as MaxStartDate
from employees

--Employee start date by month and year
Select MONTH(StartDate) as StartMonth, Year(startdate) as StartYear, count(1) as Number
from employees
group by MONTH(StartDate), Year(startdate)
order by 2,1

--Active members on specific date
 Select *
 From employees
 where StartDate <= '2008-07-01' and (EndDate >= '2008-07-01' or EndDate is  null)


 --Count of active members on specific date
  Select count(1) as 'Active Members'
 From employees
 where StartDate <= '2008-07-01' and (EndDate >= '2008-07-01' or EndDate is   null)

 Select *
 from employees
 