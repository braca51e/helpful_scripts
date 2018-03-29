sudo apt-get update
sudo apt-get install -y cmake

sudo apt-get install -y libopenblas-dev
sudo apt-get install -y curl

curl -O --location http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh
sudo chmod +x Miniconda3-latest-Linux-armv7l.sh
./Miniconda3-latest-Linux-armv7l.sh

source ~/.bashrc
conda create --name py34 python=3.4
source activate py34

conda install -c opencv -y

sudo apt-get install -y libopencv-dev
