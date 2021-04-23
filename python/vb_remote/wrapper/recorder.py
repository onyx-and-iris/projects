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

    def output(self, out_type: str, state: int):
        """ out_type should be 'A1', 'B2' etc """
        out_type, number = out_type
        if out_type not in ('A', 'B'):
            raise VMRError('Output type must be A or B')
        if state not in (0, 1):
            raise VMRError('State must be 0 or 1')   
        if out_type == 'A' and int(number) not in range(1, self._remote.num_A + 1) or \
        out_type == 'B' and int(number) not in range(1, self._remote.num_B + 1):
            raise VMRError('Strip/Bus out of range')

        self.set(f'recorder.{out_type}{number}', state)

    def load(self, file: str):
        try:
            self.set('Recorder.load', file)
        except UnicodeError:
            raise VMRError('File full directory must be a raw string')


class Recorder(IRecorder):
    """ Recorder Concrete Class """
    def __init__(self, remote):
        self._remote = remote

    def set(self, *args: list):
        self._remote.set(*args)

    def play(self , state: int=1):
        self.set('recorder.play', state)

    def stop(self, state: int=1):
        self.set('recorder.stop', state)

    def pause(self , state: int=1):
        self.set('recorder.pause', state)

    def replay(self , state: int=1):
        self.set('recorder.replay', state)
 
    def record(self , state: int=1):
        self.set('recorder.record', state)

    def loop(self, state: int=1):
        self.set('Recorder.mode.Loop', state)

    def ff(self, state: int=1):
        self.set('recorder.ff', state)

    def rw(self, state: int=1):
        self.set('recorder.rew', state)

