import apostles
import requests
from bs4 import BeautifulSoup
import socket

class server:
    def __enter__(self):
        return self

    def __init__(self):
        self.HOST = ''
        self.PORT = 60000

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
    with server() as serve_text:
        args = serve_text.run()

        soup = None
        html_text = None

        book = apostles.parseHtml(soup)

        if args[0] in book.version:
            if args[1] in book.version[args[0]]:
                html_text = requests.get(book.version[args[0]][args[1]]).text
            else:
                print(f'No such book available!')
        else:
            print(f'No such version available!')

        if html_text:
            soup = BeautifulSoup(html_text, 'html.parser')

            # use the appropriate parser
            book = apostles.parseHtml(soup)
            parse_bymethod = getattr(book, args[0])
            text = parse_bymethod() 

            # write text to file on server
            fileIO = apostles.fileOps()
            fileIO.writeTofile(text)

            # serve data to client
            serve_text.serve()

