#!/bin/bash
#Update pip
pip install --upgrade virtualenv
#Create virtual env
virtualenv --python /usr/bin/python ~/venvs/tensorflow
source ~/venvs/tensorflow/bin/activate
#update pip in virtual env
pip install --upgrade pip
#Install pip packages for this case tensorflow
pip install --upgrade --ignore-installed --no-cache-dir https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.4.0-cp27-none-linux_x86_64.whl
#Create init for tensorflow (not created by default)
touch $VIRTUAL_ENV/lib64/python2.7/site-packages/google/__init__.py
#Strip (remove unnecessary files and save space) do this before installing pillow nd maybe other libraries
find $VIRTUAL_ENV/lib/python2.7/site-packages -name "*.so" | xargs strip
#Install any other pip library that gives problems with strip
pip install pillow
#Backup just in case
cd $VIRTUAL_ENV/lib/python2.7/site-packages
cp -r . ../site-packages-backup
#Zip files
pushd $VIRTUAL_ENV/lib/python2.7/site-packages/
zip -r9q ~/aws_archive.zip * --exclude \*.pyc
popd
