import macrobuttons
import voicemeeter
import argparse
import time

from sys import exit
from custom import FileOps


class MacroButtonRun:
    def __init__(self, layer, arg):
        """ set macro + switch vars, load save states,
        call desired class/method then update save states """
        self.layer = layer
        self.arg = arg
        self.this_macro = macros[self.layer][self.arg][0]
        self.switch = macros[self.layer][self.arg][1]

    def __enter__(self):
        """ get saved states from pickle file """
        self.saved_states = file_io.read_db()
        self.switch = 1 - self.saved_states[self.layer][self.arg][1]

        return self

    def run(self):
        """ call .run() for appropriate class """ 
        with voicemeeter.remote('potato') as oai:  
            by_class(self.this_macro, oai, self.switch).run()

    def __exit__(self, exc_type, exc_value, traceback):
        """ write updates to file """
        self.saved_states[self.layer][self.arg][1] = self.switch
        file_io.update_db(self.saved_states)

def reset():
    with voicemeeter.remote('potato') as oai:
        reset = macrobuttons.Reset('reset', oai)
        reset.reset(macros)
    file_io.update_db(macros)
    exit(False)


if __name__ == '__main__':
    """ Initiate the parser """
    parser = argparse.ArgumentParser()
    parser.add_argument('-audio', nargs=None,
    choices=['mm', 'od', 'os', 'st', 'so', 'si'])
    parser.add_argument('-scenes', nargs=None,
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

    file_io = FileOps(macros) 

    if args.reset:
        reset()

    elif args.audio:
        layer = 'audio'
        arg = args.audio

    elif args.scenes:
        layer = 'scenes'
        arg = args.scenes

    by_class = getattr(macrobuttons, layer.capitalize())

    with MacroButtonRun(layer, arg) as mb:
        mb.run()
