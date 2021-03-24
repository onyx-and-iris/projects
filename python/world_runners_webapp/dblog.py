import mysql.connector
from errors import (
                    ConnectionError,
                    CredentialsError,
                    SQLError,
                    )

class ConnectDB:
    def __init__(self, config: dict):
        self.dbconfig = config

    def __enter__(self) -> 'cursor':
        try:
            self.conn = mysql.connector.connect(**self.dbconfig)
            self.cursor = self.conn.cursor()
            return self.cursor
        except mysql.connector.errors.ProgrammingError as e:
            raise CredentialsError(e)
        except mysql.connector.errors.DatabaseError as e:
            raise ConnectionError(e)

    def __exit__(self, exc_type, exc_val, traceback):
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        
        if exc_type is mysql.connector.errors.ProgrammingError:
            raise SQLError(exc_val)
        elif exc_type:
            raise exc_type(exc_val)

