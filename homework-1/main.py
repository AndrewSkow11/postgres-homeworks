"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import csv

conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='99-100'
)


def read_from_csv_file(filename):
    tuple_of_rows = []

    with open(filename, 'r') as f:
        read_csv = csv.reader(f)

        for row in read_csv:
            tuple_of_rows.append(tuple(row))

    return tuple_of_rows


# без контекстного менеджера
# срезаем первую строку с заголовками
customers_data = read_from_csv_file('north_data/customers_data.csv')[1:]
employees_data = read_from_csv_file('north_data/employees_data.csv')[1:]
orders_data = read_from_csv_file('north_data/orders_data.csv')[1:]

# создаём курсор
cur = conn.cursor()

cur.executemany(f"INSERT INTO customers_data VALUES (%s, %s, %s)",
                customers_data)
cur.executemany(
    f"INSERT INTO employees_data VALUES (%s, %s, %s, %s, %s, %s)",
    employees_data)
cur.executemany("INSERT INTO orders_data VALUES (%s, %s, %s, %s, %s)",
                orders_data)

conn.commit()
cur.close()
conn.close()
