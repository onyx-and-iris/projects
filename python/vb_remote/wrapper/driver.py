from os import path
import sys
import platform
import ctypes

from .errors import VMRError

bits = 64 if sys.maxsize > 2**32 else 32
os = platform.system()

if os != 'Windows':
    raise VMRError('The vmr package only supports Windows')


DLL_NAME = f'VoicemeeterRemote{"64" if bits == 64 else ""}.dll'

vm_base = path.join(path.expandvars(
f'%ProgramFiles{"(x86)" if bits == 64 else ""}%'), 'VB', 'Voicemeeter'
)

def vm_subpath(*fragments):
    """ Returns a path based from Voicemeeter's install directory. """
    return path.join(vm_base, *fragments)

dll_path = vm_subpath(DLL_NAME)

if not path.exists(dll_path):
    raise VMRError(f'Could not find {DLL_NAME}')

dll = ctypes.cdll.LoadLibrary(dll_path)
