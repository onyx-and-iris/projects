# pip install python-engineio==3.14.2 python-socketio[client]==4.6.0
import socketio
import pickle
import socket
import argparse

from threading import Thread

class Streamlabs():
    def __init__(self, token):
        self.token = token
        self.sio = socketio.Client()
        self.sio.on('connect', self.ConnectHandler)
        self.sio.on('event', self.EventHandler)
        self.sio.on('disconnect', self.DisconnectHandler)

        self.HOST = '127.0.0.1' if args.t else ''
        self.PORT = 60000
        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket')
        print('socket created')

        self.s.bind ((self.HOST, self.PORT))
        self.s.listen()
        self.conn = None

    def MakeConnections(self):
        try:
            self.sio.connect("https://sockets.streamlabs.com?token=" +
                           self.token)
            t = Thread(target=self.MakeClientConn)
            t.start()
        except ValueError as e:
          pass
    def MakeClientConn(self):
        self.conn, self.addr = self.s.accept()
        print('Client connected')
    def MakeDisconnect(self):
        self.sio.disconnect()    

    def ConnectHandler(self):
        """ are we connected? """
        print('connected')

    def EventHandler(self, data):
        """ run on defined event """
        events = ['follow', 'subscription', 'bits', 'host', 'donation']

        if self.conn:
            try:
                if 'for' in data and data['for'] == 'twitch_account':
                    if data['type'] in events:
                        while True:
                            event_type = data['type']
                            self.conn.send(event_type.encode())
                            validated = self.conn.recv(1024).decode('utf-8')
                            if validated == event_type:
                                print('Validated event with client')
                            elif not validated:
                                raise 'Did not validated with client'
                                
                            resp = self.conn.recv(1024).decode('utf-8')
                            if not resp:
                                self.conn.close()
                            break
                elif data['type'] == 'donation':
                    event_type = 'donation'
                    self.conn.send(event_type.encode())
            except Exception as e:
                print('No client found, Error:', str(e))
                if self.conn:
                    self.conn.close()
            finally:
                t = Thread(target=self.MakeClientConn)
                t.start()
        else:
            print('No client connected... skipping')

               
    def DisconnectHandler(self):
        """ disconnected cleanly? """
        print('disconnected')
        
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', action='store_true')
    args = parser.parse_args()

    file_t = 'token.pkl'
    while True:
        try:
            with open(file_t, 'rb') as token_file:
                token = pickle.load(token_file)
            break    
        except FileNotFoundError:
            with open(file_t, 'x') as token_file:
                pass
        except EOFError:
            token = input('Enter Socket API token:\n')
            with open(file_t, 'wb') as token_file:
                pickle.dump(token, token_file)
 
    ws = Streamlabs(token)
    ws.MakeConnections()
