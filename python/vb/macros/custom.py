import socket

from ctypes import *
from voicemeeter.driver import dll
from sys import stderr


class Commands:
  def button_setstate(index, state, mode=2):
    """ Hook into C API function """
    cbf_setstatus = dll.VBVMR_MacroButton_SetStatus
    """ set expected args and return type """
    cbf_setstatus.argtypes = [c_long, c_float, c_long]
    cbf_setstatus.restype = c_long

    c_index = c_long(index)
    c_state = c_float(state)
    c_mode = c_long(mode)

    retval = cbf_setstatus(c_index, c_state, c_mode)
    if retval:
      print(f'ERROR: Callback button_setState logical ID: [{int(c_index.value)}]'
      , file=stderr)

  def vban_sendtext(ip, text, port=6980, s_name='Command1'):
    """ 
    Credits go to TheStaticTurtle 
    https://github.com/TheStaticTurtle/pyVBAN 
    """
    IP = ip
    PORT = port
    S_NAME = s_name
    if len(S_NAME) > 16:
      print('ERROR streamname too long', file=stderr)

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
