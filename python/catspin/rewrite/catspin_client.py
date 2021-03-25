import asyncio
import logging
import math
import socket
import argparse

from threading import Thread
from time import sleep
from pyslobs import (
    SlobsConnection,
    ScenesService,
    StreamingService,
    ITransform,
    config_from_ini_else_stdin,
)

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

        spinnables = []
        for item in await active_scene.get_items():
            source = await item.get_source()

            if source._name == 'Cat Logo':
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
        pass

class Connections:
    def __init__(self):
        self.resp = None

    def listen_for_event(self, s):
        self.resp = s.recv(1024).decode('utf-8')

    async def listen(self, conn, s):
        events = ['follow', 'subscription', 'bits', 'host', 'donation']
        status = 'offline' if args.t else 'live'
        ss = StreamingService(conn)

        if status == 'live':
            print('Going LIVE')
            await ss.toggle_streaming()
        else:
            print('Entering testing mode')
        data = await ss.get_model()

        if status == 'live':
            while data.streaming_status != status:
                data = await ss.get_model()
                sleep(0.2)

        print('Listening for Streamlabs events')
        try:
            t = Thread(target=self.listen_for_event, args=(s,))
            t.start()
            while data.streaming_status == status:
                if self.resp and self.resp in events:
                    print(f'Just got a {self.resp}')
                    s.send(self.resp.encode())
                    await spin(conn)
                    s.close()
                    self.resp = None
                    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    s.connect((HOST, PORT))
                    t = Thread(target=self.listen_for_event, args=(s,))
                    t.start()

                data = await ss.get_model()
                sleep(0.1)
        except Exception as e:
            logging.exception('Error: ', str(e))
        finally:
            await conn.close()

async def main(conn, s):
    connect = Connections()
    await asyncio.gather(conn.background_processing(),
    connect.listen(conn, s)
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', action='store_true')
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO)

    conn = SlobsConnection(config_from_ini_else_stdin())

    HOST = '127.0.0.1' if args.t else 'oai.vps'
    PORT = 60000

    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error:
        print('Failed to create socket')
        sys.exit()
    print('socket created')

    s.connect((HOST, PORT))

    asyncio.run(main(conn, s))
