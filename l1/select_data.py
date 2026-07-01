import mysql.connector

connection = mysql.connector.connect(
    host='localhost',
    port='3306',
    user='root',
    password='11sodium',
    database='sql_tutorial'
)

cursor = connection.cursor()

# 取得全部表所有资料
cursor.execute('SELECT * FROM `branch`;')

records = cursor.fetchall()
for r in records:
    print(r)

cursor.close()
connection.close()