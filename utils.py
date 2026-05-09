import pandas as pd
from db import engine

def load_kpis() -> dict[str, float]:
    df = pd.read_sql_query("SELECT \
                            ROUND(SUM(Sales), 2) AS Total_Sale, \
                            ROUND(SUM(Profit), 2) AS Total_Profit, \
                            COUNT(Order_ID) AS Total_Orders, \
                            AVG(Delivery_Days) AS Avg_Delivery_Days\
                            FROM superstore", engine)
    kpi = {
        "Total Sales": df["Total_Sale"].iloc[0],
        "Total Profit": df["Total_Profit"].iloc[0],
        "Total Orders": df["Total_Orders"].iloc[0],
        "Average Delivery Days": df["Avg_Delivery_Days"].iloc[0]
    }
    return kpi

def load_view(view_label: str) -> pd.DataFrame:
    df = pd.read_sql_query(f"SELECT * FROM {view_label}", engine)
    return df
