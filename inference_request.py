#!/usr/bin/env python
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

#Create json
image_data = base64.b64encode(open("test_2.jpg").read())
params = {"image":image_data}
with open("image_2.json", "w") as f:
    json.dump(params, f)

#Read from json
with open("image_2.json", "r") as f:
    data = json.load(f)
image = Image.open(BytesIO(base64.b64decode(data["image"])))
image = ImageOps.autocontrast(image)
image.save("tmp.jpg", "JPEG")

#Another image way
img = Image.open("image3.jpg")
#img = img.resize((299, 299), Image.ANTIALIAS)
#img.save("./image3.jpg", "JPEG")
img_enc = base64.b64encode(img.tobytes())
params.update({"image1":img_enc})

with open("encode_json.json", "w") as f:
    f.write(json.dumps(params, ensure_ascii=True))

json_data = open("encode_json.json").read()
data = json.loads(json_data)

for image_name in data:
    image = Image.frombytes('RGB', (299, 299), base64.b64decode(data[image_name]))
    img.save("./image3recovered.jpg", "JPEG")
