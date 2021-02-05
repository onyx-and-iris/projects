import apostles
import requests
from bs4 import BeautifulSoup
import socket

class listen:
    def __init__(self):
        self.HOST = ''
        self.PORT = 60000

    def run(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket') 
            sys.exit()
        print('Socket Created') 

        s.bind ((self.HOST,self.PORT))
        s.listen()

        conn, addr = s.accept()

        while True:
            req = conn.recv(1024).decode('utf-8')
            print(req)
            if req:
                args = list(req.split())
                print(f"client has requested version:{args[0]}\n"
                f"and book:{args[1]}\n")

                s.close()
                
                break
        return args

if __name__ == '__main__':
    runServer = listen()

    args = runServer.run()

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

        fileIO = apostles.fileOps()
        fileIO.writeTofile(text)
        


