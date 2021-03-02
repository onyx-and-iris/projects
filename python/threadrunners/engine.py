import sys
import threading
from queue import Queue
from attr import attrs, attrib


class Runner(threading.Thread):
    """ subclass of thread """
    def __init__(self):
        super().__init__(target=self.inventory)
        self.gear = Gear(baton = 0, stopwatch=0)
        self.tasks = Queue()

    def inventory(self):
        while True:
            task = self.tasks.get()
            if task == 'ready up':
                stocklist.give(to=self.gear, baton=1, stopwatch=4)
            elif task == 'return gear':
                self.gear.give(to=stocklist, baton=1, stopwatch=4)
            elif task == 'ending':
                return


@attrs
class Gear:
    """ gear per relay team """
    baton = attrib(default=0)
    stopwatch = attrib(default=0)

    def give(self, to:'Gear', baton=0, stopwatch=0):
        self.change(-baton, -stopwatch)
        to.change(baton, stopwatch)

    def change(self, baton, stopwatch):
            self.baton += baton
            self.stopwatch += stopwatch


if __name__ == '__main__':
    stocklist = Gear(baton=8, stopwatch=32)
    runners = [Runner() for i in range(12)]

    for runner in runners:
        for i in range(int(sys.argv[1])):
            runner.tasks.put('ready up')
            runner.tasks.put('return gear')
        runner.tasks.put('ending')

    print('Gear inventory before event:', stocklist)
    for runner in runners:
        runner.start()

    for runner in runners:
        runner.join()

    print('Gear inventory after event:', stocklist)
