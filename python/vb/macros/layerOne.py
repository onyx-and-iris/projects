# Our current layer 1 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 2 and 3
import voicemeeter

from custom import commands

class send_vbantext:
  def mic_test(upd):
    """ usage IP, COMMAND, PORT, COMMAND_NAME """ 
    set_t = 'Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;'
    unset_t = 'Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;'
    if upd:
      commands.VBAN_SendText('onyx.local', set_t, 6990, 'onyx_sound_t')
      commands.VBAN_SendText('iris.local', set_t, 6990, 'iris_sound_t')

    else:
      commands.VBAN_SendText('onyx.local', unset_t, 6990, 'onyx_sound_t')
      commands.VBAN_SendText('iris.local', unset_t, 6990, 'iris_sound_t')  


class macros:
  def __init__(self, macro, switch):
    self.macro = macro
    self.switch = switch

    
    """ map macro names to logical IDS """
    self.button_map = {
    'mute_mics': 0, 'only_discord': 1, 'only_stream': 2,
    'sound_test': 10, 'solo_onyx': 11, 'solo_iris': 12,
    'reset': 72
    }
    self.logical_id = self.button_map[self.macro]
    
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

      oai.button_state(self.logical_id, self.switch)
      
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

      oai.button_state(self.logical_id, self.switch)
        
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

      oai.button_state(self.logical_id, self.switch)   

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
      oai.button_state(self.logical_id, self.switch)
      
    return self.switch

  # only for updates. SOLO done through DAW
  def solo_onyx(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.button_state(self.logical_id, self.switch)
    
    return self.switch

  # only for updates. SOLO done through DAW
  def solo_iris(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.button_state(self.logical_id, self.switch)
    
    return self.switch
      