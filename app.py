import streamlit as st
from utils import load_kpis, load_view
from charts import chart_sales_by_category, chart_profit_by_category

st.set_page_config(page_title="Retail Sales Analysis Dashboard", layout="wide")
st.write("Retail Sale Analysis Dashboard")

## KPI Row
kpis = load_kpis()
col1, col2, col3, col4 = st.columns(4)
col1.metric("Total Sales", kpis["Total Sales"])
col2.metric("Total Profit", kpis["Total Profit"])
col3.metric("Total Orders", kpis["Total Orders"])
col4.metric("Average Delivery Days", kpis["Average Delivery Days"])

tab1, tab2, tab3, tab4 = st.tabs(["Sales Analysis", "Regional", "Customers", "Operations"])

with tab1:
    df = load_view("Sales_by_Category_View")
    st.plotly_chart(chart_sales_by_category(df))
    st.plotly_chart(chart_profit_by_category(df))
