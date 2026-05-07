ALTER TABLE superstore
ADD COLUMN Delivery_Days INT,
ADD COLUMN Profit_Margin DECIMAL(10,2),
ADD COLUMN Order_Year YEAR,
ADD COLUMN Order_Month INT,
ADD COLUMN Order_Quarter INT,
ADD COLUMN Discount_Impact VARCHAR(10),
ADD COLUMN Revenue_Band VARCHAR(10);

UPDATE superstore SET Delivery_Days =
DATEDIFF(Ship_Date, Order_Date);

UPDATE superstore SET Profit_Margin =
(Profit / Sales) * 100;

UPDATE superstore SET Order_Year =
YEAR(Order_Date);

UPDATE superstore SET Order_Month =
MONTH(Order_Date);

UPDATE superstore SET Order_Quarter =
QUARTER(Order_Date);

UPDATE superstore SET Discount_Impact =
CASE WHEN Discount = 0 THEN 'None'
    WHEN Discount <= 0.25 THEN 'Low'
    WHEN Discount <= 0.50 THEN 'Medium'
    ELSE 'High'
END;

UPDATE superstore SET Revenue_Band =
CASE WHEN Sales < 100 THEN 'Low'
    WHEN Sales < 500 THEN 'Medium'
    WHEN Sales < 1000 THEN 'High'
    WHEN Sales >= 1000 THEN 'Very High'
    ELSE 'None'
END;
