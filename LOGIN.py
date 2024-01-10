import pypyodbc
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime
from flask import Flask

cred = credentials.Certificate("C:/Users/pc/Desktop/login/PYTHON/login-firebase-adminsdk-rc689-59f39ebfdc.json")
firebase_admin.initialize_app(cred)

# MSSQL veritabanına bağlanma
s = 'CAN'
d = 'LOGINDATABASE'
u = ''
p = ''

conn = pypyodbc.connect(
    'Driver={SQL Server};Server='+s+';Database='+d+';uid='+u+';pwd='+p+'')
cursor = conn.cursor()

# Verileri çekme
data = []

cursor.execute('SELECT * FROM LOGIN')
rows = cursor.fetchall()

for row in rows:
    entry = {}
    for column in cursor.description:
        column_name = column[0]
        column_value = row[column_name]
        
        # Tarih/saat verilerini ISO 8601 formatına çevirin (datetime'ı stringe çevirme)
        if isinstance(column_value, datetime.datetime):
            entry[column_name] = column_value.strftime('%Y-%m-%d %H:%M:%S')
        else:
            entry[column_name] = column_value

    data.append(entry)

# Bağlantıyı Kapat
conn.close()

# Verileri Firebase Firestore'a gönderme
db = firestore.client()
collection_ref = db.collection('LOGIN') 

# Firestore'a veri ekleyin
for entry in data:
    user_id = entry['user_id']
    collection_ref.document(user_id).set(entry)

print("Veriler başarıyla Firebase'e gönderildi.")
