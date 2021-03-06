-- so we can inport all the tables now we can check is everything is ok --

select *
from Data18$
select*
from Data19$
select*
from Data20$
 select*
 from Meal_cost$
 select*
 from Market_segment$

 -- we see we hv different tables --
 -- if we want to see all the Year sale table on one page.we use (union)  --
 select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$


-- here we have 2018,2019,2020,table. each time we want to extract something form these table we want to right table name again and again.--
-- so we creat temporary (with Hotel) table and send all these table in it --

wit hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
select*
from hotels

---- so now we have a question . if we cant to know is our hotel revenue is growing or not .--
-- we find is any column there name of Revenue?--
 --so we have no revenue column.but we creat new column name (revenue).add [stays_in_week_nights] and[stays_in_weekend_nights]--

 with hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select stays_in_weekend_nights + stays_in_week_nights
 from hotels

--so we see we have new column with no name --
-- mow we can (*) this column with (ADR) column to get Revenue--
-- and name this column (as) Revenue

with hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select (stays_in_weekend_nights + stays_in_week_nights) * adr as Revenue
 from hotels

 -- now we have Revenue --
 -- now we can compair Revenue with year column name ( arrival_date_Year)--
  with hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select arrival_date_year,
 (stays_in_weekend_nights + stays_in_week_nights) * adr as Revenue
 from hotels
  
  -- now we can (sum) revenue and group by year (arrival_data_year) to undersand

   with hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select arrival_date_year,
sum( (stays_in_weekend_nights + stays_in_week_nights) * adr )as Revenue
 from hotels
 group by arrival_date_year

 --so we have (arrival_date_year) and (Revenu) we can say that .the hotel is growing.--
 -- so now we can compair with (hotel type)--

  with hotels as (
select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select arrival_date_year,
 hotel,
sum( (stays_in_weekend_nights + stays_in_week_nights) * adr )as Revenue
 from hotels
 group by arrival_date_year,hotel

 --so we have 2 type of (hotel) 1:City hotel. 2:Resort hotel--
 -- now we can round the (revenue) by 2 decimal afer point--
 with hotels as(
 select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
 select arrival_date_year,
 hotel,
round(sum( (stays_in_weekend_nights + stays_in_week_nights) * adr),2 )as Revenue
 from hotels
 group by arrival_date_year,hotel

 -- soo now we go with (market_segment)and (Meal_cost)--

 select*
 from Market_segment$
 select* 
 from Meal_cost$

 -- now we can check our (marketr_segment) and (meal_cost) data is avalibal in hotel data ,that we can combine all the year data name (hotel)

  with hotels as(
 select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
select* 
from hotels

-- yes we have (market_segmant) and (meal_cost) column in our (hotel) data--
-- now we can join (market_segmant) and meal_cost) in ( hotel) market_segment and meal column

 with hotels as(
 select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
select* 
from hotels
 join Market_segment$
on Market_segment$.market_segment=hotels.market_segment

--now we can joine (meal_cost) and used (left join) to see new column in end --
with hotels as(
 select *
from Data18$
union
select*
from Data19$
union
select*
from Data20$
)
select* 
from hotels
 left join Market_segment$
on Market_segment$.market_segment=hotels.market_segment
left join Meal_cost$
on Meal_cost$.meal=hotels.meal

-- so we h here now we can copy these queries and open power Bi to make some visiuaave done