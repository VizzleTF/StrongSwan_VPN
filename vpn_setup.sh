#!/bin/bash

# Auto-install VPN IKEv2 for Ubuntu 20.04 LTS (AWS)
# By VizzleTF
# https://github.com/VizzleTF/StrongSwan_VPN

set -e

# Function to display messages
display_message() {
    clear
    echo "#############################"
    sleep 0.1
    echo "####                     ####"
    sleep 0.1
    echo "##                         ##"
    sleep 0.1
    echo "## $1"
    sleep 0.1
    echo "##                         ##"
    sleep 0.1
    echo "####                     ####"
    sleep 0.1
    echo "#############################"
    sleep 0.5
}

# Function to install packages
install_packages() {
    display_message "Updating repositories.."
    apt-get update >> /dev/null
    
    display_message "Installing StrongSwan.."
    apt-get install --assume-yes strongswan strongswan-pki libcharon-extra-plugins > /dev/null
}

# Function to setup certificates
setup_certificates() {
    display_message "Setting up certificates.."
    mkdir -p ~/pki/{cacerts,certs,private}
    chmod 700 ~/pki
    
    ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem
    ipsec pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem \
        --type rsa --dn "CN=github.com/VizzleTF" --outform pem > ~/pki/cacerts/ca-cert.pem
    
    ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem
    
    read -p "Please enter IP address of your VPN server: " IP
    
    ipsec pki --pub --in ~/pki/private/server-key.pem --type rsa \
        | ipsec pki --issue --lifetime 1825 \
        --cacert ~/pki/cacerts/ca-cert.pem \
        --cakey ~/pki/private/ca-key.pem \
        --dn "CN=$IP" --san "$IP" \
        --flag serverAuth --flag ikeIntermediate --outform pem \
        >  ~/pki/certs/server-cert.pem
    
    sudo cp -r ~/pki/* /etc/ipsec.d/
}

# Function to configure IPsec
configure_ipsec() {
    display_message "Configuring IPsec.."
    sudo mv /etc/ipsec.conf{,.original}
    
    cat > /etc/ipsec.conf << EOL
config setup
    charondebug="ike 1, knl 1, cfg 0"
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
    eap_identity=%identity
EOL

    echo ": RSA \"server-key.pem\" " >> /etc/ipsec.secrets
    
    read -p "Enter your VPN username: " user
    read -s -p "Enter your VPN password: " password
    echo
    
    echo "$user : EAP \"$password\"" >> /etc/ipsec.secrets
}

# Function to configure firewall
configure_firewall() {
    display_message "Configuring firewall.."
    sudo ufw allow OpenSSH
    sudo ufw allow 22
    sudo ufw allow 500,4500/udp
    
    interface=$(ip route get 8.8.8.8 | awk '{print $5; exit}')
    
    # Backup and modify before.rules
    cp /etc/ufw/before.rules /etc/ufw/before.rules.bak
    sed -i '/^# don't delete these required lines, otherwise there will be errors/i *nat\n-A POSTROUTING -s 10.10.10.0/24 -o '$interface' -m policy --pol ipsec --dir out -j ACCEPT\n-A POSTROUTING -s 10.10.10.0/24 -o '$interface' -j MASQUERADE\nCOMMIT\n\n*mangle\n-A FORWARD --match policy --pol ipsec --dir in -s 10.10.10.0/24 -o '$interface' -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360\nCOMMIT\n\n' /etc/ufw/before.rules
    sed -i '/^# rules.before/i -A ufw-before-forward --match policy --pol ipsec --dir in --proto esp -s 10.10.10.0/24 -j ACCEPT\n-A ufw-before-forward --match policy --pol ipsec --dir out --proto esp -d 10.10.10.0/24 -j ACCEPT\n' /etc/ufw/before.rules

    # Enable IP forwarding
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/ufw/sysctl.conf
    
    ufw disable > /dev/null
    ufw enable > /dev/null
}

# Main execution
display_message "Welcome to VPN Setup"
install_packages
setup_certificates
configure_ipsec
configure_firewall

display_message "Setup Complete!"
echo "Your CA certificate:"
cat /etc/ipsec.d/cacerts/ca-cert.pem
echo "Setup complete. Enjoy your VPN!"