import mysql.connector


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

    def create_table(self, table_name):
        cursor = self.session.cursor()

        query = "CREATE TABLE IF NOT EXISTS %s (`id`" % (table_name) + \
            " int NOT NULL);"
        cursor.execute(query)

        self.session.commit()
        cursor.close()
