select count(*) as total_rows 
from invoices;         # 262 # 

select count(distinct Order_ID) as Total_orders 
from invoices ;         # 182 # 




# How is the company performing overall #  

select 
	count(distinct Order_ID) as Total_Orders ,
round(sum(Sales) , 2) as Total_Sales ,                                  
round(sum(Profit) , 2 ) as Total_Profit ,                              # KPIS#
round(( sum(Profit) / sum(Sales)) , 2 ) as Profit_margin ,
round((sum(Sales) / count(distinct Order_ID)) , 2) as AOV
from invoices;




# Which Product_categorys the most sales and profit #

select Product_Category , Round(sum(Sales),2) as Total_Sales ,
 round(sum(Profit),2) as Total_Profit ,                  
 round(sum(Profit) / sum(Sales) * 100 , 2) as profit_margin
from invoices 
group by Product_Category
order by  sum(Sales) desc;




#   Which products are actualy losing money # 


select Product_Name, round(sum(Sales),2) as Total_Sales, 
round(sum(Profit),2) as Total_profit
from invoices 
group by Product_Name 
Having sum(Profit) < 0
order by sum(profit)
limit 7; 


#   Which cities are actualy losing money # 

select City, round(sum(Sales),2) as Total_Sales, 
round(sum(Profit),2) as Total_profit,
 round( sum(Profit) / sum(Sales),2) as Profit_margin
from invoices 
group by City 
Having sum(Profit) < 0
order by sum(profit)
limit 5; 


# Are there products that generate signicant sales but relative poor profit #

select Product_Name, round(sum(Sales),2) as Total_Sales, round(sum(Profit),2) as Total_Profit 
from invoices 
group by Product_name 
Having sum(Sales) > 10000 
order by sum(Sales) desc;
  
  
  
#  how are the companies regions performe and who manage these regions  #


select region.Manager, invoices.Region, round(sum(invoices.Sales),2) as Total_Sales ,
 round(sum(invoices.Profit),2) as Total_Profit, 
      sum(invoices.Profit) / sum(invoices.Sales) * 100 as Profit_Margin 
      
      from region 
      inner join invoices 
      on region.ï»¿Region = invoices.Region 
      group by region.Manager, invoices.Region;
      
      
      #  The impact of discounts on sales and profits   #
      
      select round(sum(Sales),2) as Total_Sales, 
      round(sum(Profit),2) as Total_Profit,
       round(sum(Profit) / sum(Sales),2) as Profit_Margin,
	 case
     when Discount < 0.05 then "0 - 5%" 
     when Discount < 0.10 then "5 - 10%" 
     when Discount < 0.20 then "10 - 20%" 
     else "+20%" 
     end as Discount_Bucket 
     from invoices 
	 group by Discount_Bucket;
     
