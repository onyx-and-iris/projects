import pickle
import argparse

from sys import exit


class PickleFile:
    def __init__(self):
        self.db = {}
        self.file_db = 'records.pkl'

    def read_file(self):
        """ attempt read from file if not exist then create file """
        try:
            with open(self.file_db, 'rb') as records:
                self.db = pickle.load(records)

        except FileNotFoundError:
            with open(self.file_db, 'x') as records:
                pass

        except EOFError:
            pass

        return self.db

    def write_file(self):
        with open(self.file_db, 'w') as records:
            pickle.dump(self.db, records)

    def truncate(self):
        with open(self.file_db, 'wb') as records:
            records.truncate(0)

class Records:
    def __init__(self):
        self.file_io = PickleFile()
        self.db = self.file_io.read_file()    
        self.options = {key for key in self.db}

    def new_record(self):
        next = 'y'

        while next == 'y':
            name = input('Please enter athlete short name: ')
            self.db[name] = {}
            name_full = input('Please enter athlete full name: ')
            self.db[name]['name'] = name_full
            age = input('Age:')
            self.db[name]['age'] = age
            country = input('Country:')
            self.db[name]['country'] = country
            event = input('Event:')
            self.db[name]['event'] = event
            pb = input('PB:')
            self.db[name]['pb'] = pb

            next = input('Add another record (y/n)? ')

        self.file_io.write_file()

    def get_records(self):
        if not self.db:
            print('No records set yet, please set some!')
        else:
            for runner in self.options:
                print(f'=======================')
                for key, val in self.db[runner].items():
                    print(key, val)

    def get_record_byname(self, name):
        if not self.db:
            print('No records set yet, please set some!')
        else:
            try:
                return {k:v for (k,v) in self.db[name].items()}
            except (KeyError, ValueError) as e:
                print(f'Error: no record for {name}\n'
                f'Available options: {self.options}')
                exit()
        

    def reset():
        self.file_io = FileOps()
        response = input('Truncating database, are you sure? (y/n) ')
        if response == 'y':
            file_io.truncate()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', action='store_true')
    parser.add_argument('-get', nargs=None)
    parser.add_argument('-r', action='store_true')
    args = parser.parse_args()

    records = Records()
    record = []

    if args.n:
        records.new_record()
    elif args.get:
        arg = args.get

        if arg == 'all':
            records.get_records()
        else:
            record = records.get_record_byname(arg)
            for key in record:
                print(f'{key:8}  :  {record[key]}')
    elif args.r:
        records.reset()

