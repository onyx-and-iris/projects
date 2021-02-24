This program is designed to work in conjunction with https://github.com/onyx-and-iris/projects/tree/main/python/apostles.
So long as the file(s) pulled are in the same directory as reformat_apostles.rb a list of book names will be presented
to the user and they may select which one to get data from.

A phrase/word can be provided to the program in the form of a string argument variable. The program will select the relevant 
parser and return back only the lines that include the requested phrase/word.

sample.out is an example of what you might expect

To use first pull text using apostles.py eg python apostles.py -v 'king_james' -b 'john'
Then with this program ruby apostles.rb 'But when she saw him' and choose the book and version when prompted.

Feel free to use/modify this code, use at your own risk. I make no promises that it will be fit for any specific purpose.