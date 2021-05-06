import json
import logging
import pickle
import time

from websocket import create_connection, WebSocketTimeoutException


class Switchscene:
  def __init__(self):
    self.logger = logging.getLogger("slobsapi._SlobsWebSocket")
    self.tok_file = 'api_token.pkl'

  def switch_to(self, target):
    self.url = f"ws://localhost:59650/api/websocket"
    self.token = ''
    self._on_close = None
    self._sceneIDS = {}
    self.target = target

    try:
        with open(self.tok_file, 'rb') as retrieve_tok:
          self.token = pickle.load(retrieve_tok)

    except FileNotFoundError:
      self.store_tok()

    try:
        self.socket = create_connection(self.url, timeout=20)
    except ConnectionRefusedError as e:
        raise ProtocolError("Couldn't connect. Is StreamLabs OBS running? %s" % e)

    self._authenticate()

    self.send_message(8, "getScenes", {"resource": "ScenesService","args": []})
    response = self.receive_message()

    for num in range(len(response['result'])):
      name = response['result'][num]['name']
      id = response['result'][num]['id']

      self._sceneIDS[name] = id

    self._make_sceneActive(self._sceneIDS[target])

    self.close()

  def _get_activeID(self):
    self.send_message(8, "activeScene", {"resource": "ScenesService","args": []})

    response = self.receive_message()
    return response['result']['id']

  def _make_sceneActive(self, _id):
    self._id = _id
    self.send_message(8, "makeSceneActive", {"resource": "ScenesService","args": [self._id]})
    response = self.receive_message()

  def _authenticate(self) -> None:
      message_id = "auth_request"
      self.send_message(
          id_=message_id,
          method="auth",
          params=dict(resource="TcpServerService", args=[self.token]),
      )
      response = self.receive_message()

      if response["id"] != message_id:
          raise ProtocolError("Response id mismatch: %s" % response)
      if "result" not in response or response["result"] is not True:
          raise AuthenticationFailure("%s" % response)

  def send_message(self, id_, method, params) -> None:
      message_json = json.dumps(self._build_params_dict(id_, method, params))
      self.logger.debug("Sending:  %s", message_json)
      self.socket.send(message_json)

  @staticmethod
  def _build_params_dict(id_, method, params):
      request = {"jsonrpc": "2.0", "id": id_, "method": method, "params": params}
      return request

  def receive_message(self):
      while self.socket:
          try:
              raw_message = self.socket.recv()
              self.logger.debug("Received: %s", raw_message)
              if not raw_message:
                  break
              else:
                  try:
                      result = json.loads(raw_message)
                  except json.JSONDecodeError as json_error:
                      raise ProtocolError("%s from %s" % (json_error, raw_message))
                  except TypeError as type_error:
                      raise ProtocolError(type_error)
                  return result
          except WebSocketTimeoutException:
              self.logger.debug("Retrying after timeout.")
          except OSError as e:
              self.logger.warning(
                  "OSError received. Probably socket was closed. Retrying: %s", e
              )
              time.sleep(1)  # To prevent busy-loop

      return None

  def close(self) -> None:
      if self.socket:
          self.socket.close()
          self.socket = None

  def store_tok(self):
    password = input("Enter Streamlabs API Token\n")
    while True:
      try:
        with open(self.tok_file, 'wb') as save_tok:
          pickle.dump(password, save_tok)
        break

      except FileNotFoundError:
        save_tok = open(self.tok_file, 'x')
        save_tok.close()



if __name__ == '__main__':
  set_scene = Switchscene()
  set_scene.store_tok()
