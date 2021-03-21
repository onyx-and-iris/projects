import socket
import pickle

from voicemeeter.driver import dll
from sys import stderr


class Commands:
    def vban_sendtext(self, ip, text, port=6980, s_name='Command1'):
        """ 
        Credits go to TheStaticTurtle 
        https://github.com/TheStaticTurtle/pyVBAN 
        """
        IP = ip
        PORT = port
        S_NAME = s_name
        if len(S_NAME) > 16:
            print('ERROR streamname too long', file=stderr)

        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
        s.connect((IP, PORT))

        header  = 'VBAN'
        header += chr(int('0b01000000',2)) # SR = 0
        header += chr(int('0b00000000',2)) # bit mode (must be 0)
        header += chr(int('0b00000000',2)) # for subchannels 
        header += chr(int('0b00010000',2)) # UTF8
        header += S_NAME + "\x00" * (16 - len(S_NAME))
        header += str(0) + "\x00" * (4-len(str(0))) # framecounter

        try:
            rawData = header + text 
            s.sendto(rawData.encode(), (IP, PORT))

        except Exception as e:
            pass

class FileOps:
    """ save/retrieve states to pickle file """
    def __init__(self, macros):
        self.db = macros
        self.file_db = 'cache.pkl'

    def read_db(self):
        while True:
            try:
                with open(self.file_db, 'rb') as records:
                    self.db = pickle.load(records)
                break

            except FileNotFoundError:
                records = open(self.file_db, 'x')
                records.close()

            except EOFError:
                self.update_db(self.db)
                break

        return self.db

    def update_db(self, macros):
        with open(self.file_db, 'wb') as records:
            pickle.dump(macros, records)
