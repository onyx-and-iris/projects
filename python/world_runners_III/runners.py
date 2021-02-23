import pickle
import argparse
from pathlib import Path


class FileOps:
    def __init__(self):
        self.db = {}
        self.file_db = 'records.db'

    def create_empty(self):
        Path(self.file_db).touch()

    def write_file(self):
        records = open(self.file_db, 'wb')

        pickle.dump(self.db, records)
        records.close

    def read_file(self):
        """ attempt read from file if not exist then create file """
        try:
            with open(self.file_db, 'rb') as records:
                self.db = pickle.load(records)

        except IOError:
            self.createEmpty()

        except EOFError:
            pass

        return self.db

    def truncate(self):
        records = open(self.file_db, 'wb')
        records.truncate(0)
        records.close


class Records:
    def __init__(self):
        file_io = FileOps()
        self.db = file_io.read_file()    

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

        file_io.write_file()

    def get_records(self):
        if not self.db:
            print('No records set yet, please set some!')
        else:
            for key in self.db:
                print(f'{self.db[key]["name"]} \n==============\n'
                f'{self.db[key]["age"]}\n{self.db[key]["country"]}\n'
                f'{self.db[key]["event"]}\n{self.db[key]["pb"]}\n')

    def reset():
        file_io = FileOps()
        response = input('Truncating database, are you sure? (y/n) ')
        if response == 'y':
            file_io.truncate()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', action='store_true')
    parser.add_argument('-g', action='store_true')
    parser.add_argument('-t', action='store_true')
    args = parser.parse_args()

    records = Records()

    if args.n:
        records.new_record()
    elif args.g:
        records.get_records()
    elif args.t:
        records.reset()
