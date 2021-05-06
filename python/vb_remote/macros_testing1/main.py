import duckypad
import voicemeeter
import keyboard

def initialize():
    reset = duckypad.Reset('reset', oai)
    reset.reset(macros)

def on_press(arg):
    for di in macros:
        if arg in macros[di]:
            print(f'{arg} = {macros[di][arg]}')


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

    scenes = {
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

    macros = {}
    macros['audio'] = audio
    macros['scenes'] = scenes
    macros['gamecaster'] = gamecaster

    reset =

    initialize()

    voicemeeter.launch(kind)

    with voicemeeter.remote(kind) as oai:
        for key in range(13, 19):
            keyboard.add_hotkey(f'F{key}', on_press, args=(f'F{key}',))
            keyboard.add_hotkey(f'{key - 12}', on_press, args=(f'F{key}',))
        for key in range(13, 21):
            keyboard.add_hotkey(f'ctrl+F{key}', on_press, args=(f'ctrl+F{key}',))
            keyboard.add_hotkey(f'ctrl+{key - 12}', on_press, args=(f'ctrl+F{key}',))


        print("Press CTRL+M to stop.")
        keyboard.wait('ctrl+M')
