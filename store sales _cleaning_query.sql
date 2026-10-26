create database Sales_Project;
Use sales_project;
select * from sales limit 10;
select count(*) as total_records from sales;
describe sales;
select
      count(*) as total_record,
      sum( case when `ship_mode` is null then 1 else 0 end) as missing_ship_mode,
      sum( case when `postal code` is null then 1 else 0 end) as missing_postal_code, 
      sum( case when `sales` is null then 1 else 0 end) as missing_sales,
      sum( case when `profit` is null then 1 else 0 end) as missing_profit 
      from sales;
      select
          sum(`ship mode` is null) as missing_shop_mode from sales;
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT CONCAT_WS('|',
        `Ship_mode`, Segment, Country, City, State,
        `Postal Code`, Region, Category, `Sub-Category`,
        Sales, Quantity, Discount, Profit
    )) AS unique_records
FROM sales;
SELECT
    Ship_Mode,
    Segment,
    City,
    Category,
    Sub-Category,
    Sales,
    Quantity,
    Discount,
    Profit,
    COUNT(*) AS occurrences
FROM sales
GROUP BY
    Ship_Mode,
     Segment,
    City,
    Category,
    Sub-Category,
    Sales,
    Quantity,
    Discount,
    Profit
HAVING COUNT(*) >=1
ORDER BY occurrences DESC
limit 10;
select * from sales limit 10;
select * from sales;
show columns from sales;

drop table sales;
show tables;
select * from sales limit 10;

select distinct ship_mode from sales;
show columns from sales;
select count(*) from sales;

-- removing duplicates
-- stanaderisation of data
-- null & blanck vakues
-- remove any rows or record
create table sales_bkp like sales;
insert sales_bkp select * from sales;
select * from sales_bkp ;

 -- 1-testing duplicates & removing dublicates
 
 select*,row_number() over(partition by Ship_mode,segment,Country,`postal code`,sales,profit)
 as row_no from sales_bkp;
 with duplicates_cte as
 (select*,row_number() over(partition by Ship_mode,segment,Country,City,State,`postal code`,region,category,
 `sub-category`,sales,Quantity,Discount,profit)
 as row_no from sales_bkp) select * from duplicates_cte where row_no>1;
 
 select* from sales_bkp where `postal code`=77041 and city="houston" and ship_mode="first class" and `sub-category`="paper";
  
  CREATE TABLE `sales_bkp` (
  `Ship_Mode` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal Code` int DEFAULT NULL,
  `Region` text,
  `Category` text,
  `Sub-Category` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL,
  `row_no` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from sales_bkp1;
insert into sales_bkp1 select*,row_number() over(partition by Ship_mode,segment,Country,City,State,`postal code`,region,category,
 `sub-category`,sales,Quantity,Discount,profit)
 as row_no from sales_bkp;
 select count(*) from (select distinct* from sales_bkp1 where row_no>1) x;
 select count(*) from sales_bkp1;
 with count_cte as (select distinct * from sales_bkp1 where row_no=1) select count(*) from count_cte;
 
 -- removing duplicates
 
 delete from sales_bkp1 where row_no>1;
select count(*) from sales_bkp1;


-- standardizing data
select distinct(ship_mode) from sales_bkp1;
select distinct(Segment) from sales_bkp1;
select distinct(Country) from sales_bkp1;
select distinct(city) from sales_bkp1;
select distinct(`postal code`) from sales_bkp1;
select distinct(Region) from sales_bkp1;
select distinct(Category) from sales_bkp1;
select distinct(`Sub-category`) from sales_bkp1;
show tables;
select * from sales_bkp1;
-- nulls and missing
select count(*) from sales_bkp1 where ship_mode is null or segment is null or City is null or State is null or 
`postal code` is null or region is null or category is null or
 `sub-category` is null or sales is null or Quantity is null or Discount is null or profit is null;
 -- removing column & row 
 alter table sales_bkp1 drop column row_no;
 
 select * from sales_bkp1;
 
  -- cleaned data recieved
  

 
 

 
 














