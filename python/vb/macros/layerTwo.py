# Our current layer 2 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 3

import voicemeeter
import keypress

from custom import commands


class macros:
  def __init__(self, macro, switch):
    self.macro = macro
    self.switch = switch

    self.sendkey = keypress.sendkey(self.macro)
    
    """ map macro names to logical IDS """
    self.button_map = {
    'mute_mics': 0, 'only_discord': 1, 'only_stream': 2,
    'sound_test': 10, 'solo_onyx': 11, 'solo_iris': 12,

    'onyx_only': 31, 'iris_only': 32, 'dual_scene': 40,
    'onyx_big': 41, 'iris_big': 42, 'start': 20,
    'brb': 30, 'end': 50, 'reset': 72
    }
    self.logical_id = self.button_map[self.macro]

  # unmute onyx pc mute iris pc 
  # and sets the scene to 'onyx_only'
  def onyx_only(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=False),
        'in-3': dict(mute=True)
      })
      
      oai.button_state(self.logical_id, self.switch)      

    self.sendkey.action()
      
    print("Only Onyx Scene enabled, Iris mic muted")
    
    return self.switch
    
  # unmute iris pc mute onyx pc 
  # and sets the scene to 'iris_only'
  def iris_only(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=True),
        'in-3': dict(mute=False)
      })

      oai.button_state(self.logical_id, self.switch)     

    self.sendkey.action()
      
    print("Only Iris Scene enabled, Iris mic muted")
    
    return self.switch
 
  # Enable A5=1 in case was removed for review recording
  # Unmute both game pcs
  def dual_scene(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=False, gain=0),
        'in-3': dict(A5=1, mute=False, gain=0)
      })    
      
      oai.button_state(self.logical_id, self.switch)
    
    self.sendkey.action()
      
    print("Daul Scene enabled")
    
    return self.switch

  # only for updates. SOLO done through DAW
  def onyx_big(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=False, gain=0),
        'in-3': dict(mute=False, gain=-3),
      })    
      
      oai.button_state(self.logical_id, self.switch)

    self.sendkey.action()

    print("Onyx Big scene enabled")
    
    return self.switch

  # only for updates. SOLO done through DAW
  def iris_big(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=False, gain=-3),
        'in-3': dict(A5=1, mute=False, gain=0)
      })    
      
      oai.button_state(self.logical_id, self.switch)

    self.sendkey.action()
      
    print("Iris Big enabled")
    
    return self.switch
    
  # mute game pcs to stream for start scene
  # perhaps add call to subprocess to notify when stream goes live
  def start(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.inputs[2].mute = True
      oai.inputs[3].mute = True

      oai.button_state(self.logical_id, self.switch)    
    
    self.sendkey.action() 

    print("Start scene enabled.. ready to go live!")
    
    return self.switch

  # mutes both game pcs and sets the scene to 'BRB'
  def brb(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=True),
        'in-3': dict(mute=True)
      })
      print("BRB: mics are muted")

      oai.button_state(self.logical_id, self.switch)

    self.sendkey.action()

    return self.switch

  # mute both game pcs leave mics unmuted for byes
  def end(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.inputs[2].mute = True
      oai.inputs[3].mute = True

      oai.button_state(self.logical_id, self.switch)    
    
    self.sendkey.action()

    print("Start scene enabled.. ready to go live!")
    
    return self.switch

  def reset(self, default_states):
    with voicemeeter.remote('potato') as oai:
      oai.show()

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
      

      for key in default_states['layer1']:
        default_macro, default_state, = default_states['layer1'].get(key)
        logical_id = self.button_map[default_macro]
        
        oai.button_stateOnly(logical_id, default_state)
        print(f'resetting {default_macro} to {default_state}')

      for key in default_states['layer2']:
        default_macro, default_state, = default_states['layer2'].get(key)
        logical_id = self.button_map[default_macro]
        
        oai.button_stateOnly(logical_id, default_state)
        print(f'resetting {default_macro} to {default_state}')
