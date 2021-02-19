import random
import pickle
from sys import argv
from sys import exit

class RandomMaps:
    def __init__(self, player_count):
        """ maplist, map backtrace to player count, assign player count """
        self.map_file = 'maplist.pkl'
        self.maps = [
        'aftermath', 'cargo', 'carrier', 'drone', 'express',
        'hijacked', 'meltdown', 'overflow', 'plaza', 'raid', 'slums',
        'standoff', 'turbine', 'yemen', 'nuketown'
        ]
        self.player_count = player_count
        self.backtrace = {10:3, 20:5, 30:8}
        self.buffer = []

        if self.player_count <= 10:
            self.limit = self.backtrace[10]
        elif self.player_count <= 20:
            self.limit = self.backtrace[20]
        elif self.player_count <= 30:
            self.limit = self.backtrace[30]

    def get_map(self):
        self.load_maps()

        self.randomize()

        self.save_maps()

        return self.buffer[-1]

    def load_maps(self):
        try:
            with open(self.map_file, 'rb') as mapfile:
                self.buffer = pickle.load(mapfile)
            print(f'Buffer LOADED: {self.buffer}')
        except FileNotFoundError:
            with open(self.map_file, 'x') as mapfile:
                pass
        except EOFError:
            pass

    def randomize(self):
        """ is map in buffer? if not append """
        num_maps = len(self.maps)

        while True:
            try:
                next_map = self.maps[random.randrange(0, num_maps)]
            except KeyError:
                """ in case player count suddenly drops """
                pass

            self.pop_buffer()

            if next_map not in self.buffer:
                self.buffer.append(next_map)
                break
            else:
                print(f'{next_map} was already in buffer trying again...')

    def save_maps(self):
        try:
            with open(self.map_file, 'wb') as mapfile:
                pickle.dump(self.buffer, mapfile)
            print(f'Buffer SAVED: {self.buffer}')
        except:
            print('Error writing buffer to file')

    def pop_buffer(self):
        while (len(self.buffer) >= self.limit):
            self.buffer.pop(0)


if __name__ == '__main__':
    if len(argv) == 2:
        try: 
            player_count = int(argv[1])
        except ValueError:
            print('Please provide integer argument')
            exit()

        print('=================================================')
        print(f'Running test with player count of {player_count}')
        print('=================================================')
        generate = RandomMaps(player_count)    
        next_map = generate.get_map()
        print(f'Next map will be: {next_map}')
    else:
        print('"Usage: python .\\randommap.py -n" where n is integer')
