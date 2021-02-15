import macrobuttons

import argparse
import pickle


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


def main(layer, arg):
  """ set macro + switch vars, load save states,
  call desired class/method then update save states """
  this_macro = macros[layer][arg][0]
  switch = macros[layer][arg][1]

  """ get saved states from pickle file """
  saved_states = fileIO.read_Db()
  saved_state = saved_states[layer][arg][1]

  if switch == saved_state:
    switch = 1 - switch
    
  """ Do we need Audio or Scenes class? Then instantiate """  
  by_class = getattr(macrobuttons, layer.capitalize())(this_macro, switch)
  
  """ Call desired method """
  getattr(by_class, this_macro)()

  saved_states[layer][arg][1] = switch

  """ write updates to file """
  fileIO.update_Db(saved_states)


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
    
    main(layer, arg)

  elif args.scenes:
    layer = 'scenes'
    arg = args.scenes[0]
    
    main(layer, arg)

  elif args.reset:
    macro = macrobuttons.Scenes('reset', 0)
    macro.reset(macros)
    fileIO.update_Db(macros)
    