import os
import time
from functools import wraps

PROJECT_DIR = os.path.realpath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..'))

def project_path(*parts):
    return os.path.join(PROJECT_DIR, *parts)

def merge_dicts(*srcs, dest={}):
    target = dest
    for src in srcs:
        for key, val in src.items():
            if isinstance(val, dict):
                node = target.setdefault(key, {})
                merge_dicts(val, dest=node)
            else:
                target[key] = val
    return target

def p_polling(func):
    """ check if recently cached was an updated value """
    @wraps(func)
    def wrapper(self, *args, **kwargs):
        param = args[0]
        if param in self.cache and self.cache[param][0]:
            self.cache[param][0] = False
            for i in range(self.max_polls):
                if self.pdirty:
                    return self.cache[param][1]
                time.sleep(self.delay)
        elif param in self.cache and self.pdirty:
            return self.cache[param][1]

        res = func(self, *args, **kwargs)
        self.cache[param] = [False, res]

        return self.cache[param][1]
    return wrapper

def m_polling(func):
    """ check if recently cached was an updated value """
    @wraps(func)
    def wrapper(self, *args):
        logical_id, mode = args
        param = f'mb_{logical_id}_{mode}'
        if param in self.cache and self.cache[param][0]:
            self.cache[param][0] = False
            for i in range(self.max_polls):
                if self.mdirty:
                    return self.cache[param][1]
                time.sleep(self.delay)
        elif param in self.cache and self.mdirty:
            return self.cache[param][1]

        res = func(self, *args)
        self.cache[f'mb_{logical_id}_{mode}'] = [False, res]

        return self.cache[param][1]
    return wrapper
