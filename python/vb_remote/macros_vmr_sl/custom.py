import socket

def vban_sendtext(ip, text, port=6980, s_name='Command1'):
    """
    Credits go to TheStaticTurtle
    https://github.com/TheStaticTurtle/pyVBAN.git
    """
    IP = ip
    PORT = port
    S_NAME = s_name
    if len(S_NAME) > 16:
        print('ERROR streamname too long')

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
    s.connect((IP, PORT))

    header  = 'VBAN'
    header += chr(int('0b01000000',2)) # SR = 0
    header += chr(int('0b00000000',2)) # bit mode (must be 0)
    header += chr(int('0b00000000',2)) # for subchannels
    header += chr(int('0b00010000',2)) # UTF8
    header += S_NAME + "\x00" * (16 - len(S_NAME))
    header += str(0) + "\x00" * (4-len(str(0))) # framecounter

    try:
        rawData = header + text
        s.sendto(rawData.encode(), (IP, PORT))

    except Exception as e:
        pass
