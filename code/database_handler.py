import mysql.connector


class DB_handler:

    def __init__(self):

        lines = []
        password = ""
        host = ""
        user = ""

        try:
            with open("config.txt", "r") as f:
                lines = f.readlines()
        except Exception as e:
            exit()

        for i in lines:
            if i.split("=")[0] == "pass":
                password = i.split("=")[1]
            if i.split("=")[0] == "host":
                host = i.split("=")[1]
            if i.split("=")[0] == "user":
                user = i.split("=")[1]

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

    def __del__(self):

        # Cleanup
        self.session.close()

    def create_and_use_db(self, db_name):
        query = "CREATE TABLE IF NOT EXISTS %s" % (db_name)
        print(query)

    def cleanup(self):
        # This are some examples from the lab session use as examples

        database_name = "Test_databse"
        session = self.session

        cursor = self.session.cursor()

        def create_database():
            query = "CREATE DATABASE IF NOT EXISTS {};".format(database_name)
            cursor.execute(query)
            cursor.execute("USE {}".format(database_name))

            query = "CREATE TABLE IF NOT EXISTS `cars` (" \
                "  `car_id` int(11) NOT NULL AUTO_INCREMENT," \
                "  `brand` varchar(14) NOT NULL," \
                "  `model` varchar(14) NOT NULL," \
                "  `transmission` varchar(10) NOT NULL," \
                "  `model_year` SMALLINT NOT NULL," \
                "  `engine` varchar(14) NOT NULL," \
                "  `fuel` varchar(14) NOT NULL," \
                "  PRIMARY KEY (`car_id`)" \
                ") ENGINE=InnoDB"

            cursor.execute(query)
            session.commit()

        create_database()

        def insert_into_table():
            insert_sql = ["INSERT INTO cars (brand, model, transmission, model_year, engine, fuel)"
                          "VALUES ('BMW', '520D', 'Automatic', '2020', 'i4', 'Diesel');",
                          "INSERT INTO cars (brand, model, transmission, model_year, engine, fuel)"
                          "VALUES ('Audi', 'S6', 'Manual', '2021', 'v6', 'Petrol');",
                          "INSERT INTO cars (brand, model, transmission, model_year, engine, fuel)"
                          "VALUES ('Tesla', 'Model 3', 'Automatic', '2021', 'Dual Electric', 'Electric');",
                          "INSERT INTO cars (brand, model, transmission, model_year, engine, fuel)"
                          "VALUES ('Mercedes', 'E220', 'Automatic', '2021', 'i4', 'Diesel');"
                          ]

            for i in insert_sql:
                cursor.execute(i)

            session.commit()

        insert_into_table()

        def query_table():
            query = "SELECT * FROM cars;"
            cursor.execute(query)

            results = cursor.fetchall()

            print(results)

        query_table()

        cursor.close()
