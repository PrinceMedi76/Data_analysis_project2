SELECT * FROM sales_data


SELECT Order_Date,Month,Customer_Name,State,Category,Quantity,ROUND(Sales,1) as Sale,ROUND(Profit,1) as Profit
FROM sales_data

--Calculation of Revenue
ALTER TABLE sales_data
ADD Revenue DECIMAL(10,2)
UPDATE sales_data
SET Revenue = Sales * Quantity


--We Displayed the calculated Revenue
SELECT Order_Date,Month,Customer_Name,State,Category,Quantity,ROUND(Sales,1) as Sale,ROUND(Profit,1) as Profit, Revenue
FROM sales_data



--We viewed the Table where We Had Sales with Negative profits(Loses)
SELECT RANK() OVER(PARTITION BY Category Order By Month) as RANK,
Month,Customer_Name,Category,Quantity,ROUND(Sales,1) as Sale,ROUND(Profit,1) as Profit
FROM sales_data
WHERE Profit LIKE '%-%' AND Sales NOT LIKE '%-%'

--PivotTable to show Product Category with their Yearly Total Sales
SELECT * FROM 
(
SELECT Category,Year,ROUND(Sales,2)as Sales FROM sales_data
) as SourceTable
PIVOT(
SUM(Sales)
FOR Year IN ([2014],[2015],[2016],[2017])
) as PivotTable



--Profit Gained Over Month
SELECT
Month, ROUND(SUM(Sales), 2) AS Toal_Sales
FROM sales_data
GROUP BY Month
Order By Month


--Sales By State
SELECT State, ROUND(SUM(Sales), 2) AS Toal_Sales
FROM sales_data
--WHERE Total_Sales > SUM(Sales).MAX()
GROUP BY State
Order By state


--Lets Find Out the customer Count
SELECT COUNT(DISTINCT Customer_Name) as CustomerCount FROM sales_data
--We used DISTINCT to avoid the count of duplicate Customers


--Top 5 Customers
SELECT TOP 5
Customer_Name,State,Category,ROUND(SUM(Sales), 2) as Total_Sales
FROM sales_data
GROUP BY Customer_Name,State,Category
Order By Total_Sales DESC


