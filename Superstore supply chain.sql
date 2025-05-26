USE superstore;

SELECT * FROM sales
LIMIT 10;

-- What are the total sales by region, and which region performs the best?
SELECT 
region,
SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- Which product categories and subcategories generate the highest and lowest profits?
SELECT category, sub_category, SUM(Profit) AS Net_profit
FROM sales
GROUP BY category, sub_category
ORDER BY category, Net_profit DESC;


-- How do sales and profits vary across different customer segments?
SELECT segment, 
SUM(Sales) AS Total_sales, 
SUM(Profit) AS Total_profits
FROM sales
GROUP BY segment;

-- What percentage of total orders were returned?
SELECT COUNT(sales_record),
 (SELECT COUNT(sales_record) FROM sales WHERE Returns != "No") AS Returned_orders,
ROUND((SELECT COUNT(sales_record) FROM sales WHERE Returns != "No")/COUNT(sales_record) * 100, 2) AS return_percentage
FROM sales;



-- What are the monthly and yearly sales trends, and are there any seasonal patterns?
SELECT MONTH(Order_Date) AS order_month, COUNT(Sales_record) AS total_sales
FROM sales
GROUP BY MONTH(Order_Date)
ORDER BY MONTH(Order_Date);

SELECT YEAR(Order_Date) AS order_year, COUNT(Sales_record) AS total_sales
FROM sales
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);

-- Which shipping mode is most commonly used, and how often are there returns?

SELECT Ship_Mode,
	  COUNT(sales_record) AS total_sales,
      SUM(CASE WHEN Returns = 'Yes' THEN 1 ELSE 0 END) AS Total_Returns
FROM sales
-- WHERE Returns = "Yes"
GROUP BY Ship_Mode;

-- Which states have the highest and lowest sales, and what factors contribute to these differences?
SELECT State,
	   COUNT(Sales_record) AS Total_order
FROM sales
GROUP BY State
ORDER BY Total_order DESC;

SELECT State,
	   COUNT(Sales_record) AS Total_order
FROM sales
GROUP BY State
ORDER BY Total_order ASC;

SELECT State,
	   COUNT(Sales_record) AS Total_order
FROM sales
GROUP BY State
ORDER BY Total_order ASC
LIMIT 20 offset 10;

-- Which products are the top-selling items in terms of quantity and revenue?
SELECT Product_ID,
	   Product_Name,
	   SUM(Quantity) AS Total_order
FROM sales
GROUP BY Product_ID, Product_Name
ORDER BY Total_order DESC;

SELECT Product_ID,
	   Product_Name,
       SUM(Quantity) AS Total_count,
	   SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Product_ID, Product_Name
ORDER BY Total_Sales DESC;

-- Who are the top customers based on total spending, and what are their purchasing behaviors?
SELECT Customer_ID,
	   Customer_Name,
       -- SUM(Quantity) AS Total_count,
	   SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC;

SELECT Customer_ID,
	   Customer_Name,
       Product_Name,
       SUM(Quantity) AS Total_count,
	   SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Customer_ID, Customer_Name, Product_Name
ORDER BY Customer_Name;

-- What payment methods are most frequently used, and do they correlate with any specific customer demographics or regions?
SELECT 
    Payment_Mode, 
    COUNT(Sales_record) AS Frequency, 
    Region, 
    Segment
FROM sales
GROUP BY Payment_Mode, Region, Segment
ORDER BY Region, Frequency DESC;

-- How long is the average shipping time, and does it vary by region or product category?
SELECT 
    Region, 
    Category, 
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date))) AS Avg_Shipping_Time
FROM sales
GROUP BY Region, Category
ORDER BY Avg_Shipping_Time;

-- Question 13: Is there a correlation between the region and profitability, and if so, what drives this relationship?
SELECT 
    Region, 
    SUM(Profit) AS Total_Profit, 
    SUM(Sales) AS Total_Sales, 
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM SALES
GROUP BY Region
ORDER BY Total_Profit DESC;

-- How do returns affect total sales and profit, and are there certain products or categories with higher return rates?
SELECT 
    Category, 
    COUNT(CASE WHEN Returns = 'Yes' THEN 1 END) AS Total_Returns, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Category
ORDER BY Total_Returns DESC;

SELECT 
    Product_Name, 
    COUNT(CASE WHEN Returns = 'Yes' THEN 1 END) AS Return_Count, 
    SUM(Sales) AS Sales, 
    SUM(Profit) AS Profit
FROM sales
WHERE Returns = 'Yes'
GROUP BY Product_Name
ORDER BY Return_Count DESC;

-- Based on historical sales data, what can be predicted for future sales trends in the next quarter or year?

SELECT 
    YEAR(Order_Date) AS Year, 
    QUARTER(Order_Date) AS Quarter, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
