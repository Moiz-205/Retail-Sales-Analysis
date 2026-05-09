import plotly.express as px

def chart_sales_by_category(df):
    return px.bar(df,
        x="Sub_Category",
        y="Total_Sales",
        color="Category",
        title="Sales by Category")

def chart_profit_by_category(df):
    return px.bar(df,
        x="Sub_Category",
        y="Total_Profit",
        color="Category",
        title="Profit by Category")

def chart_sales_trends(df):
    df["Order_Year"] = df["Order_Year"].astype(str)
    return px.line(df,
        x="Order_Month",
        y="Total_Sales",
        color="Order_Year",
        title="Sales Trend")

def chart_regional_sales_performance(df):
    return px.bar(df,
        x="Region",
        y="Total_Sales",
        color="Average_Profit_Margin",
        title="Regional Sales Performance")

def chart_regional_profit_performance(df):
    return px.bar(df,
        x="Region",
        y="Total_Profit",
        color="Average_Profit_Margin",
        title="Regional Profit Performance")

def chart_top_customers(df):
    return px.bar(df,
        x="Total_Sales",
        y="Customer_Name",
        color="Total_Profit",
        orientation="h",
        title="Top Customers")

def chart_rfm(df):
    return px.scatter(df,
        x="Recency",
        y="Total_Sales",
        color="Customer_Segment",
        size="Total_Orders",
        hover_name="Customer_Name",
        title="RFM Analysis")

def chart_delivery_performance(df):
    return px.bar(df,
        x="Ship_Mode",
        y="Average_Delivery_Days",
        color="Ship_Mode",
        title="Delivery Performance")
