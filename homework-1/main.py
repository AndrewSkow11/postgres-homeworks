"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import csv


# подключение к базе данных
conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='99-100'
)
#
# # получение данных из csv файлов в виде кортежей
#
# # create cursor
# cur = conn.cursor()
#
# #execute query
# cur.executemany("INSERT INTO user_account VALUES (%s, %s)", [(5, 'Terry'), (6, 'James')])
# cur.execute("SELECT * FROM user_account")
# conn.commit()
#
# rows = cur.fetchall()
# for row in rows:
#     print(row)
#
# cur.close()
# conn.close()






def read_from_csv_file(filename):
    tuple_of_rows = []

    with open(filename, 'r') as f:
        read_csv = csv.reader(f)

        for row in read_csv:
            tuple_of_rows.append(tuple(row))

    return tuple_of_rows

# срезаем первую строку с заголовками
customers_data = read_from_csv_file('north_data/customers_data.csv')[1:]
employees_data = read_from_csv_file('north_data/employees_data.csv')[1:]
orders_data = read_from_csv_file('north_data/orders_data.csv')[1:]


cur = conn.cursor()

for row in customers_data:
    cur.execute(f"INSERT INTO customers_data VALUES (%s, %s, %s)", row)

for row in employees_data:
    cur.execute(f"INSERT INTO employees_data VALUES (%s, %s, %s, %s, %s, %s)", row)

cur.executemany("INSERT INTO orders_data VALUES (%s, %s, %s, %s, %s)", orders_data)

conn.commit()

cur.close()
conn.close()
