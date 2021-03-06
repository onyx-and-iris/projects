import argparse
import socket
import os


class Locals:
    def __init__(self, version, book):
        self.thisBook = version + '_' + book + '.txt'

    def has_book(self):
        return os.path.isfile(self.thisBook)

    def backup_book(self):
        if os.path.isfile('book.txt'):
            os.rename('book.txt', self.thisBook)


class RetrieveText:
    def __enter__(self):
        try:
            self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        except socket.error:
            print('Failed to create socket')
            sys.exit()
        print('Socket Created')

        self.s.connect((self.HOST, self.PORT))

        return self

    def __init__(self):
        # mapped in local hosts file
        self.HOST = 'oai.vps'
        self.PORT = 60001

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

    def __exit__(self, type, value, traceback):
        self.s.close()
        print('Socket Closed')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', nargs=None, 
    choices=['king_james', 'american_standard', 'world_english'])
    parser.add_argument('-b', nargs=None, 
    choices=['matthew', 'mark', 'luke', 'john'])
    args = parser.parse_args()

    request = None

    if args.v and args.b:
            request = args.v + " " + args.b
    else:
        print(f'Please provide book and version.\n'
        f'Book available options:\n'
        f'matthew\nmark\nluke\njohn\n'
        f'Version available options:\n'
        f'king_james\namerican_standard\nworld_english\n')

    check_lib = Locals(args.v, args.b)

    if check_lib.has_book():
        print('Book already in local storage')
    else:
        with RetrieveText() as retrieve:
            if request:
                retrieve.send_req(request)
            else:
                print(f'Failed to generate request string... exiting')

            retrieve.wait_reply()

            check_lib.backup_book()
