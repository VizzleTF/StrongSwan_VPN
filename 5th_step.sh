# setting autentification vpn

echo ": RSA \"server-key.pem\" " >> /etc/ipsec.secrets
echo "enter your vpn user:"
read user
echo "enter your password:"
read password

echo $user : EAP $password >>/etc/ipsec.secrets
