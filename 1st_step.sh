#!/bin/bash
echo "###########################"
sleep 0.5
echo "###########################"
sleep 1
echo "##########  Hi  ###########"
sleep 1
echo "#########  from  ##########"
sleep 1
echo "#######  VizzleTF  ########"
sleep 1
echo "###########################"
sleep 1
echo "###########################"
sleep 1
echo "###########################
#                         #
#                         #
# Updating repositories.. #
#                         #
#                         #
###########################"

apt-get update >> /dev/null;

echo "###########################
#                         #
#                         #
#          Done           #
#                         #
#                         #
###########################"

echo "###########################
#                         #
#                         #
# Installing StrongSwan.. #
#                         #
#                         #
###########################"

apt-get install --assume-yes strongswan strongswan-pki libcharon-extra-plugins > /dev/null;

echo "###########################
#                         #
#                         #
#          Done           #
#                         #
#                         #
###########################"
sleep 3
echo "###########################
#                         #
#                         #
#      Go to step 2!      #
#                         #
#                         #
###########################"
sleep 1

