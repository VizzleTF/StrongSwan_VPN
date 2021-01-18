##########################	
#			 #
# Generating sertificate #
#     For VPN SERVER     #
#			 #
##########################


echo "Generating close key.."
ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem;
echo "done"
echo " "

echo "Please enter IP address of your VPN server:"
read IP

CN="CN=$IP" --san "$IP"
echo "$CN"

#echo "Adding sertificate for $IP VPN server.."
#ipsec pki --pub --in ~/pki/private/server-key.pem --type rsa \
#	    | ipsec pki --issue --lifetime 1825 \
#	            --cacert ~/pki/cacerts/ca-cert.pem \
#		            --cakey ~/pki/private/ca-key.pem \
#			            --dn $CN \
#				            --flag serverAuth --flag ikeIntermediate --outform pem \
#					        >  ~/pki/certs/server-cert.pem;
#
#sudo cp -r ~/pki/* /etc/ipsec.d/

echo "done"
echo " "

