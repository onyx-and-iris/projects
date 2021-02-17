import asyncio
import logging
import math
import pickle

import socket

from pyslobs import SlobsConnection, ScenesService, ITransform

class Spinnable:
    """Perform the necessary trigonometry to make the item spin around
    its centre, rather than spin around the top-left corner.

    You need to know:
        * The origin is in the top-left.
        * The shape is rotated before it is positioned.
        * The shape is rotated CLOCKWISE in DEGREES around its top left
          corner

    This computes the angle (in radians) between the top edge and the
    line the connects the top left to the centre.

    It adds the new angle to it to find how far away the centre would have
    moved by the rotation, and then offsets the position by that amount
    to compensate.
    """

    def __init__(self, item, transform, size):

        self.item = item
        self.original_transform = transform
        self.original_size = size
        self.center = (
            int(size[0] * transform.scale["x"] / 2),
            int(size[1] * transform.scale["y"] / 2),
        )
        self.hypotenuse_len = math.sqrt(self.center[0] ** 2 + self.center[1] ** 2)
        self.original_center_angle_rad = math.atan(self.center[1] / self.center[0])

    def new_transform(self, angle_deg):
        rotate_angle_rad = math.tau * angle_deg / 360
        new_center_angle_rad = self.original_center_angle_rad + rotate_angle_rad
        new_centre_from_original = (
            math.cos(new_center_angle_rad) * self.hypotenuse_len,
            math.sin(new_center_angle_rad) * self.hypotenuse_len,
        )
        offset = (
            self.center[0] - new_centre_from_original[0],
            self.center[1] - new_centre_from_original[1],
        )

        result = ITransform(
            crop=self.original_transform.crop,
            scale=self.original_transform.scale,
            position={
                "x": self.original_transform.position["x"] + offset[0],
                "y": self.original_transform.position["y"] + offset[1],
            },
            rotation=self.original_transform.rotation + angle_deg,
        )
        return result


async def spin(conn):
    try:
        ss = ScenesService(conn)
        active_scene = await ss.active_scene()

        # Gather all the items in the scene, and create a Spinnable for each
        # to do all the trig.
        spinnables = []
        for item in await active_scene.get_items():
            source = await item.get_source()
            #print(source._name)
            if source._name == 'Cat logo':
                spinnables.append(
                    Spinnable(item, item.transform, (source.width, source.height))
                )
                break

        for rotate_angle_deg in range(1080 + 1):
            for spinnable in spinnables:
                await spinnable.item.set_transform(
                    spinnable.new_transform(rotate_angle_deg)
                )

    except Exception:
        logging.exception("Unexpected exception")
    finally:
        await conn.close()


async def main(conn):
    await asyncio.gather(conn.background_processing(), spin(conn))

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    file_t = 'token.pkl'

    conn = None
    data = None    
    events = ['follow', 'subscription', 'bits', 'host', 'donation']

    HOST = 'oai.vps'
    PORT = 60000
    
    while True:
      try:
        with open(file_t, 'rb') as token_file:
          token = pickle.load(token_file)
        break
      except FileNotFoundError:
        with open(file_t, 'x') as token_file:
          pass
      except EOFError:    
        token = input('Enter Streamlabs Remote API token:\n')
        with open(file_t, 'wb') as token_file:
          pickle.dump(token, token_file)
    
    try:
      s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error:
      print('Failed to create socket')
      sys.exit()
    print('socket created')
    
    s.connect((HOST, PORT))


    while True:
      if conn is None:
        conn = SlobsConnection(token)
      
      data = s.recv(1024).decode('utf-8')
        
      if data in events:
        print(data)  
        asyncio.run(main(conn))
        
        conn = None
        data = None
