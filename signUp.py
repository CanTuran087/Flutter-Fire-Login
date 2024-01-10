from flask import Flask, request, jsonify
import pypyodbc
import subprocess
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime

cred = credentials.Certificate("C:/Users/pc/Desktop/login/PYTHON/login-firebase-adminsdk-rc689-59f39ebfdc.json")
firebase_admin.initialize_app(cred)

app = Flask(__name__)

# SQL Server bağlantı ayarları
s = 'CAN'
d = 'LOGINDATABASE'
u = ''
p = ''

@app.route('/add_user', methods=['GET', 'POST'])
def add_user():
    try:
        username = request.args.get('USERNAME')
        password = request.args.get('PASSWORD')
        name = request.args.get('NAME')
        name2 = request.args.get('NAME2')
        surname = request.args.get('SURNAME')
        email = request.args.get('EMAIL')
        createdby = request.args.get('CREATEDBY')
        changedby = request.args.get('CHANGEDBY')

        conn = pypyodbc.connect(
            'Driver={SQL Server};Server='+s+';Database='+d+';uid='+u+';pwd='+p+'')

        cursor = conn.cursor()
        cursor.execute("INSERT INTO LOGIN (user_id, USERNAME, PASSWORD, NAME, NAME2, SURNAME, EMAIL, CREATEDBY, CREATEDAT, CHANGEDBY, CHANGEDAT) VALUES (NEWID(), ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, GETDATE())",
                       (username, password, name, name2, surname, email, createdby, changedby))
        conn.commit()

        if cursor.rowcount > 0:
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

            conn.close()

            db = firestore.client()
            collection_ref = db.collection('LOGIN') 

            # Firestore'a veri ekleyin
            for entry in data:
                user_id = entry['user_id']
                collection_ref.document(user_id).set(entry)

            print("Veriler başarıyla Firebase'e gönderildi.")

            return jsonify({"message": "Success"}), 201
        else:
            return jsonify({"error": "Veri eklenirken bir hata oluştu"}), 500

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(port=8080)
