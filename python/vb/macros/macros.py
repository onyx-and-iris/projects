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
  parser.add_argument('-mm', action='store_true')
  parser.add_argument('-od', action='store_true')
  parser.add_argument('-os', action='store_true')
  parser.add_argument('-st', action='store_true')
  parser.add_argument('-so', action='store_true')
  parser.add_argument('-si', action='store_true')
  parser.add_argument('-oo', action='store_true')
  parser.add_argument('-io', action='store_true')
  parser.add_argument('-ds', action='store_true')
  parser.add_argument('-ob', action='store_true')
  parser.add_argument('-ib', action='store_true')
  parser.add_argument('-brb', action='store_true')
  parser.add_argument('-start', action='store_true')
  parser.add_argument('-end', action='store_true')
  parser.add_argument('-reset', action='store_true')

  """ Read arguments from the command line """
  args = parser.parse_args()

  layer1 = {
      'mm': ['mute_mics', 1], 
      'od': ['only_discord', 0], 
      'os': ['only_stream', 1], 
      'st': ['sound_test', 0], 
      'so': ['solo_onyx', 0], 
      'si': ['solo_iris', 0]
  }

  layer2 = { 
      'oo': ['onyx_only', 0], 
      'io': ['iris_only', 0], 
      'ds': ['dual_scene', 0], 
      'ob': ['onyx_big', 0], 
      'ib': ['iris_big', 0],
      'start': ['start', 0],
      'brb': ['brb', 0],
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
    arg_isTrue = (getattr(args, arg))
    _layers = ['layer1', 'layer2', 'layer3']

    if arg_isTrue:
      if arg == 'reset':
        macro = layerTwo.macros('reset', 0)
        macro.reset(macros)
        fileIO.update_Db(macros)
        break
      elif arg in macros[_layers[0]]:
        layer = _layers[0]
      elif arg in macros[_layers[1]]:  
        layer = _layers[1]
        
      this_macro = macros[layer][arg][0]
      switch = macros[layer][arg][1]
      
      """ get saved states from pickle file """
      saved_states = fileIO.read_Db()
      saved_state = saved_states[layer][arg][1]

      if switch == saved_state:
        switch = 1 - switch

      if layer == _layers[0]:
        macro = layerOne.macros(this_macro, switch)
      elif layer == _layers[1]:
        macro = layerTwo.macros(this_macro, switch)

      by_method = (getattr(macro, this_macro))

      new_state = int(by_method())
      saved_states[layer][arg][1] = new_state

      fileIO.update_Db(saved_states)

      break