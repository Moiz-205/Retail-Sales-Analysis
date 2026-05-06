import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

engine = create_engine(
    f"mysql+pymysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
)

df = pd.read_csv("data/superstore.csv", encoding='latin-1')
df.to_sql('superstore_raw', engine, if_exists='replace', index=False)
