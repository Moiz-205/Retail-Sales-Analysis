CREATE VIEW Sales_by_Category_View AS
SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Category, Sub_Category
ORDER BY Category, Total_Sales DESC;

CREATE VIEW Sales_Trend_Over_Time_View AS
SELECT
    Order_Year, Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

CREATE VIEW Regional_Performance_View AS
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit_Margin), 2) AS Average_Profit_Margin
FROM superstore
GROUP BY Region
ORDER BY Region;

CREATE VIEW Top_Customers_View AS
SELECT
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

CREATE VIEW Delivery_Performance_View AS
SELECT
    Ship_Mode,
    ROUND(AVG(Delivery_Days), 2) AS Average_Delivery_Days,
    MIN(Delivery_Days) AS Min_Delivery_Days,
    MAX(Delivery_Days) AS Max_Delivery_Days
FROM superstore
GROUP BY Ship_Mode
ORDER BY Average_Delivery_Days DESC;

SELECT
    Customer_Name,
    MAX(Order_Date) AS Max_Order_Date,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    DATEDIFF((SELECT MAX(Order_Date) FROM superstore), MAX(Order_Date)) AS Recency
FROM superstore
GROUP BY Customer_Name;

CREATE VIEW RFM_Analysis_View AS
WITH rfm_base AS (
    SELECT
        Customer_Name,
        MAX(Order_Date) AS Max_Order_Date,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        DATEDIFF((SELECT MAX(Order_Date) FROM superstore), MAX(Order_Date)) AS Recency
    FROM superstore
    GROUP BY Customer_Name
),
rfm_scored AS (
    SELECT *,
        NTILE(3) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(3) OVER (ORDER BY Total_Orders ASC) AS F_Score,
        NTILE(3) OVER (ORDER BY Total_Sales ASC) AS M_Score
    FROM rfm_base
    )
SELECT *,
    R_Score + F_Score + M_Score AS RFM_Total,
    CASE
        WHEN R_Score + F_Score + M_Score = 9 THEN 'Regular'
        WHEN R_Score + F_Score + M_Score >= 7 THEN 'Loyal'
        WHEN R_Score + F_Score + M_Score >= 5 THEN 'At Risk'
        ELSE 'Lost'
    END AS Customer_Segment
FROM rfm_scored
ORDER BY RFM_Total DESC;
