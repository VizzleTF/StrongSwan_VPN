#!/bin/bash

##########################
#			 #
#	update repo      #
#    install strongSwan  #
#			 #
##########################

echo "updating repositories.."
apt-get update >> /dev/null; 
echo "done"

echo "installing StrongSwan.."
apt-get install --assume-yes strongswan strongswan-pki libcharon-extra-plugins > /dev/null;
echo "done"
echo "Go to step 2!" 

