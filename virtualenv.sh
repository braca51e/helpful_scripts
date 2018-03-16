#Add virtuelenv to profile bash
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.profile
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.profile
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.profile
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile

#create virtualenv with out site packages raspi opencv install
mkvirtualenv -p $(which python3) --no-site-packages cv

#Install miniconda3 for opencv and numpy on Rpi
sudo apt-get update
sudo apt-get install -y cmake
sudo apt-get install -y libopenblas-dev
sudo apt-get install -y curl
curl -O --location http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh
chmod +x Miniconda3-latest-Linux-armv7l.sh
./Miniconda3-latest-Linux-armv7l.sh
source ~/.bashrc
conda create --name py34 python=3.4
source activate py34
#Opencv
conda install -c microsoft-ell opencv -y
sudo apt-get install -y libopencv-dev
