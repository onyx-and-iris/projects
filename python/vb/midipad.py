import time
import rtmidi

#connect to midi port
midiout = rtmidi.MidiOut()
available_ports = midiout.get_ports()

if available_ports:
    midiout.open_port(2)
else:
    exit ("unable to bind to a port, closing gracefully")

switch = None
macro = None
    
class updateButtonState:
  def __init__(self):
    self.ch_on=0x90
    self.ch_off=0x80
    
    self.macropad = {
    # layer1
    "mute_mics": 50, "only_discord": 51, "only_stream": 52, "sound_test":53,
    "only_onyx":54, "only_iris":55, "start":56,
    # layer2
    "brb": 60, "onyx_only": 61, "iris_only": 62, "dual":63,
    "onyx_big":64, "iris_big":65, "end":66,
    # layer3    
    "start_gc": 70, "onyx_solo": 71, "brb_gc": 72, "end_gc":73,
    "iris_solo":74, "reset":75
    }

  # switch not required here, I'll look into this later
  def two_pos(self, midiout, macro, switch):
    if switch == True:
      print("Switch TRUE sending MIDI ON")
      with midiout:
        note_on = [self.ch_on, self.macropad[macro], 127] 
        midiout.send_message(note_on)
        time.sleep(0.5)
    else:
      print("Switch FALSE sending MIDI OFF")
      with midiout:
        note_off = [self.ch_on, self.macropad[macro], 127]
        midiout.send_message(note_off)
        time.sleep(0.5)

    del midiout
  
  def push(self, midiout, macro):
    with midiout:
        note_on = [self.ch_on, self.macropad[macro], 127] # channel 1, middle C, velocity 112
        note_off = [self.ch_off, self.macropad[macro], 0]
        midiout.send_message(note_on)
        time.sleep(0.5)
        midiout.send_message(note_off)
        time.sleep(0.1)

    del midiout
    
###########

class getType:
  def __enter__(self):
      return self

  def __init__(self, macro, switch):
    self.macro = macro
    self.switch = switch
    
    self.two_pos = [
      "mute_mics", "only_discord", "only_stream", "only_onyx", "only_iris"
    ]
    self.push = [
      "sound_test", "start", "brb", "onyx_only", "iris_only", "dual", "onyx_big", "iris_big", "end",
      "start_gc", "onyx_solo", "brb_gc", "end_gc", "iris_solo", "reset"
    ]    

  def upd_type(self):
    upd = updateButtonState()

    if self.macro in self.two_pos:
      print(("{} is of type two_pos").format(self.macro))
      upd.two_pos(midiout, self.macro, self.switch)
    elif self.macro in self.push:
      print(("{} is of type push").format(self.macro))
      upd.push(midiout, self.macro)
    
  def __exit__(self, exc_type, exc_val, exc_tb):
    return None