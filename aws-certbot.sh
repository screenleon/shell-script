# install certbot
amazon-linux-extras install epel
yum install certbot

# generate 
certbot certonly --manual --preferred-challenges dns-01 -d *.example.com

# regenerate outdated ssl
certbot renew