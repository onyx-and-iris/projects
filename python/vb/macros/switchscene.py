import sys
import time

sys.path.append('../')
from obswebsocket import obsws, requests

def switch_to(name):
  host = "localhost"
  port = 4444
  password = "52RKcvcglccfcurveiucebrunjjdbitv"

  ws = obsws(host, port, password)
  ws.connect()

  try:
      scenes = ws.call(requests.GetSceneList())
      ws.call(requests.SetCurrentScene(name))

  except KeyboardInterrupt:
      pass

  ws.disconnect()