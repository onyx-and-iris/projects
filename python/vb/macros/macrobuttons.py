# Our current layer 1 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 2 and 3
import switchscene

from custom import commands

      
class Macros:
  def __init__(self, macro, switch, oai):
    self.macro = macro
    self.switch = switch
    self.oai = oai
 
    self.set_scene = switchscene.Switchscene()

    """ map macro names to logical IDS """
    self.button_map = {
    'mute_mics': 0, 'only_discord': 1, 'only_stream': 2,
    'sound_test': 10, 'solo_onyx': 11, 'solo_iris': 12,

    'onyx_only': 31, 'iris_only': 32, 'dual_scene': 40,
    'onyx_big': 41, 'iris_big': 42, 'start': 20,
    'brb': 30, 'end': 50, 'reset': 72
    }
    self.logical_id = self.button_map[self.macro]
    

class Audio(Macros):
  def __init__(self, macro, switch, oai):
    Macros.__init__(self, macro, switch, oai)
    
  # strip 0,1,4 mute both mics to everywhere
  # strip 4 = mics_louder    
  def mute_mics(self):
    self.oai.show()

    if self.switch:
      self.oai.apply({
        'in-0': dict(mute=True),
        'in-1': dict(mute=True),
        'in-4': dict(mute=True)
      })
      print("Mics muted")
      
    else:
      self.oai.apply({
        'in-0': dict(mute=False),
        'in-1': dict(mute=False),
        'in-4': dict(mute=False)
      })
      print("Mics unmuted")

    self.oai.button_stateOnly(self.logical_id, self.switch)

  # vban 0,1 off disable mic to game but keep to disc
  # out bus 2,7 off to disable disc + mics to stream
  def only_discord(self):
    self.oai.show()
    
    if self.switch:
      self.oai.set("vban.outstream[0].on", 0)
      self.oai.set("vban.outstream[1].on", 0)
      self.oai.outputs[2].mute = True
      self.oai.outputs[7].mute = True
        
      print("Only discord enabled")
    else:
      self.oai.set("vban.outstream[0].on", 1)
      self.oai.set("vban.outstream[1].on", 1)
      self.oai.outputs[2].mute = False
      self.oai.outputs[7].mute = False
        
      print("Only discord disabled")

    self.oai.button_stateOnly(self.logical_id, self.switch)
    
  # bus 0,1 muted stops mics to game, discord
  # bus 3 left unmuted allowed mics_louder to stream
  # minor 3db pad on games + disc for speaking to stream
  def only_stream(self):
    self.oai.show()
    
    if self.switch:
      self.oai.apply({
        'out-5': dict(mute=True),
        'out-6': dict(mute=True),
        'in-2': dict(gain=-3),
        'in-3': dict(gain=-3),
        'in-6': dict(gain=-3)
      })
      print("Only Stream Enabled")

    else:
      self.oai.apply({
        'out-5': dict(mute=False),
        'out-6': dict(mute=False),
        'in-2': dict(gain=0),
        'in-3': dict(gain=0),
        'in-6': dict(gain=0)
      })
      print("Only Stream Disabled")

    self.oai.button_stateOnly(self.logical_id, self.switch)   
 
  # A1, B3 off stops mics_louder to streamlabs/gamecaster and iris stream
  # B1, B2 strip on and bus 0,1 out opened allows mics_louder over vban.
  def sound_test(self):
    _set = 'Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;',
    _unset = 'Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;'
    
    self.oai.show()
    
    if self.switch:
      self.oai.apply({
        'in-4': dict(A1=False, B1=True, B2=True, B3=False, mute=False),
        'out-5': dict(mute=False),
        'out-6': dict(mute=False)
      })
      commands.VBAN_SendText('onyx.local', _set, 6990, 'onyx_sound_t')
      commands.VBAN_SendText('iris.local', _set, 6990, 'iris_sound_t')
      print("Sound Test Enabled")

    else:
      self.oai.apply({
        'in-4': dict(A1=True, B1=False, B2=False, B3=True, mute=True),
        'out-5': dict(mute=True),
        'out-6': dict(mute=True)
      })
      commands.VBAN_SendText('onyx.local', _unset, 6990, 'onyx_sound_t')
      commands.VBAN_SendText('iris.local', _unset, 6990, 'iris_sound_t')
      print("Sound Test Disabled")

    self.oai.button_stateOnly(self.logical_id, self.switch)

  # only for updates. SOLO done through DAW
  def solo_onyx(self):
    self.oai.show()
    
    self.oai.button_stateOnly(self.logical_id, self.switch)

  # only for updates. SOLO done through DAW
  def solo_iris(self):
    self.oai.show()
    
    self.oai.button_stateOnly(self.logical_id, self.switch)
      
