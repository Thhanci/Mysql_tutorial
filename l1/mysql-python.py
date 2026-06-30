import mysql.connector
connection = mysql.connector.connect(
    host="localhost",   #mysql位置
    port='3306',    #连接的通道
    user="root",
    passwd="11sodium",
)
cursor = connection.cursor()