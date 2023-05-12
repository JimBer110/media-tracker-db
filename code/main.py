from database_handler import DB_handler
import media_data_loader
from flask import Flask, request
from flask import render_template
import random


database = DB_handler()

database.setup_tables()

tmp_data = media_data_loader.read_media_data()

database.insert_media_data(tmp_data)

app = Flask(__name__)


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/database")
def view_database():
    stringbuilder = "<table>"
    for i in range(50):
        stringbuilder += "<tr><td>" + \
            str(i)+"</td><td>"+str(random.randint(0, 1000000))+"</td></tr>"
    stringbuilder += "</table>"

    return stringbuilder


@app.route("/register")
def register():
    return render_template("register.html")


@app.route("/api/register", methods=["POST"])
def api_register():

    data = {}

    data["user"] = request.form["userInput"]
    data["pass"] = request.form["passwordInput"]
    data["email"] = request.form["emailInput"]
    data["dob"] = request.form["dateInput"]

    database.register_user(data)

    return "Hello World"


app.run()
