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
echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##     Making directory    ##"
sleep 0.1
echo "##        for certs..      ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

mkdir -p ~/pki/{cacerts,certs,private};

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
echo "##     Change rights       ##"
sleep 0.1
echo "##     for directory..     ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

chmod 700 ~/pki;

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
echo "##   Generate root key..   ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem;

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
echo "##      making center      ##"
sleep 0.1
echo "##    of sertification..   ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

ipsec pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem \
	    --type rsa --dn "CN=github_VizzleTF" --outform pem > ~/pki/cacerts/ca-cert.pem;

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
echo "##  Generating close key.. ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem;

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

echo "Please enter IP address of your VPN server:"
read IP
clear

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##   Adding sertificate    ##"
sleep 0.1
echo "##  for your VPN server..  ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

ipsec pki --pub --in ~/pki/private/server-key.pem --type rsa \
	    | ipsec pki --issue --lifetime 1825 \
	            --cacert ~/pki/cacerts/ca-cert.pem \
		            --cakey ~/pki/private/ca-key.pem \
			            --dn "CN=$IP" --san "$IP" \
				            --flag serverAuth --flag ikeIntermediate --outform pem \
 				         >  ~/pki/certs/server-cert.pem;

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
echo "##  Copy to /etc/ipsec.d   ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

sudo cp -r ~/pki/* /etc/ipsec.d/

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
echo "##  Backing up ipsec.conf  ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

sudo mv /etc/ipsec.conf{,.original}; 

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
echo "##  Setting up ipsec.conf  ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

echo "config setup
    charondebug=\"ike 1, knl 1, cfg 0\"
    uniqueids=no

conn ikev2-vpn
    auto=add
    compress=no
    type=tunnel
    keyexchange=ikev2
    fragmentation=yes
    forceencaps=yes
    dpdaction=clear
    dpddelay=300s
    rekey=no
    left=%any
    leftid=$IP
    leftcert=server-cert.pem
    leftsendcert=always
    leftsubnet=0.0.0.0/0
    right=%any
    rightid=%any
    rightauth=eap-mschapv2
    rightsourceip=10.10.10.0/24
    rightdns=8.8.8.8,8.8.4.4
    rightsendcert=never
    eap_identity=%identity" > /etc/ipsec.conf


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
echo "##  Adding server-key.pem  ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

echo ": RSA \"server-key.pem\" " >> /etc/ipsec.secrets

clear

echo " \
"

echo "Enter your vpn user:"

read user

echo " \
"

sleep 0.7

echo "Enter your password:" 

read password

sleep 0.7

clear

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##    Adding your user     ##"
sleep 0.1
echo "##        and pass         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

echo $user : EAP $password >>/etc/ipsec.secrets

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
echo "##      Opening ports      ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

sudo ufw allow OpenSSH
sudo ufw allow 22
sudo ufw allow 500,4500/udp

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
echo "##     Defining right      ##"
sleep 0.1
echo "##       interface         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

ext_interface () {
    for interface in /sys/class/net/*
    do
        [[ "${interface##*/}" != 'lo' ]] && \
            ping -c1 -W2 -I "${interface##*/}" 8.8.8.8 >/dev/null 2>&1 && \
                printf '%s' "${interface##*/}" && return 0
    done
}

interface=$(ext_interface);

echo "#############################"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "##     Done! it's $interface     ##"
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
echo "##       Backing up        ##"
sleep 0.1
echo "##  /etc/ufw/before.rules  ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

scp /etc/ufw/before.rules /etc/ufw/before.rules.bkp;

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
echo "##    Setting Firewall     ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5

sed 's!processed! \
-A ufw-before-forward --match policy --pol ipsec --dir in --proto esp -s 10.10.10.0/24 -j ACCEPT \
-A ufw-before-forward --match policy --pol ipsec --dir out --proto esp -d 10.10.10.0/24 -j ACCEPT !g' /etc/ufw/before.rules.bkp > /etc/ufw/before.rules.tmp;

sed '/*filter/ i *nat \
-A POSTROUTING -s 10.10.10.0/24 -o $interface -m policy --pol ipsec --dir out -j ACCEPT \
-A POSTROUTING -s 10.10.10.0/24 -o $interface -j MASQUERADE \
COMMIT\
\
*mangle \
-A FORWARD --match policy --pol ipsec --dir in -s 10.10.10.0/24 -o $interface -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360 \
COMMIT' /etc/ufw/before.rules.tmp > /etc/ufw/before.rules;

scp /etc/ufw/sysctl.conf /etc/ufw/sysctl.conf.bkp;

sed 's!#net/ipv4/ip_forward=1!net/ipv4/ip_forward=1!g' /etc/ufw/sysctl.conf.bkp > /etc/ufw/sysctl.conf;

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
echo "##    HERE IS YOUR KEY!    ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.5
clear

echo " \
"

cat /etc/ipsec.d/cacerts/ca-cert.pem

echo " \
"

####################################
#	                           #
#	                           #
#	     Have fun!             #
#	                           #
#	                           #
####################################
