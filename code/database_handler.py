import mysql.connector
import hashlib


class DB_handler:

    def __init__(self):

        lines = []
        password = ""
        host = ""
        user = ""
        self.database = ""

        try:
            with open("config.conf", "r") as f:
                lines = f.readlines()
        except Exception as e:
            print(e)
            exit()

        for i in lines:
            if i.split("=")[0] == "pass":
                password = i.split("=")[1].replace("\n", "")
            if i.split("=")[0] == "host":
                host = i.split("=")[1].replace("\n", "")
            if i.split("=")[0] == "user":
                user = i.split("=")[1].replace("\n", "")
            if i.split("=")[0] == "database":
                self.database = i.split("=")[1].replace("\n", "")

        # Connect to the database
        try:
            self.session = mysql.connector.connect(
                host=host,
                user=user,
                password=password
            )

        except Exception as e:
            print(e)
            exit()

        # Try to create database if not exists
        cursor = self.session.cursor()

        query = "CREATE DATABASE IF NOT EXISTS %s;" % (self.database)

        cursor.execute(query)

        cursor.execute("USE %s;" % (self.database))

        self.session.commit()

        cursor.close()

    def __del__(self):

        # Cleanup
        self.session.close()

    def create_table(self, table_name, properties):

        _primary_key = ""
        _foreign_key = []

        query = "CREATE TABLE IF NOT EXISTS %s (" % (table_name)

        for i in range(len(properties)):

            query += properties[i][0] + " " + properties[i][1] + " "

            for j in range(2, len(properties[i])):

                if properties[i][j] == "PRIMARY KEY":
                    _primary_key = properties[i][0]
                elif properties[i][j].split("(")[0] == "FOREIGN KEY":
                    _foreign_key.append(
                        (properties[i][0], properties[i][j].split("(")[1][:-1]))
                else:
                    query += properties[i][j]

                    query += " "

            query = query.strip()

            if i != len(properties)-1:
                query += ", "

        if _primary_key:
            query += ", PRIMARY KEY (%s)" % _primary_key

        if _foreign_key:

            for i in range(len(_foreign_key)):

                query += ", FOREIGN KEY ({0}) REFERENCES {1}({0})".format(
                    _foreign_key[i][0], _foreign_key[i][1])

        query += ");"

        cursor = self.session.cursor()

        cursor.execute(query)

        self.session.commit()

        cursor.close()

    def setup_tables(self):

        table_name = "Media"
        properties = [("MediaID", "INT", "NOT NULL", "AUTO_INCREMENT", "PRIMARY KEY"),
                      ("Episodes", "INT"),
                      ("Description", "TEXT"),
                      ("Title", "TEXT"),
                      ("Year", "INT")]

        self.create_table(table_name, properties)

        table_name = "Users"
        properties = [("UserID", "INT", "NOT NULL", "AUTO_INCREMENT", "PRIMARY KEY"),
                      ("Username", "VARCHAR(25)"),
                      ("Email", "TEXT"),
                      ("Password", "VARCHAR(128)"),
                      ("DOB", "DATE")]

        self.create_table(table_name, properties)

        table_name = "Genre"
        properties = [("GenreID", "INT", "NOT NULL", "AUTO_INCREMENT", "PRIMARY KEY"),
                      ("Description", "TEXT"),
                      ("Name", "VARCHAR(50)")]

        self.create_table(table_name, properties)

        table_name = "UsersMedia"
        properties = [("UsersMediaID", "INT", "NOT NULL", "AUTO_INCREMENT", "PRIMARY KEY"),
                      ("MediaID", "INT", "FOREIGN KEY(Media)"),
                      ("UserID", "INT", "FOREIGN KEY(Users)"),
                      ("Status", "TINYINT"),
                      ("CurrentEp", "INT"),
                      ("Rating", "TINYINT")]

        self.create_table(table_name, properties)

        table_name = "MediaGenre"
        properties = [("MediaGenreID", "INT", "NOT NULL", "AUTO_INCREMENT", "PRIMARY KEY"),
                      ("MediaID", "INT", "FOREIGN KEY(Media)"),
                      ("GenreID", "INT", "FOREIGN KEY(Genre)")]

        self.create_table(table_name, properties)

    def register_user(self, user_data):

        username = user_data["user"]
        email = user_data["email"]

        password = hashlib.sha512(
            user_data["pass"].encode("ASCII")).hexdigest()

        dob = user_data["dob"]

        query = "INSERT INTO Users (Username, Email, Password, DOB) " + \
            "SELECT '{0}', '{1}', '{2}', '{3}' FROM Users WHERE Email = " + \
            "'{1}' HAVING COUNT(*) = 0;"

        query = query.format(username, email, password, dob)

        print(query)

        cursor = self.session.cursor()

        cursor.execute(query)

        self.session.commit()

        cursor.close()

    def login(self, user_data):

        email = user_data["email"]
        password = hashlib.sha512(
            user_data["pass"].encode("ASCII")).hexdigest()

        query = "SELECT EXISTS(SELECT * FROM Users WHERE Email " + \
            "= '{}' AND Password = '{}')".format(email, password)

        cursor = self.session.cursor()

        cursor.execute(query)

        flag = False
        if cursor.fetchone()[0]:
            flag = True

        cursor.close()

        if flag:
            return "Logged in"

        return "User does not exist"

    def insert_media_data(self, data):

        cursor = self.session.cursor()

        for i in range(len(data)):

            for j in range(len(data[i])):
                data[i][j] = data[i][j].replace("'", "''")

            query = "INSERT INTO Media (Title, Year, Episodes, Description" + \
                ") SELECT '{0}', {1}, {2}, '{3}' FROM Media WHERE Title = " + \
                "'{0}' AND Year = {1} HAVING COUNT(*) = 0;"

            query = query.format(data[i][0], data[i]
                                 [1], data[i][2], data[i][3])

            cursor.execute(query)

        self.session.commit()

        cursor.close()
