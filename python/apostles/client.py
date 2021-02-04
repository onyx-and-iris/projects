import argparse
import socket

# mapped in local hosts file
HOST = 'x.x.x.x'
PORT = 60000

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
except socket.error:
    print('Failed to create socket')
    sys.exit()
print('Socket Created')

s.connect((HOST,PORT))

parser = argparse.ArgumentParser()
parser.add_argument('-v')
parser.add_argument('-b')
args = parser.parse_args()

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

if args.v in version:
    if args.b in version[args.v]:
        string = args.v + " " + args.b
        s.send(string.encode())
    else:
        print(f'No such book, available options:\n'
        f'matthew\nmark\nluke\njohn\n')            
else:
    print(f'No such version, available options:\n'
    f'king_james\namerican_standard\nworld_english\n')

s.close