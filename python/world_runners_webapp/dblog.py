import mysql.connector

class ConnectDB:
    def __init__(self, config: dict):
        self.dbconfig = config

    def __enter__(self) -> 'cursor':
        self.conn = mysql.connector.connect(**self.dbconfig)
        self.cursor = self.conn.cursor()
        return self.cursor

    def __exit__(self, exc_type, exc_val, traceback):
        self.conn.commit()
        self.cursor.close()
        self.conn.close()

