from database_handler import DB_handler
import media_data_loader
from flask import Flask, request, redirect
from flask import render_template, make_response
import random


database = DB_handler()

tmp_data = media_data_loader.read_genre_data()
database.insert_genre_data(tmp_data)

tmp_data = media_data_loader.read_media_data()
database.insert_media_data(tmp_data)

app = Flask(__name__)


@app.route("/")
def index():

    cookies = request.cookies

    user_token = cookies.get("User_token")

    valid_token = False
    if (user_token):
        valid_token = database.check_validity_of_token(user_token)

    if (valid_token):

        media_list = database.get_media(user_token)

        return render_template("index.html", title="Test_Media", media_data=media_list)

        print(media_list)

    return render_template("index.html", title="Test")


@app.route("/media/<m_id>")
def display_media(m_id):

    data = database.get_media_info(m_id)

    r = render_template("media.html", data=data)

    return r


@app.route("/genre/<g_id>")
def display_genre(g_id):

    data = database.get_genre_info(g_id)

    r = render_template("genre.html", data=data)

    return r


@app.route("/register")
def register():
    return render_template("register.html")


@app.route("/login")
def login():
    r = render_template("login.html")

    return r


@app.route("/api/register", methods=["POST"])
def api_register():

    data = {}

    data["user"] = request.form["userInput"]
    data["pass"] = request.form["passwordInput"]
    data["email"] = request.form["emailInput"]
    data["dob"] = request.form["dateInput"]

    database.register_user(data)

    return redirect("/login")


@app.route("/api/login", methods=["POST"])
def api_login():

    data = {}

    data["email"] = request.form["emailInput"]
    data["pass"] = request.form["passwordInput"]

    response = database.login(data)

    r = redirect("/")

    cookie = "User_token="+response+"; Path=/"

    r.headers.set("Set-Cookie", cookie)

    return r


@app.route("/api/update_media_status", methods=["POST"])
def api_update_status():

    data = {}

    cookies = request.cookies

    data["user_token"] = cookies.get("User_token")
    data["current_ep"] = request.form["current_ep"]
    data["media"] = request.form["media_id"]

    database.update_media_user(data)

    r = redirect("/")

    return r


@app.route("/api/update_rating", methods=["POST"])
def api_update_rating():

    data = {}

    cookies = request.cookies

    data["user_token"] = cookies.get("User_token")
    data["rating"] = request.form["input_rating"]
    data["media"] = request.form["media_id"]

    database.update_rating(data)

    return redirect("/")


app.run()
