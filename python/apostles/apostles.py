import re
import requests
from bs4 import BeautifulSoup

import argparse

class parseHtml:
    def __init__(self, soup=None):
        self.soup = soup    

        self.url_kj = {
            'matthew': "http://www.earlychristianwritings.com/text/matthew-kjv.html",
            'mark': "http://www.earlychristianwritings.com/text/mark-kjv.html",
            'luke': "http://www.earlychristianwritings.com/text/luke-kjv.html",
            'john': "http://www.earlychristianwritings.com/text/john-kjv.html"
        }

        self.url_as = {
            'matthew': "http://www.earlychristianwritings.com/text/matthew-asv.html",
            'mark': "http://www.earlychristianwritings.com/text/mark-asv.html",
            'luke': "http://www.earlychristianwritings.com/text/luke-asv.html",
            'john': "http://www.earlychristianwritings.com/text/john-asv.html"
        }

        self.url_we = {
            'matthew': "http://www.earlychristianwritings.com/text/matthew-web.html",
            'mark': "http://www.earlychristianwritings.com/text/mark-web.html",
            'luke': "http://www.earlychristianwritings.com/text/luke-web.html",
            'john': "http://www.earlychristianwritings.com/text/john-web.html"        
        }
        
        self.version = {}
        self.version['king_james'] = self.url_kj
        self.version['american_standard'] = self.url_as
        self.version['world_english'] = self.url_we


    def king_james(self): 
        # remove all javascript and stylesheet code
        for script in self.soup(['script', 'style']):
            script.extract()

        # replace <br> tags with /n
        for br in self.soup.find_all('br'):
            br.replace_with("\n" + br.text)

        # remove tags with these id
        self.soup.find(id='textname').decompose()
        self.soup.find(id='toprightad').decompose()   

        text = self.soup.find(id='textboundingbox').text.strip()

        return text


class fileOps:
    def writeTofile(self, text):
        john_txt = "book.txt"

        while True:
            try:
                with open(john_txt, "w") as textfile:
                    textfile.write(text)
                    textfile.close()
                    break
            except IOError:
                textfile = open(john_txt, "x")
                textfile.close()


# allow us to run this as a local standalone script
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v')
    parser.add_argument('-b')
    args = parser.parse_args()

    html_text = None
    soup = None

    book = parseHtml(soup)

    if args.v in book.version:
        if args.b in book.version[args.v]:
            html_text = requests.get(book.version[args.v][args.b]).text
        else:
            print(f'No such book, available options:\n'
            f'matthew\nmark\nluke\njohn\n')            
    else:
        print(f'No such version, available options:\n'
        f'king_james\namerican_standard\nworld_english\n')

    if html_text:
        soup = BeautifulSoup(html_text, 'html.parser')

        # use the appropriate parser
        book = parseHtml(soup)
        parse_bymethod = getattr(book, args.v)
        text = parse_bymethod() 

        fileIO = fileOps()
        fileIO.writeTofile(text)
