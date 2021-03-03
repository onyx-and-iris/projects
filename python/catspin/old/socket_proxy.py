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
        self.conn, self.addr = self.s.accept()

    def MakeConnection(self):
        try:
          self.sio.connect("https://sockets.streamlabs.com?token=" +
                           self.token)
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

        if 'for' in data:
            if data['for'] == 'twitch_account':
                if data['type'] == 'follow':
                    print('Just got a follow!')
                    self.conn.send(events[0].encode())
                elif data['type'] == 'subscription':
                    self.conn.send(events[1].encode())
                    print('Just got a subscription')
                elif data['type'] == 'bits':
                    self.conn.send(events[2].encode())
                    print('Just got some bits')
                elif data['type'] == 'host':
                    self.conn.send(events[3].encode())
                    print('Just got a host')
                else:
                    print(data['type'])
                    
            elif data['type'] == 'donation':
                print('Just got a donation') 
                self.conn.send(events[4].encode())
                
    def DisconnectHandler(self):
        """ disconnected cleanly? """
        print('disconnected')
        self.s.close()
        
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
    
