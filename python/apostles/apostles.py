import re
import requests
import argparse

from bs4 import BeautifulSoup

class Version:
    def __init__(self):
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

    def get_text(self, ver, book):
        if ver and book:
            html_text = requests.get(self.version[ver][book]).text
        else:
            print(f'Please provide book and version.\n'
            f'Book available options:\n'
            f'matthew\nmark\nluke\njohn\n'
            f'Version available options:\n'
            f'king_james\namerican_standard\nworld_english\n')

        return html_text

class Parse():
    def __init__(self, soup):
        self.soup = soup

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

    def american_standard(self):
        # remove all javascript and stylesheet code
        for script in self.soup(['script', 'style']):
            script.extract()

        # remove tags with these id
        self.soup.find(id='textname').decompose()
        self.soup.find(id='toprightad').decompose()

        # split chapter/verse into separate lines
        for a in self.soup.find_all('a'):
            a.replace_with("\n" + a.text + " ")
        
        text = self.soup.find(id='textboundingbox').text.strip()

        return text

    def world_english(self):
        # remove all javascript and stylesheet code
        for script in self.soup(['script', 'style']):
            script.extract()

        # remove tags with these id
        self.soup.find(id='textname').decompose()
        self.soup.find(id='toprightad').decompose()

        # remove any hyperlinks
        for link in self.soup.findAll('a', href=True):
            link.extract()

        # split chapter/verse into separate lines
        for a in self.soup.find_all('a'):
            a.replace_with("\n" + a.text + " ")

        text = self.soup.find(id='textboundingbox').text.strip()

        return text


class FileOps:
    def write_tofile(self, text):
        book_txt = "book.txt"

        while True:
            try:
                with open(book_txt, "w") as textfile:
                    textfile.write(text)
                break
            except IOError:
                textfile = open(book_txt, "x")
                textfile.close()


def main(version, book):
    """ get html_text then parse with appropriate parser then write to file """
    version = Version()
    html_text = version.get_text(args.v, args.b)    

    if html_text:
        soup = BeautifulSoup(html_text, 'html.parser')

        book = Parse(soup)
        parse_bymethod = getattr(book, args.v)
        text = parse_bymethod() 

        file_io = FileOps()
        file_io.write_tofile(text)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', nargs=None, 
    choices=['king_james', 'american_standard', 'world_english'])
    parser.add_argument('-b', nargs=None, 
    choices=['matthew', 'mark', 'luke', 'john'])
    args = parser.parse_args()

    html_text = None
    soup = None

    main(args.v, args.b)
