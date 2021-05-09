import custom

def make(oai, sl):
    return (Reset(oai), Audio(oai), Scene(oai, sl))

def run(func):
    def wrapper(*args):
        self, *remaining = args
        self.macro = func.__name__
        self.id = self.button_map[self.macro]
        self.enabled = not self.oai.button[self.id].stateonly

        self.oai.show()
        func(*args)
        self.oai.button[self.id].stateonly = self.enabled

        if self.macro in dir(Scene):
            self.streamlabs.switch_to(self.macro.upper())
    return wrapper


class Macros:
    def __init__(self, oai):
        self.oai = oai
        self.button_map = {
        'mute_mics': 0, 'only_discord': 1, 'only_stream': 2,
        'sound_test': 10, 'solo_onyx': 11, 'solo_iris': 12,

        'onyx_only': 31, 'iris_only': 32, 'dual_scene': 40,
        'onyx_big': 41, 'iris_big': 42, 'start': 20,
        'brb': 30, 'end': 50, 'reset': 72
        }

class Audio(Macros):
    def __init__(self, oai):
        Macros.__init__(self, oai)

    @run
    def mute_mics(self):
        """
        strip 0,1,4 mute both mics to everywhere
        strip 4 = mics_louder
        """
        if self.enabled:
            self.oai.apply({
                'in-0': dict(mute=True),
                'in-1': dict(mute=True),
                'in-4': dict(mute=True)
            })
            print('Mics muted')

        else:
            self.oai.apply({
                'in-0': dict(mute=False),
                'in-1': dict(mute=False),
                'in-4': dict(mute=False)
            })
            print('Mics unmuted')

    @run
    def only_discord(self):
        """
        vban 0,1 off disable mic to game but keep to disc
        out bus 2,7 off to disable disc + mics to stream
        """
        if self.enabled:
            self.oai.vban_out[0].on = False
            self.oai.vban_out[1].on = False
            self.oai.outputs[2].mute = True
            self.oai.outputs[7].mute = True

            print("Only discord enabled")
        else:
            self.oai.vban_out[0].on = True
            self.oai.vban_out[1].on = True
            self.oai.outputs[2].mute = False
            self.oai.outputs[7].mute = False

            print('Only discord disabled')

    @run
    def only_stream(self):
        """
        bus 0,1 muted stops mics to game, discord
        bus 3 left unmuted allowed mics_louder to stream
        minor 3db pad on games + disc for speaking to stream
        """
        if self.enabled:
            self.oai.apply({
                'out-5': dict(mute=True),
                'out-6': dict(mute=True),
                'in-2': dict(gain=-3),
                'in-3': dict(gain=-3),
                'in-6': dict(gain=-3)
            })
            print('Only Stream Enabled')

        else:
            self.oai.apply({
                'out-5': dict(mute=False),
                'out-6': dict(mute=False),
                'in-2': dict(gain=0),
                'in-3': dict(gain=0),
                'in-6': dict(gain=0)
            })
            print('Only Stream Disabled')

    @run
    def sound_test(self):
        """
        A1, B3 off stops mics_louder to streamlabs/gamecaster and iris stream
        B1, B2 strip on and bus 0,1 out opened allows mics_louder over vban.
        """
        _set = \
        'Strip(0).A1=1; Strip(0).A2=1; Strip(0).B1=0; Strip(0).B2=0; Strip(0).mono=1;'
        _unset = \
        'Strip(0).A1=0; Strip(0).A2=0; Strip(0).B1=1; Strip(0).B2=1; Strip(0).mono=0;'

        if self.enabled:
            self.oai.apply({
                'in-4': dict(A1=False, B1=True, B2=True, B3=False, mute=False),
                'out-5': dict(mute=False),
                'out-6': dict(mute=False)
            })
            custom.vban_sendtext('onyx.local', _set, 6990, 'onyx_sound_t')
            custom.vban_sendtext('iris.local', _set, 6990, 'iris_sound_t')
            print('Sound Test Enabled')

        else:
            self.oai.apply({
                'in-4': dict(A1=True, B1=False, B2=False, B3=True, mute=True),
                'out-5': dict(mute=True),
                'out-6': dict(mute=True)
            })
            custom.vban_sendtext('onyx.local', _unset, 6990, 'onyx_sound_t')
            custom.vban_sendtext('iris.local', _unset, 6990, 'iris_sound_t')
            print('Sound Test Disabled')

    @run
    def solo_onyx(self):
        """ only for updates. SOLO done through DAW """
        print('Solo Onyx Enabled (Iris Muted)')

    @run
    def solo_iris(self):
        """ only for updates. SOLO done through DAW """
        print('Solo Iris Enabled (Onyx Muted)')

