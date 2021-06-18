from flask import Flask, redirect
from flask import render_template
from flask import request
import psycopg2

t_host = "127.0.0.1"
t_port = "5432"
t_dbname = "postgres"
t_name_user = "postgres"
t_password = "190101"
db_conn = psycopg2.connect(host=t_host, port=t_port, dbname=t_dbname, user=t_name_user, password=t_password)
db_cursor = db_conn.cursor()

app = Flask(__name__)


def create_driver(id, name, address, number, passport, category):
    s = f'''INSERT INTO public.driver(
    id_driver, driver_name, driver_address, driver_phone_number, driver_passport, category)
	VALUES ({id}, \'{name}\', \'{address}\', \'{number}\', \'{passport}\', \'{category}\');'''
    db_cursor.execute(s)

def create_car(id, mileage, ti, year, gos, id_model):
    s = f'''INSERT INTO public.car(
	id_car, car_mileage, "date_of_TI", car_year, gos_number, id_model)
	VALUES ({id}, {mileage}, \'{ti}\', {year}, \'{gos}\', {id_model});'''
    db_cursor.execute(s)

def create_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff):
    s = f'''INSERT INTO public.taxi_call(
	end_time, call_date, start_time, distance, "from", where_to, id_taxi_call, id_worker, id_car, id_passenger, id_tariff)
	VALUES (\'{end}\', \'{date}\', \'{start}\', {distance}, \'{from_}\', \'{where}\', {id}, {id_worker}, {id_car}, {id_passenger}, {id_tariff});'''
    db_cursor.execute(s)

