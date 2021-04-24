# Sendkeys for Streamlabs using this awesome package:
# https://github.com/boppreh/keyboard
import time
import sys
import keyboard
import macrobuttons
import voicemeeter
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

def on_press(key):
    if key in options_audio:       
        with MacroButtonRun('audio', key) as mb: 
            by_class = getattr(macrobuttons, mb.layer.capitalize())
            by_class(mb.this_macro, oai, mb.switch).run()
    elif key in options_scenes:
        with MacroButtonRun('scenes', key) as mb: 
            by_class = getattr(macrobuttons, mb.layer.capitalize())
            by_class(mb.this_macro, oai, mb.switch).run()

if __name__ == '__main__':
    audio = {
        'F13': ['mute_mics', 1], 
        'F14': ['only_discord', 0], 
        'F15': ['only_stream', 1], 
        'F16': ['sound_test', 0], 
        'F17': ['solo_onyx', 0], 
        'F18': ['solo_iris', 0]
    }

    scenes = { 
        'ctrl+F13': ['onyx_only', 0], 
        'ctrl+F14': ['iris_only', 0], 
        'ctrl+F15': ['dual_scene', 0], 
        'ctrl+F16': ['onyx_big', 0], 
        'ctrl+F17': ['iris_big', 0],
        'ctrl+F18': ['start', 0],
        'ctrl+F19': ['brb', 0],
        'ctrl+F20': ['end', 0]
    }

    gamecaster = {}

    macros = {}
    macros['audio'] = audio
    macros['scenes'] = scenes
    macros['gamecaster'] = gamecaster

    file_io = FileOps(macros)

    options_audio = (
        'F13', 'F14', 'F15', 'F16', 'F17', 'F18',
        '1', '2', '3', '4', '5', '6'
        )
    options_scenes = (
        'ctrl+F13', 'ctrl+F14', 'ctrl+F15', 'ctrl+F16', 'ctrl+F17', 
        'ctrl+F18', 'ctrl+F19', 'ctrl+F20',
        'ctrl+1', 'ctrl+2', 'ctrl+3', 'ctrl+4', 'ctrl+5', 'ctrl+6', 
        'ctrl+7', 'ctrl+8'
        )


    with voicemeeter.remote('potato') as oai:
        for key in range(13, 19):
            keyboard.add_hotkey(f'F{key}', on_press, args=(f'F{key}',))
        for key in range(13, 21):
            keyboard.add_hotkey(f'ctrl+F{key}', on_press, args=(f'ctrl+F{key}',))

        for key in range(1, 7):
            keyboard.add_hotkey(f'{key}', on_press, args=(f'F{key + 12}',))
        for key in range(1, 9):
            keyboard.add_hotkey(f'ctrl+{key}', on_press, args=(f'ctrl+F{key + 12}',))

        print("Press ENTER to stop.")
        keyboard.wait('enter')
