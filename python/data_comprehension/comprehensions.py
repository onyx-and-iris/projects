import argparse
import requests
import os
import csv
import pprint

from datetime import datetime

class NoCSVFileError(Exception):
    pass

class DataTypeError(Exception):
    pass


class Utils:
    def print_data(self, data):
        """ print each list per line or pretty print nested dicts """
        print(len(data), 'records generated')
        if isinstance(data, list):
            for each_list in data:
                print(each_list)
        elif isinstance(data, dict):
            pprint.pprint(data)    


class ParseData(Utils):
    def __init__(self, data: dict):
        self.data = data

    def unique_values(self, data: list) -> list:
        return list(set(data))

    def gen_date(self, data: dict) -> str:
        date_object = datetime.strptime(data['date'], '%Y-%m-%d')
        return datetime.strftime(date_object, '%d/%m/%Y')

    def convert(self, type_conversion):
        if isinstance(self.data, dict):
            if type_conversion == 'date':
                copy = {d: self.gen_date(self.data[d]) for d in self.data}
            elif type_conversion == 'year':
                copy = {self.data[d]['winnername']: self.data[d]['losername'] \
                for d in self.data \
                if self.gen_date(self.data[d]).split('/')[2] in ['1998']}

        elif isinstance(self.data, list):
            if type_conversion  == 'dup':
                copy = [l[4] for l in self.data]
                copy = self.unique_values(copy)
        else:
            raise DataTypeError('Wrong data type error')

        return copy

class InitializeData(Utils):
    def __init__(self):
        self.data_file = 'downloaded.csv'

    def dict_data(self, limit: int) -> dict:
        """ returns data as nested dict type """
        self.fetch_data()
        with open(self.data_file) as data:

            self.data = {}
            for line in csv.DictReader(data):
                if int(line['gameid']) > limit:
                    break
                self.data[line['gameid']] = line

        return self.data

    def list_data(self, limit: int) -> list:
        """ returns data as nested lists, skips header """
        self.fetch_data()

        print('Generating LIST data')
        with open(self.data_file) as data:
            csvreader = csv.reader(data)
            next(csvreader)
            
            self.data = []
            for line in csv.reader(data):
                if int(line[0]) > limit:
                    break
                self.data.append(line)

        return self.data

    def fetch_data(self):
        url = \
        'https://media.githubusercontent.com/media/fivethirtyeight/data/' \
        'master/scrabble-games/scrabble_games.csv'
        if not os.path.isfile(self.data_file):
            print('Fetching data from url...')
            req = requests.get(url)
            content = req.content
            with open(self.data_file, 'wb') as csvfile:
                csvfile.write(content)
        else:
            print('Loading data from file...')   
  
def main(args):
    csv_obj = InitializeData()

    if args.f:
        csv_obj.fetch_data()
    elif args.l:
        data = csv_obj.list_data(args.l)
    elif args.d:
        data = csv_obj.dict_data(args.d)
    if args.v:
        csv_obj.print_data(data)

    if args.p:
        parse = ParseData(data)
        data = parse.convert(args.p)
        if args.w:
            parse.print_data(data)


if __name__ == '__main__':
    """ initiate the parser """
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', action='store_true')
    parser.add_argument('-l', nargs=None, type=int)
    parser.add_argument('-d', nargs=None, type=int)
    parser.add_argument('-v', action='store_true')
    parser.add_argument('-p', nargs=None)
    parser.add_argument('-w', action='store_true')

    args = parser.parse_args()

    main(args)
