# Auto-configure StrongSwan VPN IKEv2

- Auto-configure StrongSwan VPN IKEv2
- The script is guaranteed to work on AWS EC2 Ubuntu 20.04 LTS



## Install:
1. sudo -i                                                   #run script from root only!
2. git clone https://github.com/VizzleTF/StrongSwan_VPN      #copy script to your machine 
3. cd StrongSwan_VPN/                                        #go to script directory 
4. chmod u+x all_in_one.sh                                   #add execute rights ro script
5. ./all_in_one.sh                                           #run script
6. Enter your IP
7. Enter you user and password
8. Copy your ca-cert.pem to client device
9. You always can find it at /etc/ipsec.d/cacerts/ca-cert.pem


### .
##### - Writed on Bash
- By  VizzleTF 
