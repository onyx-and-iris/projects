import abc
from .errors import VMRError

class IVban(abc.ABC):
    """ Vban Base Class """
    @abc.abstractmethod
    def identifier(self):
        pass

    @abc.abstractmethod
    def enable(self):
        pass

class Vban(IVban):
    """ Vban Concrete Class """
    def __init__(self, remote, index, direction):
        self._remote = remote
        self.index = index
        self.direction = direction

    def setter(self, *args: list):
        self._remote.set(*args)

    def getter(self, *args: list):
        return self._remote.get(*args)

    @property
    def identifier(self):
        return f'vban.{self.direction}stream[{self.index}]'

    @property
    def enable(self):
        return (self.getter(f'{self.identifier}.on') == 1)

    @enable.setter
    def enable(self, val):
        if isinstance(val, bool):
            self.setter(f'{self.identifier}.on', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')