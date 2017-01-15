#!/bin/bash

set -e


DIR=/etc/ssl/private/vpnCA
VPN=/etc/openvpn/server

#install openvpn
apt install openvpn -y 


# Where everything is kept
mkdir -p $DIR/{private,newcerts}
mkdir -p $VPN

cp -i openssl.cnf /etc/ssl/

# database index file
touch $DIR/index.txt
 
#The current serial number
echo 01 > $DIR/serial
 
#The current crl number
echo 01 > $DIR/crlnumber

#generate ec parameter for ac
openssl ecparam -out $DIR/acparam.pem -name prime256v1 -genkey

#generate an ec certificate
openssl req -x509 -newkey ec:$DIR/acparam.pem -days 3650 -keyout $DIR/private/cakey.pem -out $DIR/cacert.pem
chmod 600 $DIR/private/cakey.pem

#generate ec parameter for the server
openssl ecparam -out $VPN/serverparam.pem -name prime256v1 -genkey
#generate an ec certificate for the server
openssl req -newkey ec:$VPN/serverparam.pem -keyout $VPN/serverk.pem -out $VPN/serverr.pem
chmod 600 $VPN/serverk.pem

#The ac sign the certificate
openssl ca -days 1095 -out $VPN/serverc.pem -in $VPN/serverr.pem -name CA_vpn

#remove password on private key
openssl ec -in $VPN/serverk.pem -out $VPN/tmp_serverk.pem
mv $VPN/tmp_serverk.pem $VPN/serverk.pem

#copy vpn config
cp -i server.conf /etc/openvpn/

openssl dhparam -out $VPN/dh2048.pem 2048

#service
cp -i openvpn@.service /lib/systemd/system/
