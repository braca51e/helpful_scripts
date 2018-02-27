import base64
import httplib
import json
import os
import ssl

headers = {"Content-type": "application/json",
           "X-Access-Token": "YOUR-CLOUD-TOKEN"}
conn = httplib.HTTPSConnection("dev.sighthoundapi.com", 
       context=ssl.SSLContext(ssl.PROTOCOL_TLSv1))

# To use a hosted image uncomment the following line and update the URL
#image_data = "http://example.com/path/to/hosted/image.jpg"

# To use a local file uncomment the following line and update the path
#image_data = base64.b64encode(open("/path/to/local/image.jpg").read())

params = json.dumps({"image": image_data})
conn.request("POST", "/v1/detections?type=face,person&faceOption=landmark,gender", params, headers)
response = conn.getresponse()
result = response.read()
print "Detection Results = " + str(result)
