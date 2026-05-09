import streamlit as st
from utils import load_kpis, load_view
from charts import (
    chart_sales_by_category, chart_profit_by_category, chart_sales_trends,
    chart_regional_sales_performance, chart_regional_profit_performance,
    chart_top_customers, chart_rfm, chart_delivery_performance
)

st.set_page_config(page_title="Retail Sales Analysis Dashboard", layout="wide")
st.title("Retail Sale Analysis Dashboard", text_alignment="center")

## KPI Row
kpis = load_kpis()
col1, col2, col3, col4 = st.columns(4)
col1.metric("Total Sales", kpis["Total Sales"])
col2.metric("Total Profit", kpis["Total Profit"])
col3.metric("Total Orders", kpis["Total Orders"])
col4.metric("Average Delivery Days", kpis["Average Delivery Days"])

st.markdown("""
    <style>
    .stTabs [data-baseweb="tab-list"] {
        justify-content: center;
    }
    </style>
""", unsafe_allow_html=True)
tab1, tab2, tab3, tab4 = st.tabs(["Sales Analysis", "Regional Performance", "Customers", "Operations"])

with tab1:
    df = load_view("Sales_by_Category_View")
    col1, col2 = st.columns(2)
    with col1:
        st.plotly_chart(chart_sales_by_category(df))
    with col2:
        st.plotly_chart(chart_profit_by_category(df))

    df = load_view("Sales_Trend_Over_Time_View")
    st.plotly_chart(chart_sales_trends(df))

with tab2:
    df = load_view("Regional_Performance_View")
    col1, col2 = st.columns(2)
    with col1:
        st.plotly_chart(chart_regional_sales_performance(df))
    with col2:
        st.plotly_chart(chart_regional_profit_performance(df))

with tab3:
    df = load_view("Top_Customers_View")
    st.plotly_chart(chart_top_customers(df))

    df = load_view("RFM_Analysis_View")
    st.plotly_chart(chart_rfm(df))
    # st.dataframe(df)

with tab4:
    df = load_view("Delivery_Performance_View")
    st.plotly_chart(chart_delivery_performance(df))
