# param_name => is_numeric
from .errors import VMRError
from .channel import Channel, bool_prop, str_prop, float_prop

class OutputBus(Channel):
    """ Base class for output busses. """
    @classmethod
    def make(cls, is_physical, *args, **kwargs):
        """
        Factory function for output busses.

        Returns a physical/virtual strip for the remote's kind
        """
        OB_cls = PhysicalOutputBus if is_physical else VirtualOutputBus
        return OB_cls(*args, **kwargs)

    @property
    def identifier(self):
        return f'Bus[{self.index}]'

    mute = bool_prop('Mute')
    gain = float_prop('Gain', p_range=(-60,12))
    mono = bool_prop('Mono')
    eq = bool_prop('EQ.on')

class PhysicalOutputBus(OutputBus):
    pass

class VirtualOutputBus(OutputBus):
    pass
