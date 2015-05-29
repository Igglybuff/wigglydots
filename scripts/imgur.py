import base64
import json
import requests
import sys
import os
from base64 import b64encode

image = sys.argv
image.remove(image[0])
image = ' '.join(image)

api_key = os.environ['IMGUR_API_KEY']

headers = {"Authorization": "Client-ID " + api_key}

url = "https://api.imgur.com/3/upload.json"

try:
    j1 = requests.post(
        url,
        headers = headers,
        data = {
            'key': api_key,
            'image': b64encode(open(image, 'rb').read()),
            'type': 'base64',
        }
    )
    output = json.loads(j1.text)
    output = output['data']
    print output['link']
except:
    print "Something went terribly, terribly wrong."

