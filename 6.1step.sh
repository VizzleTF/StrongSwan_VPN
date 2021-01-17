sed 's!processed! \
-A ufw-before-forward --match policy --pol ipsec --dir in --proto esp -s 10.10.10.0/24 -j ACCEPT \
-A ufw-before-forward --match policy --pol ipsec --dir out --proto esp -d 10.10.10.0/24 -j ACCEPT !g' /etc/ufw/before.rules.bkp > /etc/ufw/before.rules.tmp;

sed '/*filter/ i *nat \
-A POSTROUTING -s 10.10.10.0/24 -o eth0 -m policy --pol ipsec --dir out -j ACCEPT \
-A POSTROUTING -s 10.10.10.0/24 -o eth0 -j MASQUERADE \
COMMIT\
\
*mangle \
-A FORWARD --match policy --pol ipsec --dir in -s 10.10.10.0/24 -o eth0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360 \
COMMIT' /etc/ufw/before.rules.tmp > /etc/ufw/before.rules;

echo "done 1";
