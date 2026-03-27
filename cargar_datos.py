import pandas as pd
from sqlalchemy import create_engine

# Leer CSV
df = pd.read_csv("ucimlrepo.csv")

print("Filas cargadas:", df.shape)

# Crear base local (NO necesitas MySQL)
engine = create_engine("sqlite:///students.db")

# Guardar tabla
df.to_sql("students_raw", con=engine, if_exists="replace", index=False)

print("✅ Datos cargados correctamente en SQLite")

from sqlalchemy import create_engine
import pandas as pd

engine = create_engine("sqlite:///students.db")

df = pd.read_sql("SELECT * FROM students_raw LIMIT 5", engine)

print(df)

df_count = pd.read_sql("SELECT COUNT(*) FROM students_raw", engine)
print(df_count)
df_group = pd.read_sql("""
                       
SELECT course, COUNT(*) as total
FROM students_raw
GROUP BY course
""", engine)

print(df_group)

