# Our current layer 2 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 3

import time
import subprocess
#import sqlite3 as sl
import voicemeeter
import argparse
import midipad
import keypress

# create or connect to db
#con = sl.connect('macros.db')

# Initiate the parser
parser = argparse.ArgumentParser()
parser.add_argument("-brb", action="store_true")
parser.add_argument("-oo", action="store_true")
parser.add_argument("-io", action="store_true")
parser.add_argument("-ds", action="store_true")
parser.add_argument("-ob", action="store_true")
parser.add_argument("-ib", action="store_true")
parser.add_argument("-end", action="store_true")

# Read arguments from the command line
args = parser.parse_args()

# Can be 'basic', 'banana' or 'potato'
kind = 'potato'

# Ensure that Voicemeeter is launched
#voicemeeter.launch(kind)

class updates():
  def update_db(macro, upd):
    val = int(upd == True)
    print("value to update the db with: {}".format(val))

    sql = 'UPDATE macros2 SET value = ? WHERE macro = ?'
    data = [
    (val),(macro)
    ]
    
    con.execute(sql, data)
    con.commit()
    print("Database updated")
    
  def update_Button_State(macro, upd):
    # Send midi signal to macropad
    with midipad.getType(macro, upd) as oai_midi:
      oai_midi.upd_type()  

class macros():
  def __init__(self, macro):
    self.macro = macro
    
  # mutes both game pcs and sets the scene to 'BRB'
  def brb(self):
    oai.apply({
      'in-2': dict(mute=True),
      'in-3': dict(mute=True)
    })
    print("BRB: mics are muted")

    updates.update_Button_State(self.macro, brb)
    #updates.update_db(self.macro, brb)
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()  

    print("BRB scene set, mics are muted!")

  # unmute onyx pc mute iris pc 
  # and sets the scene to 'onyx_only'
  def onyx_only(self):
    oai.apply({
      'in-2': dict(mute=False),
      'in-3': dict(mute=True)
    })

    updates.update_Button_State(self.macro, oonly)      
    #updates.update_db(self.macro, oonly)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Only Onyx Scene enabled, Iris mic muted")
    
  # unmute iris pc mute onyx pc 
  # and sets the scene to 'iris_only'
  def iris_only(self):
    oai.apply({
      'in-2': dict(mute=True),
      'in-3': dict(mute=False)
    })

    updates.update_Button_State(self.macro, ionly)      
    #updates.update_db(self.macro, ionly)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Only Iris Scene enabled, Iris mic muted")
 
  # Enable A5=1 in case was removed for review recording
  # Unmute both game pcs
  def dual_scene(self):
    oai.apply({
      'in-2': dict(mute=False, gain=0),
      'in-3': dict(A5=1, mute=False, gain=0)
    })    
    
    updates.update_Button_State(self.macro, d_scene)
    #updates.update_db(self.macro, d_scene)
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Daul Scene enabled")

  # only for updates. SOLO done through DAW
  def onyx_big(self):
    oai.apply({
      'in-2': dict(mute=False, gain=0),
      'in-3': dict(mute=False, gain=-3),
    })    
    
    updates.update_Button_State(self.macro, obig)
    #updates.update_db(self.macro, obig)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Onyx Big scene enabled")

  # only for updates. SOLO done through DAW
  def iris_big(self):
    oai.apply({
      'in-2': dict(mute=False, gain=-3),
      'in-3': dict(A5=1, mute=False, gain=0)
    })    
    
    updates.update_Button_State(self.macro, ibig)
    #updates.update_db(self.macro, ibig)

    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()
      
    print("Iris Big enabled")
    
  # mute both game pcs leave mics unmuted for byes
  def end(self):
    oai.inputs[2].mute = True
    oai.inputs[3].mute = True

    updates.update_Button_State(self.macro, end)    
    #updates.update_db(self.macro, end)
    
    with keypress.sendkey(self.macro) as oai_key:
      oai_key.action()  

    print("Start scene enabled.. ready to go live!")
    
  
#####################################
      
with voicemeeter.remote(kind) as oai:
  oai.show()

  # mics_mute
  if args.brb:
    brb = None 
      
    macro = macros("brb")
    macro.brb()

  # only_discord    
  elif args.oo:
    oonly=None
      
    macro = macros("onyx_only")      
    macro.onyx_only()
  
  # only_stream  
  elif args.io:
    ionly=None
      
    macro = macros("iris_only")  
    macro.iris_only()
    
  elif args.ds:
    d_scene=None
      
    macro = macros("dual_scene")    
    macro.dual_scene()
    
  elif args.ob:
    obig = None
        
    macro = macros("onyx_big")        
    macro.onyx_big()
    
  elif args.ib:
    ibig = None

    macro = macros("iris_big")    
    macro.iris_big()
    
  # mute both game pcs to stream
  elif args.end:
    end = None
    
    macro = macros("end") 
    macro.end()