import abc
from .errors import VMRError

class IRecorder(abc.ABC):
    """ Recorder Base Class """
    @abc.abstractmethod
    def play(self , state: int=1):
        pass
    @abc.abstractmethod
    def stop(self, state: int=1):
        pass
    @abc.abstractmethod  
    def pause(self , state: int=1):
        pass
    @abc.abstractmethod 
    def replay(self , state: int=1):
        pass
    @abc.abstractmethod  
    def record(self , state: int=1):
        pass
    @abc.abstractmethod  
    def loop(self, state: int=1):
        pass
    @abc.abstractmethod  
    def ff(self, state: int=1):
        pass
    @abc.abstractmethod  
    def rw(self, state: int=1):
        pass

    def load(self, file: str):
        try:
            self.set('Recorder.load', file)
        except UnicodeError:
            raise VMRError('File full directory must be a raw string')


class Recorder(IRecorder):
    """ Recorder Concrete Class """
    def __init__(self, remote):
        self._remote = remote

    def setter(self, *args: list):
        self._remote.set(*args)

    def getter(self, *args: list):
        return (self._remote.get(*args) == 1)

    def play(self , state: int=1):
        self.setter('recorder.play', state)

    def stop(self, state: int=1):
        self.setter('recorder.stop', state)

    def pause(self , state: int=1):
        self.setter('recorder.pause', state)

    def replay(self , state: int=1):
        self.setter('recorder.replay', state)
 
    def record(self , state: int=1):
        self.setter('recorder.record', state)

    def loop(self, state: int=1):
        self.setter('Recorder.mode.Loop', state)

    def ff(self, state: int=1):
        self.setter('recorder.ff', state)

    def rw(self, state: int=1):
        self.setter('recorder.rew', state)

    @property
    def A1(self):
        return self.getter(f'recorder.A1')

    @A1.setter
    def A1(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.A1', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def A2(self):
        return self.getter(f'recorder.A2')

    @A2.setter
    def A2(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.A2', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def A3(self):
        return self.getter(f'recorder.A3')

    @A3.setter
    def A3(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.A3', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def A4(self):
        return self.getter(f'recorder.A4')

    @A4.setter
    def A4(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.A4', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def A5(self):
        return self.getter(f'recorder.A5')

    @A5.setter
    def A5(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.A5', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def B1(self):
        return self.getter(f'recorder.B1')

    @B1.setter
    def B1(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.B1', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def B2(self):
        return self.getter(f'recorder.B2')

    @B2.setter
    def B2(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.B2', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')

    @property
    def B3(self):
        return self.getter(f'recorder.B3')

    @B3.setter
    def B3(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.B3', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')
