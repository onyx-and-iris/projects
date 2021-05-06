class Macros:
    def __init__(self, macro, oai, switch = None):
        self.oai = oai
        self.macro = macro
        self.switch = switch

        """ map macros to macrobutton ids """
        self.button_map = {
        'mute_mics': 0, 'only_discord': 1, 'only_stream': 2,
        'sound_test': 10, 'solo_onyx': 11, 'solo_iris': 12,

        'onyx_only': 31, 'iris_only': 32, 'dual_scene': 40,
        'onyx_big': 41, 'iris_big': 42, 'start': 20,
        'brb': 30, 'end': 50, 'reset': 72
        }
        self.id = self.button_map[self.macro]

class Reset(Macros):
    def __init__(self, macro, oai):
        Macros.__init__(self, macro, oai)

    def reset(self, default_states):
        """ reset to default states """
        self.oai.apply({
            'in-0': dict(B1=True, mute=True, gain=0),
            'in-1': dict(B2=True, mute=True, gain=0),
            'in-2': dict(A1=False, A5=True, mute=True, gain=0),
            'in-3': dict(A1=False, A5=True, mute=True, gain=0),
            'in-4': dict(A1=False, B3=True, mute=True, gain=0),
            'in-5': dict(mute=False, gain=0),
            'in-6': dict(mute=False, gain=0),
            'in-7': dict(mute=False, gain=0),
            'out-0': dict(mute=False, gain=0),
            'out-1': dict(mute=False, gain=0),
            'out-2': dict(mute=False, gain=0),
            'out-3': dict(mute=False, gain=0),
            'out-4': dict(mute=False, gain=0),
            'out-5': dict(mute=True, gain=0),
            'out-6': dict(mute=True, gain=0),
            'out-7': dict(mute=False, gain=0)
        })

        for layer in default_states:
            for key in default_states[layer]:
                default_macro, default_state, = default_states[layer].get(key)

                self.oai.button[self.id].stateonly = default_state
                print(f'resetting {default_macro} to {default_state}')
