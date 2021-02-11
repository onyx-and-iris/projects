import sys
import time
import pickle

sys.path.append('../')
from obswebsocket import obsws, requests

pass_file = "pwd.pkl"
class obs_sceneswitch:
  def __init__(self):
    self.pass_file = "pwd.pkl"

  def switch_to(self, name):
    host = "localhost"
    port = 4444
    
    try:
        with open(self.pass_file, 'rb') as retrieve_pass:
          password = pickle.load(retrieve_pass)
          retrieve_pass.close()

    except FileNotFoundError:
      create_pass()

    ws = obsws(host, port, password)
    ws.connect()

    try:
        scenes = ws.call(requests.GetSceneList())
        ws.call(requests.SetCurrentScene(name))

    except KeyboardInterrupt:
        pass

    ws.disconnect()
    
  def create_pass(self):
    password = input("Enter OBS websocket password\n")
    while True:
      try:
        with open(self.pass_file, 'wb') as save_pass:
          pickle.dump(password, save_pass)  
          save_pass.close()
          break
          
      except FileNotFoundError:
        save_pass = open(self.pass_file, 'x')
        save_pass.close()
  
if __name__ == '__main__':
  make_pass = obs_sceneswitch()
  make_pass.create_pass()