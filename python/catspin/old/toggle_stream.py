import asyncio
import logging
from pyslobs import SlobsConnection, StreamingService

import pickle

async def get_status(conn):
  ss = StreamingService(conn)
  
  try:
    data = await ss.get_model()
    print(f'Stream is: {data.streaming_status}')
  except:
    logging.exception('Error starting stream')
  finally:
    await conn.close()

async def stream(conn):
  ss = StreamingService(conn)
  
  try:
    await ss.toggle_streaming()
  except:
    logging.exception('Error starting stream')
  finally:
    await conn.close()

async def main():
  file_t = 'token.pkl'
  
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
  
  conn = SlobsConnection(token)
  await asyncio.gather(
    conn.background_processing(),
    stream(conn)
    )

  conn = SlobsConnection(token)
  await asyncio.gather(
    conn.background_processing(),
    get_status(conn)
    )

if __name__ == '__main__':
  logging.basicConfig(level=logging.DEBUG)
  asyncio.run(main())