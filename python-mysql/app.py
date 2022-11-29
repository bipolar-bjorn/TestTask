import mysql.connector

server_config = {
    'user': 'my_user',
    'password': 'my_password',
    'host': '171.18.0.1',
    'database': 'db',
    'port': 3306,
}
conn = mysql.connector.connect(**server_config)
cursor = conn.cursor()

print('db has been connected')