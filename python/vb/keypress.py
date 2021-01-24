# Sendkeys for Streamlabs using this awesome package:
# https://github.com/boppreh/keyboard
import time
import sys
sys.path.append("..")
from keyboard import keyboard

class sendkey:
  def __enter__(self):
      return self

  def __init__(self, macro):
    self.macro = macro
    
    self.actions = [
    ("start", 0), ("brb", 1), ("onyx_only", 2), ("iris_only", 3),
    ("dual_scene", 4), ("onyx_big", 5), ("iris_big", 6), ("end", 7)
    ]
    
  def action(self):
    for a, b in self.actions:
      if self.macro == a:
        run = 'alt+' + str(b)
        keyboard.press_and_release('shift+windows+1')
        keyboard.press(run)
        time.sleep(0.5)
        keyboard.release(run)
        
    exit

    
  def __exit__(self, exc_type, exc_val, exc_tb):
    return None