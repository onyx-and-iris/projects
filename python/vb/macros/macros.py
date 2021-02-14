import layerOne
import layerTwo

import argparse
import pickle

from sys import stderr

class fileOps:
  """ save/retrieve states to pickle file """
  def __init__(self, macros):
    self.db = macros
    self.file_db = 'cache.pkl'

  def read_Db(self):
    while True:
      try:
        with open(self.file_db, 'rb') as records:
          self.db = pickle.load(records)
          records.close()
          break

      except FileNotFoundError:
        records = open(self.file_db, 'x')
        records.close()

      except EOFError:
        self.update_Db(self.db)
        break

    return self.db


  def update_Db(self, macros):
    with open(self.file_db, 'wb') as records:
      pickle.dump(macros, records)
      records.close


if __name__ == '__main__':
  """ Initiate the parser """
  parser = argparse.ArgumentParser()
  parser.add_argument('-audio', nargs=1,
  choices=['mm', 'od', 'os', 'st', 'so', 'si'])
  parser.add_argument('-scenes', nargs=1,
  choices=['oo', 'io', 'ds', 'ob', 'ib', 'start', 'brb', 'end'])
  parser.add_argument('-reset', action='store_true')

  """ Read arguments from the command line """
  args = parser.parse_args()

  audio = {
      'mm': ['mute_mics', 1], 
      'od': ['only_discord', 0], 
      'os': ['only_stream', 1], 
      'st': ['sound_test', 0], 
      'so': ['solo_onyx', 0], 
      'si': ['solo_iris', 0]
  }

  scenes = { 
      'oo': ['onyx_only', 0], 
      'io': ['iris_only', 0], 
      'ds': ['dual_scene', 0], 
      'ob': ['onyx_big', 0], 
      'ib': ['iris_big', 0],
      'start': ['start', 0],
      'brb': ['brb', 0],
      'end': ['end', 0]
  }

  gamecaster = {}

  macros = {}
  macros['audio'] = audio
  macros['scenes'] = scenes
  macros['gamecaster'] = gamecaster
  
  fileIO = fileOps(macros) 
    
  if args.audio:
    layer = 'audio'
    arg = args.audio[0]

  elif args.scenes:
    layer = 'scenes'
    arg = args.scenes[0]

  elif args.reset:
    macro = layerTwo.macros('reset', 0)
    macro.reset(macros)
    fileIO.update_Db(macros)

    exit()
    
  this_macro = macros[layer][arg][0]
  switch = macros[layer][arg][1]
  
  """ get saved states from pickle file """
  saved_states = fileIO.read_Db()
  saved_state = saved_states[layer][arg][1]

  if switch == saved_state:
    switch = 1 - switch
  
  if args.audio:
    macro = layerOne.macros(this_macro, switch)
  elif args.scenes:
    macro = layerTwo.macros(this_macro, switch)
  
  by_method = (getattr(macro, this_macro))

  new_state = int(by_method())
  saved_states[layer][arg][1] = new_state

  fileIO.update_Db(saved_states)