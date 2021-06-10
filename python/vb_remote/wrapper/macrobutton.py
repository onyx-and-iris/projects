import abc
from .errors import VMRError

class IMacroButton(abc.ABC):
    """ MacroButtons Base Class """
    @abc.abstractmethod
    def state(self):
        pass

    @abc.abstractmethod
    def stateonly(self):
        pass

    @abc.abstractmethod
    def trigger(self):
        pass


class MacroButton(IMacroButton):
    """ MacroButtons Concrete Class """
    def __init__(self, remote, index):
        self._remote = remote
        self.index = index

    def setter(self, *args: list):
        self._remote.button_setstatus(*args)

    def getter(self, *args: list):
        return (self._remote.button_getstatus(*args) == 1)

    @property
    def state(self):
        return self.getter(self.index, 1)

    @state.setter
    def state(self, val):
        if isinstance(val, bool):
            self.setter(self.index, 1 if val else 0, 1)
        else:
            raise VMRError('Error True or False expected')

    @property
    def stateonly(self):
        return self.getter(self.index, 2)

    @stateonly.setter
    def stateonly(self, val):
        if isinstance(val, bool):
            self.setter(self.index, 1 if val else 0, 2)
        else:
            raise VMRError('Error True or False expected')

    @property
    def trigger(self):
        return self.getter(self.index, 3)

    @trigger.setter
    def trigger(self, val):
        if isinstance(val, bool):
            self.setter(self.index, 1 if val else 0, 3)
        else:
            raise VMRError('Error True or False expected')
