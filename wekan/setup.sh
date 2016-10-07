#!/bin/bash

set -o nounset
set -o errexit

USER=ubuntu

sudo apt update
sudo apt -y install python2.7 gcc make build-essential
#sudo ln -s /usr/bin/python2.7 /usr/bin/python

cd /tmp
# download nodejs
wget https://nodejs.org/download/release/v0.12.15/node-v0.12.15-linux-x64.tar.gz

# extract nodejs
tar xzvf node-v0.12.15-linux-x64.tar.gz
cp -R node-v0.12.15-linux-x64 /home/${USER}/.node

# add bin to PATH
echo "export PATH=$PATH:/home/${USER}/.node/bin" >> ~/.bashrc
export PATH=$PATH:/home/${USER}/.node/bin

# download mongodb
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.2.9.tgz
tar xzvf mongodb-linux-x86_64-ubuntu1604-3.2.9.tgz
cp -R mongodb-linux-x86_64-ubuntu1604-3.2.9 /home/${USER}/.mongodb

echo "export PATH=$PATH:/home/${USER}/.mongodb" >> ~/.bashrc
export PATH=$PATH:/home/${USER}/.mongodb/bin


sudo mkdir -p /data/db
sudo chown -R ${USER}:${USER} /data

# get wekan

wget https://github.com/wekan/wekan/releases/download/v0.11.0-rc2/wekan-0.11.0-rc2.tar.gz
tar xvzf wekan-0.11.0-rc2.tar.gz
mkdir /home/${USER}/.wekan 
cp -R bundle /home/${USER}/.wekan/
cd /home/${USER}/.wekan/bundle/programs/server/ && npm install
cd ../..

echo "
export MONGO_URL='mongodb://127.0.0.1:27017/wekan'
export ROOT_URL='http://'${HOSTNAME}'.local'
#export MAIL_URL='smtp://user:pass@mailserver.example.com:25/'
export PORT=8080
" >> ~/.bashrc
export MONGO_URL='mongodb://127.0.0.1:27017/wekan'
export ROOT_URL='http://'${HOSTNAME}'.local'
#export MAIL_URL='smtp://user:pass@mailserver.example.com:25/'
export PORT=8080


#start mongodb
mongod &
# start nodejs
node main.js &

