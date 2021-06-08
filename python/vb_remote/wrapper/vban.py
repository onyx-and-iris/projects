import abc
from .errors import VMRError


class IVban(abc.ABC):
    """ Vban Base Class """
    @abc.abstractmethod
    def identifier(self):
        pass

    @abc.abstractmethod
    def on(self):
        pass

    @abc.abstractmethod
    def name(self):
        pass

    @abc.abstractmethod
    def ip(self):
        pass

    @abc.abstractmethod
    def sr(self):
        pass

    @abc.abstractmethod
    def channel(self):
        pass

    @abc.abstractmethod
    def bit(self):
        pass

    @abc.abstractmethod
    def quality(self):
        pass

    @abc.abstractmethod
    def route(self):
        pass


class Vban(IVban):
    """ Vban Concrete Class """
    def __init__(self, remote, index: int, direction: str):
        self._remote = remote
        self.index = index
        self.direction = direction

    def setter(self, *args: list):
        self._remote.set(*args)

    def getter(self, *args: list, **kwargs):
        return self._remote.get(*args)

    @property
    def identifier(self):
        return f'vban.{self.direction}stream[{self.index}]'

    @property
    def on(self):
        return (self.getter(f'{self.identifier}.on') == 1)

    @on.setter
    def on(self, val: bool):
        if isinstance(val, bool):
            self.setter(f'{self.identifier}.on', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def name(self):
        return self.getter(f'{self.identifier}.name', string=True)

    @name.setter
    def name(self, val):
        if isinstance(val, str):
            self.setter(f'{self.identifier}.name', val)
        else:
            raise VMRError('Error a string expected')

    @property
    def ip(self):
        return self.getter(f'{self.identifier}.ip', string=True)

    @ip.setter
    def ip(self, val):
        if isinstance(val, str):
            self.setter(f'{self.identifier}.ip', val)
        else:
            raise VMRError('Error a string expected')

    @property
    def port(self):
        return int(self.getter(f'{self.identifier}.port'))

    @port.setter
    def port(self, val):
        if isinstance(val, int) and val in range(1024, 65536):
            self.setter(f'{self.identifier}.port', val)
        else:
            raise VMRError('Error expected value from 1024 to 65535')

    @property
    def sr(self):
        return int(self.getter(f'{self.identifier}.sr'))

    @sr.setter
    def sr(self, val):
        if self.direction == 'in':
            raise VMRError('Error, read only value')
        opts = \
        (11025, 16000, 22050, 24000, 32000, 44100, 48000, 64000, 88200, 96000)
        if isinstance(val, int) and val in opts:
            self.setter(f'{self.identifier}.sr', val)
        else:
            raise VMRError('Error expected one of: {opts}')

    @property
    def channel(self):
        return int(self.getter(f'{self.identifier}.channel'))

    @channel.setter
    def channel(self, val):
        if self.direction == 'in':
            raise VMRError('Error, read only value')
        if isinstance(val, int) and val in range(1, 9):
            self.setter(f'{self.identifier}.channel', val)
        else:
            raise VMRError('Error expected value from 1 to 8')

    @property
    def bit(self):
        return 16 if (int(self.getter(f'{self.identifier}.bit') == 1)) else 24

    @bit.setter
    def bit(self, val):
        if self.direction == 'in':
            raise VMRError('Error, read only value')
        if isinstance(val, int) and val in (16, 24):
            self.setter(f'{self.identifier}.bit', 1 if (val == 16) else 2)
        else:
            raise VMRError('Error expected value 16 or 24')

    @property
    def quality(self):
        return int(self.getter(f'{self.identifier}.quality'))

    @quality.setter
    def quality(self, val):
        if isinstance(val, int) and val in range(5):
            self.setter(f'{self.identifier}.quality', val)
        else:
            raise VMRError('Error expected value from 0 to 4')

    @property
    def route(self):
        return int(self.getter(f'{self.identifier}.route'))

    @route.setter
    def route(self, val):
        if isinstance(val, int) and val in range(9):
            self.setter(f'{self.identifier}.route', val)
        else:
            raise VMRError('Error expected value from 0 to 8')
