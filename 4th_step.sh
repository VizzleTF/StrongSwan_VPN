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

echo "Please enter IP address of your VPN server:"
read IP

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
echo "##      Go to step 5!      ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.1
echo "#############################"
sleep 0.6
