# Our current layer 1 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 2 and 3
import voicemeeter
import keypress

from custom import commands

class send_vbantext:
  def mic_test(upd):
    set_t = 'Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;'
    unset_t = 'Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;'
    if upd:
      commands.VBAN_SendText('onyx.local', set_t)
      commands.VBAN_SendText('iris.local', set_t)
      
      print("Mic Test Enabled")
    else:
      commands.VBAN_SendText('onyx.local', unset_t)
      commands.VBAN_SendText('iris.local', unset_t)
      print("Mic Test Disabled")    

class updates:
  def __init__(self):
    """ map macro names to logical IDS """
    self.button_map = [
    ('mute_mics', 0), ('only_discord', 1), ('only_stream', 2),
    ('sound_test', 10), ('solo_onyx', 11), ('solo_iris', 12),
    ('start', 20), ('reset', 72)
    ]    
    
  def Button_State(self, macro, upd):
    for macro_name, logical_id in self.button_map:
      if macro_name == macro:
        print(f'Macro = {macro_name} Button ID = {logical_id} State = {upd}')
        commands.button_setState(logical_id, upd)
        
        break

  def reset_Button_State(self, data_def):
    """ run lists from default macros dict through button_state function """
    for arg, data in data_def['layer1'].items():
      print(f'{data[0]} {data[1]}')
      self.Button_State(data[0], data[1])
    
class macros:
  def __init__(self, macro, switch):
    self.macro = macro
    self.switch = switch
    
    self.update = updates()
    
    print(f'Switch passed to function in layer1: {self.switch}')
    
  # strip 0,1,4 mute both mics to everywhere
  # strip 4 = mics_louder    
  def mute_mics(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()

      if self.switch:
        oai.apply({
          'in-0': dict(mute=True),
          'in-1': dict(mute=True),
          'in-4': dict(mute=True)
        })
        print("Mics muted")
        
      else:
        oai.apply({
          'in-0': dict(mute=False),
          'in-1': dict(mute=False),
          'in-4': dict(mute=False)
        })
        print("Mics unmuted")

      self.update.Button_State(self.macro, self.switch)
      
    return self.switch

  # vban 0,1 off disable mic to game but keep to disc
  # out bus 2,7 off to disable disc + mics to stream
  def only_discord(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      if self.switch:
        oai.set("vban.outstream[0].on", 0)
        oai.set("vban.outstream[1].on", 0)
        oai.outputs[2].mute = True
        oai.outputs[7].mute = True
          
        print("Only discord enabled")
      else:
        oai.set("vban.outstream[0].on", 1)
        oai.set("vban.outstream[1].on", 1)
        oai.outputs[2].mute = False
        oai.outputs[7].mute = False
          
        print("Only discord disabled")

      self.update.Button_State(self.macro, self.switch)
        
    return self.switch
    
  # bus 0,1 muted stops mics to game, discord
  # bus 3 left unmuted allowed mics_louder to stream
  # minor 3db pad on games + disc for speaking to stream
  def only_stream(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      if self.switch:
        oai.apply({
          'out-5': dict(mute=True),
          'out-6': dict(mute=True),
          'in-2': dict(gain=-3),
          'in-3': dict(gain=-3),
          'in-6': dict(gain=-3)
        })
        print("Only Stream Enabled")

      else:
        oai.apply({
          'out-5': dict(mute=False),
          'out-6': dict(mute=False),
          'in-2': dict(gain=0),
          'in-3': dict(gain=0),
          'in-6': dict(gain=0)
        })
        print("Only Stream Disabled")

      self.update.Button_State(self.macro, self.switch)    

    return self.switch
 
  # A1, B3 off stops mics_louder to streamlabs/gamecaster and iris stream
  # B1, B2 strip on and bus 0,1 out opened allows mics_louder over vban.
  def sound_test(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      if self.switch:
        oai.apply({
          'in-4': dict(A1=False, B1=True, B2=True, B3=False, mute=False),
          'out-5': dict(mute=False),
          'out-6': dict(mute=False)
        })
        print("Sound Test Enabled")

      else:
        oai.apply({
          'in-4': dict(A1=True, B1=False, B2=False, B3=True, mute=True),
          'out-5': dict(mute=True),
          'out-6': dict(mute=True)
        })
        print("Sound Test Disabled")

      send_vbantext.mic_test(self.switch)
      self.update.Button_State(self.macro, self.switch)
      
    return self.switch

  # only for updates. SOLO done through DAW
  def solo_onyx(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      self.update.Button_State(self.macro, self.switch)
    
    return self.switch

  # only for updates. SOLO done through DAW
  def solo_iris(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      self.update.Button_State(self.macro, self.switch)
    
    return self.switch

  # mute game pcs to stream for start scene
  # perhaps add call to subprocess to notify when stream goes live
  def start(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.inputs[2].mute = True
      oai.inputs[3].mute = True

      self.update.Button_State(self.macro, self.switch)    
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()  

    print("Start scene enabled.. ready to go live!")
    
    return self.switch

  def reset(self, default_states):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      print("Resetting to defaults...")
      oai.apply({
        'in-0': dict(B1=True, mute=True, gain=0),
        'in-1': dict(B2=True, mute=True, gain=0),
        'in-2': dict(A1=False, A5=True, mute=True, gain=0),
        'in-3': dict(A1=True, A5=True, mute=True, gain=0),
        'in-4': dict(A1=True, B3=True, mute=True, gain=0),
        'in-5': dict(mute=False, gain=0),
        'in-6': dict(mute=False, gain=0),
        'in-7': dict(mute=False, gain=0),
        'out-0': dict(mute=False, gain=0),
        'out-1': dict(mute=False, gain=0),
        'out-2': dict(mute=False, gain=0),
        'out-3': dict(mute=False, gain=0),
        'out-4': dict(mute=False, gain=0),
        'out-5': dict(mute=True, gain=0),
        'out-6': dict(mute=True, gain=0),
        'out-7': dict(mute=False, gain=0)
      })
      
      self.update.reset_Button_State(default_states)
      