#!/bin/bash
clear
echo "#############################"
sleep 0.1
echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##           Hi            ##"
sleep 0.2
echo "##          from           ##"
sleep 0.2
echo "##        VizzleTF         ##"
sleep 0.2
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.6
clear
echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "## Updating repositories.. ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

apt-get update >> /dev/null;

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##          Done           ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5
clear

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "## Installing StrongSwan.. ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

apt-get install --assume-yes strongswan strongswan-pki libcharon-extra-plugins > /dev/null;

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##          Done           ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5
clear

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##      Go to step 2!      ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.1
echo "#############################"
sleep 0.6

