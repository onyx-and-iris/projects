import abc
from .errors import VMRError

def channel_prop(param):
    """ A recorder channel out prop """
    def getter(self):
        return self.getter(f'recorder.{param}')
    def setter(self, val):
        if isinstance(val, bool):
            self.setter(f'recorder.{param}', 1 if val else 0)
        else:
            raise VMRError('Error True or False expected')
    return property(getter, setter)


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


    A1 = channel_prop('A1')
    A2 = channel_prop('A2')
    A3 = channel_prop('A3')
    A4 = channel_prop('A4')   
    A5 = channel_prop('A5')

    B1 = channel_prop('B1')
    B2 = channel_prop('B2')
    B3 = channel_prop('B3')

    def load(self, file: str):
        try:
            self.set('Recorder.load', file)
        except UnicodeError:
            raise VMRError('File full directory must be a raw string')
