import argparse
import requests
import os
import csv
import pprint
import copy

from datetime import datetime

class NoCSVFileError(Exception):
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

    def deep_copy(self, data) -> dict:
        return copy.deepcopy(data)      


class ParseData(Utils):
    def __init__(self, data: str):
        self.data = data

    def convert_date_in_dicts(self) -> dict:
        """ 
        Convert date format for each nested dict.
        Return copy to preserve original.
        """
        copy = self.deep_copy(self.data)
        for each_dict in copy:
            date_str = copy[each_dict]['date']
            date_object = datetime.strptime(date_str, '%Y-%m-%d')
            copy[each_dict]['date'] = \
            datetime.strftime(date_object, '%d/%m/%Y').replace('0', '')
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
        limit = int(args.l)
        data = csv_obj.list_data(limit)
        csv_obj.print_data(data)
        exit()
    elif args.d:
        limit = int(args.d)
        data = csv_obj.dict_data(limit)
        csv_obj.print_data(data)
        exit()

    parse = ParseData(data)
    newdata = parse.convert_date_in_dicts()
    print('BEFORE CONVERSION:')
    csv_obj.print_data(data)
    print('AFTER CONVERSION:')
    parse.print_data(newdata)  


if __name__ == '__main__':
    """ initiate the parser """
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', action='store_true')
    parser.add_argument('-l', nargs=None)
    parser.add_argument('-d', nargs=None)

    args = parser.parse_args()

    main(args)
