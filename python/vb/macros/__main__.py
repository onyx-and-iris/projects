import layerOne
import layerTwo

import argparse
import pickle


class fileOps:
  """ save/retrieve states to pickle file """
  def __init__(self, macros):
    self.db = macros
    self.file_db = 'macros.pkl'

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
  parser.add_argument('-mm', action='store_true')
  parser.add_argument('-od', action='store_true')
  parser.add_argument('-os', action='store_true')
  parser.add_argument('-st', action='store_true')
  parser.add_argument('-so', action='store_true')
  parser.add_argument('-si', action='store_true')
  parser.add_argument('-start', action='store_true')
  parser.add_argument('-reset', action='store_true')
  parser.add_argument('-brb', action='store_true')
  parser.add_argument('-oo', action='store_true')
  parser.add_argument('-io', action='store_true')
  parser.add_argument('-ds', action='store_true')
  parser.add_argument('-ob', action='store_true')
  parser.add_argument('-ib', action='store_true')
  parser.add_argument('-end', action='store_true')

  """ Read arguments from the command line """
  args = parser.parse_args()

  layer1 = {
      'mm': ['mute_mics', 1], 
      'od': ['only_discord', 0], 
      'os': ['only_stream', 1], 
      'st': ['sound_test', 0], 
      'so': ['solo_onyx', 0], 
      'si': ['solo_iris', 0], 
      'start': ['start', 0]
  }

  layer2 = {
      'brb': ['brb', 0], 
      'oo': ['onyx_only', 0], 
      'io': ['iris_only', 0], 
      'ds': ['dual_scene', 0], 
      'ob': ['onyx_big', 0], 
      'ib': ['iris_big', 0], 
      'end': ['end', 0]
  }

  layer3 = {}

  macros = {}
  macros['layer1'] = layer1
  macros['layer2'] = layer2
  macros['layer3'] = layer3
  
  fileIO = fileOps(macros) 

  for arg in vars(args):
    """ get macro layer """
    if (getattr(args, arg)) and arg == 'reset':
      macro = layerOne.macros('reset', 0)
      macro.reset(macros)
      
      break
    
    elif (getattr(args, arg)) and arg in macros['layer1']:
      print('Found an argument in layer ONE')
      this_macro = macros['layer1'][arg][0]
      switch = macros['layer1'][arg][1]
      
      print(f'This macro is {this_macro} and switch is {switch}')
      
      """ get saved states from pickle file """
      saved_state = fileIO.read_Db()['layer1'][arg][1]

      print(f'Saved state = {saved_state} and switch is {switch}')
      if switch == saved_state:
        switch = 1 - switch
        
      print(f'Switch afterwards {switch}')
      
      macro = layerOne.macros(this_macro, switch)
      by_method = (getattr(macro, this_macro))
      
      new_state = int(by_method())
      macros['layer1'][arg][1] = new_state

      break

    elif (getattr(args, arg)) and arg in macros['layer2']:
      print('Found an argument in layer TWO')
      this_macro = macros['layer2'][arg][0]
      switch = macros['layer2'][arg][1]

      print(f'This macro is {this_macro} and switch is {switch}')
      
      # get saved states from pickle file
      saved_state = fileIO.read_Db()['layer2'][arg][1]
      
      print(f'Saved state = {saved_state} and switch is {switch}')
      if switch == saved_state:
        switch = 1 - switch
        
      print(f'Switch afterwards {switch}')
      
      macro = layerTwo.macros(this_macro, switch)
      by_method = (getattr(macro, this_macro))
      
      new_state = int(by_method())
      macros['layer2'][arg][1] = new_state
      
      break

  """ update db. if save states not fetched will write reset """
  fileIO.update_Db(macros)
