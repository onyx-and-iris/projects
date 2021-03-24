import time
import sys
sys.path.append('..')
import unittest
import pickle
from dblog import ConnectDB
from errors import (
                    ConnectionError,
                    CredentialsError,
                    SQLError,
                    )


class TestQuery(unittest.TestCase):
    def setUp(self):
        self.cred = dict()
        with open('../token.pkl', 'rb') as token:
            self.cred = pickle.load(token)

    def test_it_tests_a_valid_shortname_query(self):
        with ConnectDB(self.cred) as cursor:
            _SQL = """ 
            SELECT shortname 
            FROM log
            WHERE id=1 """
            cursor.execute(_SQL)
            res = cursor.fetchall()
        
        self.assertEqual(res, [('mo',)])

    def tearDown(self):
        pass


class TestErrors(unittest.TestCase):
    def setUp(self):
        self.cred = dict()
        with open('../token.pkl', 'rb') as token:
            self.cred = pickle.load(token)

    def test_it_tests_an_invalid_query(self):
        """ expected SQLError handles in exit dunder """
        def func():
            with ConnectDB(self.cred) as cursor:
                _SQL = """ 
                BAD QUERY """
                cursor.execute(_SQL)
            
            self.assertRaises(SQLError, func)

    def test_it_tests_an_invalid_user(self):
        """ expect CredentialsError """
        def func():
            self.cred['user'] = 'wrongusername'
            with ConnectDB(self.cred) as cursor:
                pass 
            
        self.assertRaises(CredentialsError, func)

    def test_it_tests_an_invalid_pass(self):
        """ expect CredentialsError """
        def func():
            self.cred['user'] = 'wrongpass'
            with ConnectDB(self.cred) as cursor:
                pass 
            
        self.assertRaises(CredentialsError, func)

    def test_it_tests_an_invalid_db_name(self):
        """ expect CredentialsError """
        def func():
            self.cred['database'] = 'wrongdbname'
            with ConnectDB(self.cred) as cursor:
                pass 
            
        self.assertRaises(CredentialsError, func)

    def test_it_tests_an_invalid_port(self):
        """ expect ConnectionError """
        def func():
            self.cred['port'] = 5678
            with ConnectDB(self.cred) as cursor:
                pass 
            
        self.assertRaises(ConnectionError, func)

    def tearDown(self):
        pass

if __name__ == '__main__':
    unittest.main()
        
