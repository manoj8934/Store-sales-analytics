use sales_project;
select* from store_sales;
describe store_sales;
select count(*) from store_sales;
##  - total sales,profit,quantity ##
select
round(sum(sales),2) as Total_Sale,
round(sum(profit),2) as Total_Profit,
sum(Quantity) as Total_Quantity
from store_Sales;

select round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin -- Over all profit margin (in %)
     from store_sales; 

select round(avg(sales),2) as Avg_Sale, -- avg sales & Profit
	round(avg(profit),2) as Avg_Profit
from store_sales;

##Category wise sales and profit and Profit margin in% ##
/*=============================================================================================================*/																	 
select category, round(sum(sales),2) as Total_sale from store_sales    -- -categpry-wise sales
group by category order by Total_sale desc;                           

select category ,round(sum(profit),2) as Total_Profit,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales  -- --  Category-wise Profit and Profit-margin in %
	 group by category order by Total_Profit asc;
-- # Sub-Category Wise Sales,Profit And Profit Margin #

select `sub-category`,
round(sum(profit),2) as Total_Profit,round(sum(sales),2) as Total_Sale,round(sum(discount),2) as Total_Discount, -- total sale,total profit and profit margin in %- sub -category wise 
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by `sub-category` order by Total_Profit asc;

select `sub-category`,
round(sum(profit),2) as Total_Profit,round(sum(sales),2) as Total_Sale,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by `sub-category` order by profit_margin desc limit 5; -- top 5 best perforning sub category

select `sub-category`,
round(sum(profit),2) as Total_Profit,round(sum(sales),2) as Total_Sale,  round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by `sub-category` order by profit_margin asc limit 5; --  5 sub category recievieng loss/minimum profit
     
-- # Region Wise Sales, Profit and Loss#
/*======================================================================================================*/
select region,
round(sum(sales),2) as Total_Sale,round(sum(profit),2) as Total_Profit,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by region order by Profit_margin desc ;
-- # Segment Wise Sale,Profit select region,
/*=========================================================================================================*/
select segment,
round(sum(sales),2) as Total_Sale,round(sum(profit),2) as Total_Profit,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by segment order by Profit_margin desc ;
-- # Ship mode wise sales,Profi and discount#
/*=========================================================================================*/
select ship_mode,
round(sum(sales),2) as Total_Sale,round(sum(profit),2) as Total_Profit,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by ship_mode order by Profit_margin desc;
#- category and Sub-category-wise total_sales,total_profit and ,profit margin## 
/*=======================================================================================*/
select category,`sub-category`,
round(sum(profit),2) as Total_Profit,round(sum(sales),2) as Total_Sale,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by category,`sub-category` order by profit_margin asc;
#Segment and region wise Total,Sales ,Profit an discount#
select Segment,Region,
round(sum(profit),2) as Total_Profit,round(sum(sales),2) as Total_Sale,round(sum(discount),2) as Total_Discount,
	round(sum(profit)/nullif(sum(sales),0)*100,2) as Profit_Margin from store_sales
	 group by Segment,region order by profit_margin asc;
#oders that received maximum/minimum loss/Profit #
/*==========================================================*/
with cte2 as (with cte as (select ship_mode,segment,region,category,`sub-category`,sales,
discount,profit from store_sales where profit<0) select *,case 
			 when profit=(select max(Profit) from cte) then "Min Loss"
              when profit=(select min(Profit) from cte) then "Max loss"
              else"Mid loss"
              end as "Profit_Level" from cte) select * from cte2 where Profit_Level in ("Min loss","Max loss")
              
              union
( with cte2 as(with cte as (select ship_mode,segment,region,category,`sub-category`,sales,
discount,profit from store_sales where profit>0) select *,case 
			 when profit=(select max(Profit) from cte) then "Max Pro"
              when profit=(select min(Profit) from cte) then "Min Pro"
              else"Mid loss"
              end as "Profit_Level" from cte) select* from cte2 where Profit_Level in ("Max Pro","Min Pro")) order by profit ;
              
