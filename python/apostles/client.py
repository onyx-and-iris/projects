import argparse
import socket

class retrieve_text:
    def __enter__(self):
        return self

    def __init__(self):
        # mapped in local hosts file
        self.HOST = 'x.x.x.x'
        self.PORT = 60000

        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket')
            sys.exit()
        print('Socket Created')

        self.s.connect((self.HOST,self.PORT))

    def send_req(self, request):
        self.s.send(request.encode())
        reponse = self.s.recv(1024).decode('utf-8')
        print(reponse)

    def wait_reply(self):
        data = self.s.recv(1024).decode('utf-8')
        while data:
            with open("book.txt", "a") as book_txt:
                book_txt.write(data)

            data = self.s.recv(1024).decode('utf-8')
        
        book_txt.close()

    def __exit__(self, type, value, traceback):
        self.s.close()
        print('Socket Closed')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v')
    parser.add_argument('-b')
    args = parser.parse_args()

    version = ('king_james', 'american_standard', 'world_english')
    book = ('matthew', 'mark', 'luke', 'john')

    request = None

    if args.v in version:
        if args.b in book:
            request = args.v + " " + args.b
        else:
            print(f'No such book, available options:\n'
            f'matthew\nmark\nluke\njohn\n')            
    else:
        print(f'No such version, available options:\n'
        f'king_james\namerican_standard\nworld_english\n')
    
    with retrieve_text() as retrieve:
        if request:
            retrieve.send_req(request)
        else:
            print(f'Failed to generate request string... exiting')

        retrieve.wait_reply()
