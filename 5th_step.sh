# setting autentification vpn

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

echo " "
echo "Enter your vpn user:"
echo " "
read user
echo " "
echo "Enter your password:"
echo " "
read password

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
clear

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
echo "##      Go to step 6!      ##"
sleep 0.1
echo "##                         ##"
sleep 0.1
echo "####                     ####"
sleep 0.1
echo "#############################"
sleep 0.1
echo "#############################"
sleep 0.6
