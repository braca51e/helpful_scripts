#Call endpoint sagemaker 
data = open("encode_json.json").read()
data = json.loads(data, object)
data = json.dumps(data)
response = client.invoke_endpoint(EndpointName='', Body=data, ContentType='application/json')

#Create json file for inference
import boto3
import tempfile
from io import BytesIO
import base64
params = {}
s3 = boto3.resource('s3', region_name='us-east-2')
bucket = s3.Bucket('sagemaker-us-east-1-447437144399')
obj = bucket.Object('test_1.jpg')
tmp = tempfile.NamedTemporaryFile()

with open(tmp.name, 'wb') as f:
    #obj.download_fileobj(f)
    #img = mpimg.imread(tmp.name)
    #print("puto!", img.shape)
    #img = Image.fromarray(img)
    img = Image.open(BytesIO(obj.get()['Body'].read()))
    img = img.resize((299, 299), Image.ANTIALIAS)
    print(type(img.tobytes()))
    img_enc = base64.b64encode(img.tobytes())
    
params.update({"image1":img_enc})

with open("encode_json.json", "w") as f:
        f.write(json.dumps(params, ensure_ascii=True))
        
