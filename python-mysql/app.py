import pandas as pd
import numpy as np
import mysql.connector as msql
from mysql.connector import Error
from config import host, user, password, db_name

df = pd.read_csv('athlete_events.zip', compression='zip')
df = df.fillna(0)
# Меня значения NA на 0, т.к. при загрузки в базу данных NA в ячейка с типом данных INT выдает ошибку


# Создаем новую базу данных a_events

try:
    conn = msql.connect(host = host, user = user,  
                        password = password)
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE a_events")
        print("Database is created")
except Error as e:
    print("Error while connecting to MySQL", e)

# Создаем таблицу 

try:
    conn = msql.connect(host = host, database = db_name, user = user, password = password)
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)
        cursor.execute('DROP TABLE IF EXISTS athlete_events;')
        print('Creating table....')
# Добавляем необходимые столбцы
        cursor.execute("CREATE TABLE athlete_events(ID int, Name text, Sex text,\
                        Age int, Height int, Weight int, Team text, \
                        NOC text, Games text, Year int, Season text, \
                        City text, Sport text, Event text, Medal text)") 
        print("Table is created....")
        for i,row in df.iterrows():
            sql = "INSERT INTO a_events.athlete_events VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(sql, tuple(row))
            print("Record inserted")
            # сохраняем наши изменения
            conn.commit()
        print('Uploading is done')
except Error as e:
            print("Error while connecting to MySQL", e)