def select_driver(t_schema):
    s = f'''SELECT *
	FROM public.driver;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_passenger(t_schema):
    s = f'''SELECT *
	FROM public.passenger;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_car(t_schema):
    s = f'''SELECT *
	FROM public.car
    ORDER BY id_car;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_model(t_schema):
    s = f'''SELECT *
	FROM public.model;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_period(t_schema):
    s = f'''SELECT *
	FROM public.period;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_tariff(t_schema):
    s = f'''SELECT *
	FROM public.tariff;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_taxi_call(t_schema):
    s = f'''SELECT *
    FROM public.taxi_call;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def select_worker(t_schema):
    s = f'''SELECT *
	FROM public.worker;'''
    db_cursor.execute(s)
    return db_cursor.fetchall()

def update_car(id, mileage, ti, year, gos, id_model):
    s = f'''UPDATE public.car
	SET car_mileage={mileage}, "date_of_TI"=\'{ti}\', car_year={year}, gos_number=\'{gos}\', id_model={id_model}
	WHERE id_car={id};'''
    db_cursor.execute(s)

def delete_car(id):
    s = f'''DELETE FROM public.car
	WHERE id_car={id};'''
    db_cursor.execute(s)

def update_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff):
    s = f'''UPDATE public.taxi_call
	SET end_time=\'{end}\', call_date=\'{date}\', start_time=\'{start}\', distance={distance}, "from"=\'{from_}\', where_to=\'{where}\', id_worker={id_worker}, id_car={id_car}, id_passenger={id_passenger}, id_tariff={id_tariff}
	WHERE id_taxi_call={id};'''
    db_cursor.execute(s)

def delete_taxi_call(id):
    s = f'''DELETE FROM public.taxi_call
	WHERE id_taxi_call={id};'''
    db_cursor.execute(s)


@app.route("/", methods=["POST","GET"])
def Main():

    t_action = request.args.get("t_action", "")
    t_name_table = request.args.get("t_name_table", "")

    t_schema = "public"
    drivers_tables = select_driver(t_schema)
    cars_tables = select_car(t_schema)
    taxi_calls_tables = select_taxi_call(t_schema)
    car_models = select_model(t_schema)
    workers = select_worker(t_schema)
    cars = select_car(t_schema)
    passengers = select_passenger(t_schema)
    tariffs = select_tariff(t_schema)

    get_driver_categories = f'''SELECT DISTINCT category
    FROM public.driver'''
    db_cursor.execute(get_driver_categories)
    driver_categories_tuple = db_cursor.fetchall()
    driver_categories = []
    for item in driver_categories_tuple:
        driver_categories.append(item[0].replace(' ', ''))

    select_model(t_schema)

    t_url = "http://127.0.0.1:5000/"

    return render_template("ws.html", **locals())


@app.route("/add_taxi_call", methods=["POST","GET"])
def add_taxi_call():
    if request.method == 'POST':
        get_id_request = f'''SELECT id_taxi_call
        FROM public.taxi_call
        ORDER BY id_taxi_call DESC
        LIMIT 1'''

        db_cursor.execute(get_id_request)

        id = db_cursor.fetchall()
        id = id[0][0] + 1

        end = request.form.get('end')
        date = request.form.get('date')
        start = request.form.get('start')
        distance = request.form.get('distance')
        from_ = request.form.get('from_')
        where = request.form.get('where')
        id_worker = request.form.get('id_worker')
        id_car = request.form.get('id_car')
        id_passenger = request.form.get('id_passenger')
        id_tariff = request.form.get('id_tariff')

        create_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff)

    return redirect('/')


@app.route("/add_driver", methods=["POST","GET"])
def add_driver():
    if request.method == 'POST':
        get_id_request = f'''SELECT id_driver
        FROM public.driver
        ORDER BY id_driver DESC
        LIMIT 1'''

        db_cursor.execute(get_id_request)

        id = db_cursor.fetchall()
        id = id[0][0] + 1

        name = request.form.get('name')
        address = request.form.get('address')
        number = request.form.get('number')
        passport = request.form.get('passport')
        category = request.form.get('category')

        create_driver(id, name, address, number, passport, category)

    return redirect('/')

@app.route("/add_car", methods=["POST","GET"])
def add_car():
    if request.method == 'POST':
        get_id_request = f'''SELECT id_car
        FROM public.car
        ORDER BY id_car DESC
        LIMIT 1'''

        db_cursor.execute(get_id_request)

        id = db_cursor.fetchall()
        print(id)

        id = id[0][0] + 1

        mileage = request.form.get('mileage')
        ti = request.form.get('ti')
        year = request.form.get('year')
        gos = request.form.get('gos')
        id_model = request.form.get('id_model')

        create_car(id, mileage, ti, year, gos, id_model)

    return redirect('/')

@app.route("/update_car", methods=["POST","GET"])
def update_info_car():
    if request.method == 'POST':
        id = request.form.get('id_car')
        mileage = request.form.get('mileage')
        ti = request.form.get('ti')
        year = request.form.get('year')
        gos = request.form.get('gos')
        id_model = request.form.get('id_model')

        update_car(id, mileage, ti, year, gos, id_model)

    return redirect('/')

@app.route("/delete_car", methods=["POST","GET"])
def delete_info_car():
    if request.method == 'POST':
        id = request.form.get('id_car')

        delete_car(id)

    return redirect('/')

@app.route("/update_taxi_call", methods=["POST","GET"])
def update_info_taxi_call():
    if request.method == 'POST':
        id = request.form.get('id_taxi_call')
        end = request.form.get('end')
        date = request.form.get('date')
        start = request.form.get('start')
        distance = request.form.get('distance')
        from_ = request.form.get('from_')
        where = request.form.get('where')
        id_worker = request.form.get('id_worker')
        id_car = request.form.get('id_car')
        id_passenger = request.form.get('id_passenger')
        id_tariff = request.form.get('id_tariff')

        update_taxi_call(end, date, start, distance, from_, where, id, id_worker, id_car, id_passenger, id_tariff)

    return redirect('/')

@app.route("/delete_taxi_call", methods=["POST","GET"])
def delete_info_taxi_call():
    if request.method == 'POST':
        id = request.form.get('id_taxi_call')

        delete_taxi_call(id)

    return redirect('/')


app.run(debug=True, use_reloader=False)
