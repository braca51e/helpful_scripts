#Zip model artefacts and upload to S3
#Model
#|-- Model_version
#    |-- variables
#    |-- saved_model.pb
tar -C "$PWD" -czf ssdlite-01.tar.gz ssdlite-01/
