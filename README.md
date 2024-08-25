# [Auto-configure StrongSwan VPN IKEv2](https://github.com/VizzleTF/StrongSwan_VPN)

This script automates the setup of an IKEv2 VPN server using StrongSwan on Ubuntu 20.04 LTS (AWS).
Features

Installs and configures StrongSwan
Sets up certificates for VPN authentication
Configures IPsec for secure VPN connections
Sets up firewall rules for VPN traffic
Easy-to-use interactive setup process

Prerequisites

Ubuntu 20.04 LTS (tested on AWS)
Root or sudo access
A public IP address for your server

Usage

Clone this repository:
Copygit clone https://github.com/VizzleTF/StrongSwan_VPN.git
cd StrongSwan_VPN

Make the script executable:
Copychmod +x vpn_setup.sh

Run the script with root privileges:
Copysudo ./vpn_setup.sh

Follow the prompts to enter your server's IP address, VPN username, and password.
Once the script completes, it will display your CA certificate. Save this certificate as you'll need it to configure your VPN clients.

Client Configuration
To connect to your new VPN server:

Install an IKEv2-compatible VPN client on your device.
Create a new VPN connection using the IKEv2 protocol.
Use the server's public IP address as the VPN server address.
Use the username and password you set during the script execution.
Import the CA certificate displayed at the end of the script execution.

Security Considerations

Change the default VPN credentials regularly.
Keep your server and StrongSwan installation up to date.
Monitor your server logs for any suspicious activity.

Troubleshooting
If you encounter issues:

Check that all required ports (500 and 4500 UDP) are open in your firewall/security group.
Verify that the server's public IP address is correctly set in the IPsec configuration.
Check the StrongSwan logs for any error messages: sudo journalctl -u strongswan