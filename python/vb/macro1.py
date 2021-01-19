# Our current layer 1 vb macros translated into python using this awesome wrapper:
# https://github.com/chvolkmann/voicemeeter-remote-python
# todo: layer 2 and 3

import sqlite3 as sl
import voicemeeter
import argparse

# create or connect to db
con = sl.connect('macros.db')

# Initiate the parser
parser = argparse.ArgumentParser()
parser.add_argument("-mm", action="store_true")
parser.add_argument("-od", action="store_true")
parser.add_argument("-os", action="store_true")
parser.add_argument("-st", action="store_true")
parser.add_argument("-oo", action="store_true")
parser.add_argument("-oi", action="store_true")
parser.add_argument("-start", action="store_true")

# Read arguments from the command line
args = parser.parse_args()

# Can be 'basic', 'banana' or 'potato'
kind = 'potato'

# Ensure that Voicemeeter is launched
# voicemeeter.launch(kind)


def update_db(upd, macro):
  print("{}{}".format("Updating value for row: ", macro))
  val = int(upd == True)

  sql = 'UPDATE macros1 SET value = ? WHERE macro = ?'
  data = [
  (val),(macro)
  ]
  
  con.execute(sql, data)
  con.commit()
  
# strip 0,1,4 mute both mics to everywhere
# strip 4 = mics_louder
def mute_mics(mute):
  if mute:
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

  update_db(mute, 'mute_mics')

# vban 0,1 off disable mic to game but keep to disc
# out bus 2,7 off to disable disc + mics to stream
def only_discord(odisc):
  if odisc:
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
      
  update_db(odisc, 'only_discord')
    
# bus 0,1 muted stops mics to game, discord
# bus 3 left unmuted allowed mics_louder to stream
# minor 3db pad on games + disc for speaking to stream
def only_stream(ostream):
  if ostream:
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
    
  update_db(ostream, 'only_stream')
 
# A1, B3 off stops mics_louder to streamlabs/gamecaster and iris stream
# B1, B2 strip on and bus 0,1 out opened allows mics_louder over vban.
# vban_text required here to set mics to open (not PTT) on game pcs
def sound_test(sound_t):
  if sound_t:
    oai.apply({
      'in-4': dict(A1=False, B1=True, B2=True, B3=False, mute=False),
      'out-5': dict(mute=False),
      'out-6': dict(mute=False)
    })
    
    print("Mic Test Enabled")

  else:
    oai.apply({
      'in-4': dict(A1=True, B1=False, B2=False, B3=True, mute=True),
      'out-5': dict(mute=True),
      'out-6': dict(mute=True)
    })
     
    print("Mic Test Disabled")
    
  update_db(sound_t, 'sound_test')
  
def only_onyx(oonyx):
  pass
  
def only_iris(oiris):
  pass

# mute game pcs to stream for start scene
# perhaps add call to subprocess to notify when stream goes live
def start():
  start = True
  oai.inputs[2].mute = True
  oai.inputs[3].mute = True
    
  update_db(start, 'start')
      
  print("Start scene enabled.. ready to go live!")
  
def reset():
  print("This is the reset function")
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
  
  # reset the db
  sql = 'UPDATE macros1 SET value = ? WHERE macro = ?'
  data = [
    (1, "mute_mics"), (0, "only_discord"), (1, "only_stream"), 
    (0, "sound_test"), ("NULL", "start")
  ]
 
  con.executemany(sql, data)
  con.commit()
  
#####################################
      
with voicemeeter.remote(kind) as oai:
  oai.show()
  
  # mics_mute
  if args.mm:
    mute=True
    # check db
    sql = 'SELECT value FROM macros1 WHERE macro = "mute_mics"'
    with con:
      row = list(con.execute(sql)) 
    
    if row[0][0]:
      mute=False

    mute_mics(mute)

  # only_discord    
  elif args.od:
    odisc=False
    # check db
    sql = 'SELECT value FROM macros1 WHERE macro = "only_discord"'
    with con:
      row = list(con.execute(sql))
    
    if not row[0][0]:
      odisc=True
      
    only_discord(odisc)
  
  # only_stream  
  elif args.os:
    ostream=True
    # check db
    sql = 'SELECT value FROM macros1 WHERE macro = "only_stream"'
    with con:
      row = list(con.execute(sql))
      
    if row[0][0]:
      ostream=False
      
    only_stream(ostream)
    
  elif args.st:
    sound_t=False
    #check db
    sql = 'SELECT value FROM macros1 WHERE macro = "sound_test"'
    with con:
      row = list(con.execute(sql))
      
    if not row[0][0]:
      sound_t=True
      
    sound_test(sound_t)
    
  elif args.oo:
    pass
    
  elif args.oi:
    pass
    
  # mute both game pcs to stream
  elif args.start:
    start()
  
  # reset db to default profile  
  else:
    reset()