class Scenes(Macros):
  def __init__(self, macro, switch):
    Macros.__init__(self, macro, switch)

  # unmute onyx pc mute iris pc 
  # and sets the scene to 'onyx_only'
  def onyx_only(self):
    self.oai.show()
  
    self.oai.apply({
      'in-2': dict(mute=False),
      'in-3': dict(mute=True)
    })

    self.oai.button_stateOnly(self.logical_id, self.switch)      

    self.set_scene.switch_to(self.macro.upper())

    print("Only Onyx Scene enabled, Iris mic muted")

  # unmute iris pc mute onyx pc 
  # and sets the scene to 'iris_only'
  def iris_only(self):
    self.oai.show()

    self.oai.apply({
      'in-2': dict(mute=True),
      'in-3': dict(mute=False)
    })

    self.oai.button_stateOnly(self.logical_id, self.switch)     

    self.set_scene.switch_to(self.macro.upper())
      
    print("Only Iris Scene enabled, Iris mic muted")
 
  # Enable A5=1 in case was removed for review recording
  # Unmute both game pcs
  def dual_scene(self):
    self.oai.show()
    
    self.oai.apply({
      'in-2': dict(mute=False, gain=0),
      'in-3': dict(A5=1, mute=False, gain=0)
    })    
    
    self.oai.button_stateOnly(self.logical_id, self.switch)
    
    self.set_scene.switch_to(self.macro.upper())
      
    print("Daul Scene enabled")

  # only for updates. SOLO done through DAW
  def onyx_big(self):
    self.oai.show()
    
    self.oai.apply({
      'in-2': dict(mute=False, gain=0),
      'in-3': dict(mute=False, gain=-3),
    })    
    
    self.oai.button_stateOnly(self.logical_id, self.switch)

    self.set_scene.switch_to(self.macro.upper())

    print("Onyx Big scene enabled")

  # only for updates. SOLO done through DAW
  def iris_big(self):
    self.oai.show()
    
    self.oai.apply({
      'in-2': dict(mute=False, gain=-3),
      'in-3': dict(A5=1, mute=False, gain=0)
    })    
    
    self.oai.button_stateOnly(self.logical_id, self.switch)

    self.set_scene.switch_to(self.macro.upper())
      
    print("Iris Big enabled")
    
  # mute game pcs to stream for start scene
  def start(self):
    self.oai.show()
    
    self.oai.inputs[2].mute = True
    self.oai.inputs[3].mute = True

    self.oai.button_stateOnly(self.logical_id, self.switch)    
    
    self.set_scene.switch_to(self.macro.upper()) 

    print("Start scene enabled.. ready to go live!")

  # mutes both game pcs and sets the scene to 'BRB'
  def brb(self):
    self.oai.show()
    
    self.oai.apply({
      'in-2': dict(mute=True),
      'in-3': dict(mute=True)
    })
    print("BRB: game pcs muted")

    self.oai.button_stateOnly(self.logical_id, self.switch)

    self.set_scene.switch_to(self.macro.upper())

  # mute both game pcs leave mics unmuted for byes
  def end(self):
    self.oai.show()
    
    self.oai.inputs[2].mute = True
    self.oai.inputs[3].mute = True

    self.oai.button_stateOnly(self.logical_id, self.switch)    
    
    self.set_scene.switch_to(self.macro.upper())

    print("Start scene enabled.. ready to go live!")

  def reset(self, default_states):
    self.oai.show()

    self.oai.apply({
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
    

    for key in default_states['audio']:
      default_macro, default_state, = default_states['audio'].get(key)
      logical_id = self.button_map[default_macro]
      
      self.oai.button_stateOnly(logical_id, default_state)
      print(f'resetting {default_macro} to {default_state}')

    for key in default_states['scenes']:
      default_macro, default_state, = default_states['scenes'].get(key)
      logical_id = self.button_map[default_macro]
      
      self.oai.button_stateOnly(logical_id, default_state)
      print(f'resetting {default_macro} to {default_state}')