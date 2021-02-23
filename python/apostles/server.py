import apostles
import requests
from bs4 import BeautifulSoup
import socket

class Server:
    def __enter__(self):
        return self

    def __init__(self):
        self.HOST = ''
        self.PORT = 60001

        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket') 
            sys.exit()
        print('Socket Created') 

        self.s.bind ((self.HOST,self.PORT))
        self.s.listen()
        self.conn, self.addr = self.s.accept()

    def run(self):
        while True:
            req = self.conn.recv(1024).decode('utf-8')
            if req:
                args = list(req.split())
                print(f'client has requested version:{args[0]}\n'
                f'and book:{args[1]}\n')
                
                response = 'request received, getting your book...'
                self.conn.send(response.encode())
                break

        return args

    def serve(self):
        with open("book.txt", "r") as data:
            for line in data:
                self.conn.send(line.encode())

    def __exit__(self, type, value, traceback):
        self.s.shutdown(socket.SHUT_RDWR)
        self.s.close()
        print('Socket Closed')
        


if __name__ == '__main__':
    with Server() as serve_text:
        args = serve_text.run()

        soup = None
        html_text = None

        book = apostles.Version()
        html_text = book.get_text(args[0], args[1])
        
        if html_text:
            soup = BeautifulSoup(html_text, 'html.parser')

            book = apostles.Parse(soup)
            parse_bymethod = getattr(book, args[0])
            text = parse_bymethod() 

            file_io = apostles.FileOps()
            file_io.write_tofile(text)

            serve_text.serve()

