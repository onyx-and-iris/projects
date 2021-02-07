# Our current layer 2 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 3

import voicemeeter
import argparse
import keypress

from custom import commands


class updates():
  def __init__(self):
    """ map macro names to logical IDS """
    self.button_map = [
    ('brb', 30), ('onyx_only', 31), ('iris_only', 32),
    ('dual_scene', 40), ('onyx_big', 41), ('iris_big', 42),
    ('end', 50)
    ]

  def Button_State(self, macro, upd):
    for macro_name, logical_id in self.button_map:
      if macro_name == macro:
        print(f'Macro = {macro_name} Button ID = {logical_id} State = {upd}')
        commands.button_setState(logical_id, upd)
        
        break
      
  def reset_Button_State(self, data_def):
    """ run lists from default macros dict through button_state function """
    for arg, data in data_def['layer2'].items():
      print(f'{data[0]} {data[1]}')
      self.Button_State(data[0], data[1])

class macros():
  def __init__(self, macro, switch):
    self.macro = macro
    self.switch = switch
    
    self.update = updates()
    
    print(f'Switch passed to function in layer2: {self.switch}')
    
  # mutes both game pcs and sets the scene to 'BRB'
  def brb(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=True),
        'in-3': dict(mute=True)
      })
      print("BRB: mics are muted")

    self.update.Button_State(self.macro, self.switch)
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()  

    return self.switch

  # unmute onyx pc mute iris pc 
  # and sets the scene to 'onyx_only'
  def onyx_only(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.apply({
        'in-2': dict(mute=False),
        'in-3': dict(mute=True)
      })
      
    self.update.Button_State(self.macro, self.switch)      

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
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

    self.update.Button_State(self.macro, self.switch)      

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
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
      
    self.update.Button_State(self.macro, self.switch)
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
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
      
    self.update.Button_State(self.macro, self.switch)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
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
      
    self.update.Button_State(self.macro, self.switch)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Iris Big enabled")
    
    return self.switch
    
  # mute both game pcs leave mics unmuted for byes
  def end(self):
    with voicemeeter.remote('potato') as oai:
      oai.show()
      
      oai.inputs[2].mute = True
      oai.inputs[3].mute = True

    self.update.Button_State(self.macro, self.switch)    
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()  

    print("Start scene enabled.. ready to go live!")
    
    return self.switch