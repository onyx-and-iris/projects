import macrobuttons
import voicemeeter
import argparse

from sys import exit
from custom import FileOps

def reset():
    with voicemeeter.remote('potato') as oai:
        reset = macrobuttons.Reset('reset', 0, oai)
        reset.reset(macros)
    file_io.update_db(macros)
    exit()

def main(layer, arg):
    """ set macro + switch vars, load save states,
    call desired class/method then update save states """
    this_macro = macros[layer][arg][0]
    switch = macros[layer][arg][1]

    """ get saved states from pickle file """
    saved_states = file_io.read_db()
    saved_state = saved_states[layer][arg][1]

    if switch == saved_state:
        switch = 1 - switch

    """ Do we need Audio or Scenes class? Then instantiate """    
    by_class = getattr(macrobuttons, layer.capitalize())

    with voicemeeter.remote('potato') as oai:
        """ call .run() for appropriate class """    
        by_class(this_macro, switch, oai).run()

    saved_states[layer][arg][1] = switch

    """ write updates to file """
    file_io.update_db(saved_states)


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
        
    main(layer, arg)