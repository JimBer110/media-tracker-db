from database_handler import DB_handler
from flask import Flask
from flask import render_template
import random


tmp = DB_handler()

tmp.setup_tables()

del tmp

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


app.run()
