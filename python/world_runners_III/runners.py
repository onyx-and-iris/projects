import pickle
import argparse
from pathlib import Path

class fileOps:
    def __init__(self):
        self.db = {}
        self.file_db = "records.db"

    def createEmpty(self):
        Path(self.file_db).touch()

    def writeFile(self):
        records = open(self.file_db, "wb")

        pickle.dump(self.db, records)
        records.close

    def readFile(self):
        # attempt read from file if not exist then create file
        try:
            with open(self.file_db, "rb") as records:
                self.db = pickle.load(records)
                records.close

        except IOError:
            self.createEmpty()

        except EOFError:
            pass

        return self.db

    def truncate(self):
        records = open(self.file_db, "wb")
        records.truncate(0)
        records.close


class records:
    def newRecord():
        fileIO = fileOps()
        db = fileIO.readFile()
        next = 'y'

        while next == 'y':
            name = input('Please enter athlete short name: ')
            db[name] = {}
            name_full = input('Please enter athlete full name: ')
            db[name]['name'] = name_full
            age = input('Age:')
            db[name]['age'] = age
            country = input('Country:')
            db[name]['country'] = country
            event = input('Event:')
            db[name]['event'] = event
            pb = input('PB:')
            db[name]['pb'] = pb

            next = input('Add another record (y/n)? ')

        fileIO.writeFile()

        
    def getRecords():
        fileIO = fileOps()
        db = fileIO.readFile()

        if not db:
            print("No records set yet, please set some!")
        else:
            for key in db:
                print(f"{db[key]['name']} \n==============\n"
                f"{db[key]['age']}\n{db[key]['country']}\n"
                f"{db[key]['event']}\n{db[key]['pb']}\n")

    def reset():
        fileIO = fileOps()
        response = input("Truncating database, are you sure? (y/n) ")
        if response == "y":
            fileIO.truncate()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', action='store_true')
    parser.add_argument('-g', action='store_true')
    parser.add_argument('-t', action='store_true')
    args = parser.parse_args()

    if args.n:
        records.newRecord()
    elif args.g:
        records.getRecords()
    elif args.t:
        records.reset()
