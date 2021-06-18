import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


def create_driver(id, name, address, number, passport, category):
    request_sql = f'''INSERT INTO public.driver(
    id_driver, driver_name, driver_address, driver_phone_number, driver_passport, category)
	VALUES ({id}, {name}, {address}, {number}, {passport}, {category});'''

def create_passenger(id, number):
    request_sql = f'''INSERT INTO public.passenger(
	id_passenger, pass_phone_number)
	VALUES ({id}, {number});'''

def create_car(id, mileage, ti, year, gos, id_model):
    request_sql = f'''INSERT INTO public.car(
	id_car, car_mileage, "date_of_TI", car_year, gos_number, id_model)
	VALUES ({id}, {mileage}, {ti}, {year}, {gos}, {id_model});'''

def create_model(id, brand, model, spec):
    request_sql = f'''INSERT INTO public.model(
	id_model, name_brand, name_model, specifications)
	VALUES ({id}, {brand}, {model}, {spec});'''

def create_period(id, start, end, id_car, id_driver):
    request_sql = f'''INSERT INTO public.period(
	id_period, start_date, end_date, id_car, id_driver)
	VALUES ({id}, {start}, {end}, {id_car}, {id_driver});'''

def create_tariff(id, price, name):
    request_sql = f'''INSERT INTO public.tariff(
	id_tariff, price, tariff_name)
	VALUES ({id}, {price}, {name});'''

def create_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff):
    requesr_sql = f'''INSERT INTO public.taxi_call(
	end_time, call_date, start_time, distance, "from", where_to, id_taxi_call, id_worker, id_car, id_passenger, id_tariff)
	VALUES ({end}, {date}, {start}, {distance}, {from_}, {where}, {id}, {id_worker}, {id_car}, {id_passenger}, {id_tariff});'''

def create_worker(id, address, passport, name, number):
    request_sql = f'''INSERT INTO public.worker(
	id_worker, worker_address, worker_passport, worker_name, worker_phone_number)
	VALUES ({id}, {address}, {passport}, {name}, {number});'''


def select_driver(id, name, address, number, passport, category):
    r = f'''SELECT {id}, {name}, {address}, {number}, {passport}, {category}
	FROM public.driver;'''

def select_passenger(id, number):
    request_sql = f'''SELECT {id_passenger}, {pass_phone_number}
	FROM public.passenger;'''

def select_car(id, mileage, ti, year, gos, id_model):
    request_sql = f'''SELECT {id}, {mileage}, {ti}, {year}, {gos}, {id_model}
	FROM public.car;'''

def select_model(id, brand, model, spec):
    request_sql = f'''SELECT {id}, {brand}, {model}, {spec}
	FROM public.model;'''

def select_period(id, start, end, id_car, id_driver):
    request_sql = f'''SELECT {id}, {start}, {end}, {id_car}, {id_driver}
	FROM public.period;'''

def select_tariff(id, price, name):
    request_sql = f'''SELECT {id}, {price}, {name}
	FROM public.tariff;'''

def select_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff):
    requesr_sql = f'''SELECT {end}, {date}, {start}, {distance}, {from_}, {where}, {id}, {id_worker}, {id_car}, {id_passenger}, {id_tariff}
    FROM public.taxi_call;'''

def select_worker(id, address, passport, name, number):
    request_sql = f'''SELECT {id}, {address}, {passport}, {name}, {number}
	FROM public.worker;'''


try:
    # Подключение к существующей базе данных
    connection = psycopg2.connect(user="postgres",
                                  database="postgres",
                                  password="190101",
                                  host="127.0.0.1",
                                  port="5432")

    cursor = connection.cursor()

    create_table_query = '''SELECT * FROM public.free_dr '''
    # Выполнение команды: это создает новую таблицу
    cursor.execute(create_table_query)
    record = cursor.fetchall()

    print("asd", record)

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)
finally:
    if connection:
        cursor.close()
        connection.close()
        print("Соединение с PostgreSQL закрыто")
