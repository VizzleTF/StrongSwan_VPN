#!/bin/bash

##################################
#				 #
#   making certification center  #
#				 #
##################################


echo "making directory for certs.."
mkdir -p ~/pki/{cacerts,certs,private};
echo "done"

echo "change rights for directory.."
chmod 700 ~/pki;
echo "done"

echo "generate root key.."
ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem;
echo "done"

echo "making center of sertification.."
ipsec pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem \
	    --type rsa --dn "CN=github.com/VizzleTF" --outform pem > ~/pki/cacerts/ca-cert.pem;
echo "done"
