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

    url_kj = {
        'matthew': "http://www.earlychristianwritings.com/text/matthew-kjv.html",
        'mark': "http://www.earlychristianwritings.com/text/mark-kjv.html",
        'luke': "http://www.earlychristianwritings.com/text/luke-kjv.html",
        'john': "http://www.earlychristianwritings.com/text/john-kjv.html"
    }

    url_as = {
        'matthew': "http://www.earlychristianwritings.com/text/matthew-asv.html",
        'mark': "http://www.earlychristianwritings.com/text/mark-asv.html",
        'luke': "http://www.earlychristianwritings.com/text/luke-asv.html",
        'john': "http://www.earlychristianwritings.com/text/john-asv.html"
    }

    url_we = {
        'matthew': "http://www.earlychristianwritings.com/text/matthew-web.html",
        'mark': "http://www.earlychristianwritings.com/text/mark-web.html",
        'luke': "http://www.earlychristianwritings.com/text/luke-web.html",
        'john': "http://www.earlychristianwritings.com/text/john-web.html"        
    }
                    
    version = {}
    version['king_james'] = url_kj
    version['american_standard'] = url_as
    version['world_english'] = url_we

    html_text = None

    if args[0] in version:
        if args[1] in version[args[0]]:
            html_text = requests.get(version[args[0]][args[1]]).text
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
        


