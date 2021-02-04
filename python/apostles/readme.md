This program can be used to pull the text from http://www.earlychristianwritings.com
for any of the four apostles (maybe add more books later) in any of the versions:
King James
American Standard
World English.

It will work as a standalone client using only Apostles.py if you pass it arguments for
required version and book.

It will also work in client-server mode. The client can request a book also with 
argument variables and the server will generate the text with the same logic.
For client-server both server.py and apostles.py need to be on the server and the
appopriate port on the server must be opened or socket creation will fail.

Feel free to use this script or modify it for your own purposes. I take no responsibility
for its use, use at your own risk. I make no promises it will be fit for any purpose.
I made it only to practice socket programming.
