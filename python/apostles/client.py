import argparse
import socket

def send_req(request):
    # mapped in local hosts file
    HOST = 'X.X.X.X'
    PORT = 60000

    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error:
        print('Failed to create socket')
        sys.exit()
    print('Socket Created')

    s.connect((HOST,PORT))
    
    s.send(request.encode())
    
    s.close

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
    
    if request:
        send_req(request)
    else:
        print(f'Failed to generate request string... exiting')