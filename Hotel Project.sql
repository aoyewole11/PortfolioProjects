Select * 
from Hotel2018
union

Select *
from Hotel2019
union
Select *
from Hotel2020

--IS HOTEL REVENUE GROWING

--With Hotels as (
--Select * 
--from Hotel2018
--union

--Select *
--from Hotel2019
--union

--Select *
--from Hotel2020)

--Select (stays_in_week_nights + stays_in_weekend_nights)*adr as Revenue from Hotels

go
With Hotels as (
Select * 
from Hotel2018
union

Select *
from Hotel2019
union

Select *
from Hotel2020)

Select arrival_date_year,hotel ,round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr),2) as Revenue from Hotels
group by arrival_date_year, hotel
go

With Hotels as (
Select * 
from Hotel2018
union

Select *
from Hotel2019
union

Select *
from Hotel2020)


Select * from Hotels as H
left join market_segment as MS
on h.market_segment = ms.market_segment
left join meal_cost as MC
on MC.meal = H.meal
