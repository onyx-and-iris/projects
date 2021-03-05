# pip install python-engineio==3.14.2 python-socketio[client]==4.6.0
import socketio
import pickle
import socket

class Streamlabs():
    def __init__(self, token):
        self.token = token
        self.sio = socketio.Client()
        self.sio.on('connect', self.ConnectHandler)
        self.sio.on('event', self.EventHandler)
        self.sio.on('disconnect', self.DisconnectHandler)

        self.HOST = ''
        self.PORT = 60000
        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket')
        print('socket created')

        self.s.bind ((self.HOST, self.PORT))
        self.s.listen()

    def MakeConnection(self):
        try:
          self.sio.connect("https://sockets.streamlabs.com?token=" +
                           self.token)
          self.conn, self.addr = self.s.accept()
        except ValueError as e:
          pass

    def MakeDisconnect(self):
        self.sio.disconnect()    

    def ConnectHandler(self):
        """ are we connected? """
        print('connected')

    def EventHandler(self, data):
        """ run on defined event """
        events = ['follow', 'subscription', 'bits', 'host', 'donation']

        if not self.conn:
            self.conn, self.addr = self.s.accept()

        if 'for' in data:
            if data['for'] == 'twitch_account':
                if data['type'] in events:
                    while True:
                        try:
                            type = data['type']
                            self.conn.send(type.encode())
                            validated = self.conn.recv(1024).decode('utf-8')
                            if validated == type:
                                print('Validated event with client')
                            elif not validated:
                                print('Did not validated with client')
                                self.conn, self.addr = self.s.accept()
                                continue
                                
                            resp = self.conn.recv(1024).decode('utf-8')
                            if not resp:
                                self.conn.close()
                                self.conn = None
                                break
                        except BrokenPipeError:
                            if self.conn:
                                self.conn.close()
                                self.conn = None
                            else:
                                break
                        finally:
                            if not self.conn:
                                self.conn, self.addr = self.s.accept()
                            
                else:
                    print(data['type'])
            
            elif data['type'] == 'donation':
                print(data)
                try:
                    type = 'donation'
                    self.conn.send(type.encode())
                    print('Just got a {type}') 
                except BrokenPipeError:
                    self.conn.close()
                    self.conn = None

               
    def DisconnectHandler(self):
        """ disconnected cleanly? """
        print('disconnected')
        
if __name__ == '__main__':
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
    ws.MakeConnection()
    
