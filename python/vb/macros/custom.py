import socket

from ctypes import *
from voicemeeter.driver import dll


class commands:
  def button_setState(index, state):
    """ long __stdcall VBVMR_MacroButton_SetStatus(long nuLogicalButton, float fValue, long bitmode); """
    macro_setstatus = dll.VBVMR_MacroButton_SetStatus
    c_l_logical = c_long(index)
    # use this value to turn macro state on and off
    c_f_val = c_float(state)
    c_l_mode = c_long(2)

    retval = macro_setstatus(c_l_logical, c_f_val, c_l_mode)

    if not retval:
      print('Call back function return: OK')

  def VBAN_SendText(ip, text):
    """ Credits go to TheStaticTurtle https://github.com/TheStaticTurtle/pyVBAN """
    IP = ip
    PORT = 6990
    streamName = 'sound_t'
    sampleRate = 0
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
    s.connect((IP, PORT))
    VBAN_BPSList = [0, 110, 150, 300, 600, 1200, 2400, 4800, 9600, 14400,19200, 31250, 38400, 57600, 115200, 128000, 230400, 250000, 256000, 460800,921600, 1000000, 1500000, 2000000, 3000000]
    framecounter = 0

    header  = 'VBAN' 
    header += chr(int('0b01000000',2)  + VBAN_BPSList.index(sampleRate))
    header += chr(int('0b00000000',2))
    header += chr(int('0b00000000',2))
    header += chr(int('0b00010000',2)) # UTF8
    header += streamName + "\x00" * (16 - len(streamName))
    header += str(framecounter) + "\x00" * (4 - len(str(framecounter)))

    try:
      framecounter += 1
      rawData = header + text 
      s.sendto(rawData.encode(), (IP, PORT))

    except Exception as e:
      pass