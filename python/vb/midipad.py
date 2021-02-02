import time
import rtmidi

switch = None
macro = None
    
class updateButtonState:
  def __init__(self):
    self.ch=0x90
    
    self.macropad = {
    # layer1
    "mute_mics": 50, "only_discord": 51, "only_stream": 52, "sound_test":53,
    "solo_onyx":54, "solo_iris":55, "start":56,
    # layer2
    "brb": 60, "onyx_only": 61, "iris_only": 62, "dual_scene":63,
    "onyx_big":64, "iris_big":65, "end":66,
    # layer3    
    "start_gc": 70, "onyx_solo": 71, "brb_gc": 72, "end_gc":73,
    "iris_solo":74, "reset":75
    }

  def two_pos(self, midiout, macro):
    with midiout:
      send_midi = [self.ch, self.macropad[macro], 127] 
      midiout.send_message(send_midi)
      time.sleep(0.5) 

    del midiout
    
  def push(self, midiout, macro):
    with midiout:
      send_midi = [self.ch, self.macropad[macro], 127] 
      midiout.send_message(send_midi)
      time.sleep(1.5)
      midiout.send_message(send_midi)
      
    del midiout
  
  def sound_t(self, midiout, macro, switch):
    if switch:
      with midiout:
          send_midi = [self.ch, self.macropad[macro], 127]
          for i in range(0, 5):
            midiout.send_message(send_midi)
            time.sleep(0.5)
      del midiout
      
    else:
      with midiout:
        send_midi = [self.ch, self.macropad[macro], 127] 
        midiout.send_message(send_midi)
        time.sleep(0.5) 

      del midiout
      
     
###########

class getType:
  def __enter__(self):
      return self

  def __init__(self, macro, switch):
    #connect to midi port
    self.midiout = rtmidi.MidiOut()
    self.available_ports = self.midiout.get_ports()

    if self.available_ports:
        self.midiout.open_port(2)
    else:
        exit ("unable to bind to a port, closing gracefully")  
  
    self.macro = macro
    self.switch = switch
    
    self.two_pos = [
      "mute_mics", "only_discord", "only_stream", "solo_onyx", "solo_iris"
    ]
    self.push = [
      "sound_test", "start", "brb", "onyx_only", "iris_only", "dual_scene", "onyx_big", "iris_big", "end",
      "start_gc", "onyx_solo", "brb_gc", "end_gc", "iris_solo", "reset"
    ]    

  def upd_type(self):
    upd = updateButtonState()

    if self.macro == "sound_test":
      upd.sound_t(self.midiout, self.macro, self.switch)
    elif self.macro in self.two_pos:
      upd.two_pos(self.midiout, self.macro)
    elif self.macro in self.push:
      upd.push(self.midiout, self.macro)
    
  def __exit__(self, exc_type, exc_val, exc_tb):
    return None