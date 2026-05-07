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