class Scene(Macros):
    def __init__(self, oai, sl):
        Macros.__init__(self, oai)
        self.streamlabs = sl

    @run
    def onyx_only(self):
        """
        unmute onyx pc mute iris pc
        and sets the scene to 'onyx_only'
        """
        self.oai.apply({
            'in-2': dict(mute=False),
            'in-3': dict(mute=True)
        })
        print('Only Onyx Scene enabled, Iris game pc muted')

    @run
    def iris_only(self):
        """
        unmute iris pc mute onyx pc
        and sets the scene to 'iris_only'
        """
        self.oai.apply({
            'in-2': dict(mute=True),
            'in-3': dict(mute=False)
        })
        print('Only Iris Scene enabled, Onyx game pc muted')

    @run
    def dual_scene(self):
        """
        Enable A5=1 in case was removed for review recording
        Unmute both game pcs
        """
        self.oai.apply({
            'in-2': dict(mute=False, gain=0),
            'in-3': dict(A5=1, mute=False, gain=0)
        })
        print('Dual Scene enabled')

    @run
    def onyx_big(self):
        """ -3db pad on iris game pc """
        self.oai.show()

        self.oai.apply({
            'in-2': dict(mute=False, gain=0),
            'in-3': dict(mute=False, gain=-3),
        })
        print('Onyx Big scene enabled')

    @run
    def iris_big(self):
        """ -3db pad on onyx game pc """
        self.oai.apply({
            'in-2': dict(mute=False, gain=-3),
            'in-3': dict(A5=1, mute=False, gain=0)
        })
        print('Iris Big enabled')

    @run
    def start(self):
        """ mute game pcs to stream for start scene """
        self.oai.inputs[2].mute = True
        self.oai.inputs[3].mute = True

        print('Start scene enabled.. ready to go live!')

    @run
    def brb(self):
        """ mutes both game pcs and sets the scene to 'BRB' """
        self.oai.apply({
            'in-2': dict(mute=True),
            'in-3': dict(mute=True)
        })
        print('BRB: game pcs muted')

    @run
    def end(self):
        """ mute both game pcs leave mics unmuted for byes """
        self.oai.inputs[2].mute = True
        self.oai.inputs[3].mute = True

        print('End scene enabled.')

class Reset(Macros):
    def __init__(self, oai):
        Macros.__init__(self, oai)

    def run(self, macropad, init):
        """ reset to default states """
        if init:
            print(f'Initializing states')

        self.apply()

        for layer in macropad:
            for key in macropad[layer]:
                for macro, default_state in macropad[layer][key].items():
                    id = self.button_map[macro]
                    self.oai.button[id].stateonly = default_state
                    if not init:
                        print(f'resetting {macro} to {default_state}')

    def apply(self):
        self.oai.setmulti({
            'in-0': dict(A1=False, A2=False, A3=False, A4=False, A5=False,
            B1=True, B2=False, B3=False,
            mono=False, solo=False, mute=True, gain=0),
            'in-1': dict(A1=False, A2=False, A3=False, A4=False, A5=False,
            B1=False, B2=True, B3=False,
            mono=False, solo=False, mute=True, gain=0),
            'in-2': dict(A1=False, A2=False, A3=False, A4=False, A5=True,
            B1=False, B2=False, B3=False,
            mono=False, solo=False, mute=True, gain=0),
            'in-3': dict(A1=False, A2=False, A3=False, A4=False, A5=True,
            B1=False, B2=False, B3=False,
            mono=False, solo=False, mute=True, gain=0),
            'in-4': dict(A1=False, A2=False, A3=False, A4=False, A5=False,
            B1=False, B2=False, B3=True,
            mono=False, solo=False, mute=True, gain=0),
            'in-5': dict(A1=False, A2=True, A3=False, A4=False, A5=False,
            B1=False, B2=False, B3=False,
            solo=False, mute=False, gain=0),
            'in-6': dict(A1=False, A2=False, A3=True, A4=False, A5=False,
            B1=False, B2=False, B3=False,
            solo=False, mute=False, gain=0),
            'in-7': dict(A1=False, A2=False, A3=False, A4=True, A5=False,
            B1=False, B2=False, B3=False,
            solo=False, mute=False, gain=0),

            'out-0': dict(mono=False, mute=False, gain=0),
            'out-1': dict(mono=False, mute=False, gain=0),
            'out-2': dict(mono=False, mute=False, gain=0),
            'out-3': dict(mono=False, mute=False, gain=0),
            'out-4': dict(mono=False, mute=False, gain=0),
            'out-5': dict(mono=False, mute=True, gain=0),
            'out-6': dict(mono=False, mute=True, gain=0),
            'out-7': dict(mono=False, mute=False, gain=0),

            'vban-out-0': dict(on=True),
            'vban-out-1': dict(on=True)
        })
