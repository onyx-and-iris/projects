import voicemeeter
import keyboard

def vol_up(vmr):
    vmr.strip[0].gain += 1

def vol_down(vmr):
    vmr.strip[0].gain -= 1

if __name__ == '__main__':
    kind = 'potato'

    voicemeeter.launch(kind)

    with voicemeeter.remote(kind) as vmr:
        keyboard.add_hotkey('F1', vol_up, args=(vmr,))
        keyboard.add_hotkey('F2', vol_down, args=(vmr,))


        print("Press CTRL+M to stop.")
        keyboard.wait('ctrl+M')
