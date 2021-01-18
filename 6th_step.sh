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



cat /etc/ipsec.d/cacerts/ca-cert.pem

