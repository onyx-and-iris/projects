import voicemeeter
import keyboard
import duckypad
import streamlabs

def initialize(init = True):
    reset.run(macropad, init)

def on_press(arg):
    if arg == 'ctrl+F21':
        initialize(False)
        return None
    for di in macropad:
        if arg in macropad[di]:
            for macro in macropad[di][arg]:
                eval(f'{di}.{macro}()')


if __name__ == '__main__':
    kind = 'potato'

    audio = {
        'F13': {'mute_mics': True},
        'F14': {'only_discord': False},
        'F15': {'only_stream': True},
        'F16': {'sound_test': False},
        'F17': {'solo_onyx': False},
        'F18': {'solo_iris': False}
    }

    scene = {
        'ctrl+F13': {'onyx_only': False},
        'ctrl+F14': {'iris_only': False},
        'ctrl+F15': {'dual_scene': False},
        'ctrl+F16': {'onyx_big': False},
        'ctrl+F17': {'iris_big': False},
        'ctrl+F18': {'start': False},
        'ctrl+F19': {'brb': False},
        'ctrl+F20': {'end': False}
    }

    gamecaster = {}

    macropad = {}
    macropad['audio'] = audio
    macropad['scene'] = scene
    macropad['gamecaster'] = gamecaster

    voicemeeter.launch(kind)

    with voicemeeter.remote(kind) as oai:
        with streamlabs.SLOBS() as sl:
            reset, audio, scene = duckypad.make(oai, sl)
            initialize()

            for key in range(13, 19):
                keyboard.add_hotkey(f'F{key}', on_press, args=(f'F{key}',))
                keyboard.add_hotkey(f'{key - 12}', on_press, args=(f'F{key}',))
            for key in range(13, 22):
                keyboard.add_hotkey(f'ctrl+F{key}', on_press, args=(f'ctrl+F{key}',))
                keyboard.add_hotkey(f'ctrl+{key - 12}', on_press, args=(f'ctrl+F{key}',))


            print("Press CTRL+M to stop.")
            keyboard.wait('ctrl+M')
