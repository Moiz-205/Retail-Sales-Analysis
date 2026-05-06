RENAME TABLE superstore_raw TO superstore;

ALTER TABLE superstore
RENAME COLUMN `Row ID` TO Row_ID,
RENAME COLUMN `Order ID` TO Order_ID,
RENAME COLUMN `Order Date` TO Order_Date,
RENAME COLUMN `Ship Date` TO Ship_Date,
RENAME COLUMN `Ship Mode` TO Ship_Mode,
RENAME COLUMN `Customer ID` TO Customer_ID,
RENAME COLUMN `Customer Name` TO Customer_Name,
RENAME COLUMN `Postal Code` TO Postal_Code,
RENAME COLUMN `Product ID` TO Product_ID,
RENAME COLUMN `Sub-Category` TO Sub_Category,
RENAME COLUMN `Product Name` TO Product_Name;

ALTER TABLE superstore
ADD COLUMN Order_Date_New DATE,
ADD COLUMN Ship_Date_New DATE;

UPDATE superstore SET Order_Date_New =
STR_TO_DATE(Order_Date, '%m/%d/%Y');

UPDATE superstore SET Ship_Date_New =
STR_TO_DATE(Ship_Date, '%m/%d/%Y');

ALTER TABLE superstore
DROP COLUMN Order_Date,
DROP COLUMN Ship_Date;

ALTER TABLE superstore
RENAME COLUMN Order_Date_New TO Order_Date,
RENAME COLUMN Ship_Date_New TO Ship_Date;

ALTER TABLE superstore
MODIFY COLUMN Order_Date DATE
AFTER Order_ID,
MODIFY COLUMN Ship_Date DATE
AFTER Order_Date;

ALTER TABLE superstore
DROP COLUMN Row_ID,
DROP COLUMN Postal_Code;
