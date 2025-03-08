create database Call_Center_Data_Analysis_Project

select * from Book1

select top 1 * from Book1

--Columns
select top 0 * from Book1


--EDA

--Total Calls
select COUNT(*) from Book1

select MIN(Revenue) as [Min] from Book1

select avg(Revenue) as [Avg] from Book1

select MAX(Revenue) as [Max] from Book1

--Total Revenue

select SUM(Revenue) as [Total Revenue] 

from Book1


--Total No.Of Callers 

select COUNT(distinct Caller) as [Total Callers] 

from Book1



--Total Calls for RnR and Connected 

select  Call_status, COUNT(*) [Total Calls]

from Book1 

group by Call_status



--%RnR calls

select (cast(COUNT(*) as float)/(select COUNT(*)  from Book1)) * 100 as RnR_Calls_Per

from Book1

where Call_status = 'RnR'



--%Connectes calls

select (cast(COUNT(*) as float)/(select COUNT(*)  from Book1)) * 100 as Connected_Call_Per

from Book1

where Call_status = 'Connected'



--Country wise total revenue 

select Country, SUM(revenue) as [Total Revenue]

from Book1

group by Country

order by [Total Revenue] desc



--Category wise total revenue

select Category, sum(Revenue) [Total Revenue] 

from Book1

group by Category

order by [Total Revenue] desc


--Total Revenue by Sales 

select Sale, sum(Revenue) [Total Revenue] 

from Book1

group by Sale

order by [Total Revenue] desc



--MOM Change in Terms of Percentage

select month(Date) as [Month], SUM(revenue) as [Total Revenue],

LAG(SUM(revenue)) over( order by month(Date) asc) as [Lag_Month],

(SUM(revenue) - LAG(SUM(revenue)) over( order by month(Date) asc))  * 100

/LAG(SUM(revenue)) over( order by month(Date) asc) as MOM_Percentage

from Book1

group by month(Date)

order by [Month]

--Dates (max, min)

select MIN(date) StartDate, MAX(date) Enddate 

FROM Book1

--Days

select DATEDIFF(day, MIN(date), max(date)) as [Days] 

from Book1

--Day Wise Revenue

select DAY(date) [Days], SUM(revenue) as [Total Revenue],

LAG(SUM(revenue)) over(order by DAY(date) asc) as [Lag],

((SUM(revenue) - LAG(SUM(revenue)) over(order by DAY(date) asc)) * 100 / LAG(SUM(revenue)) over(order by DAY(date) asc)) as [DOD%]

from Book1

group by DAY(date)

order by [Days] asc


--Total Revenue by Top Country per Month

select * 

from (
		select  MONTH(date) as [Month], Country , SUM(Revenue) as [Total Revenue],

		DENSE_RANK() over(partition by MONTH(date) order by SUM(Revenue) desc) as [Rank]

		from Book1

		group by MONTH(date),Country ) 
as t1




