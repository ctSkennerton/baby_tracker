# this setup script script is copied from the instructions 
# found at https://www.digitalocean.com/community/tools/nginx
#
# Use this script to set up the host machine suitable for
# proxying a seaside application running through Docker
tar -czvf nginx_$(date +'%F_%H-%M-%S').tar.gz nginx.conf sites-available/ sites-enabled/ nginxconfig.io/
cp -R sites-available/* /etc/nginx/sites-available
cp -R sites-enabled/* /etc/nginx/sites-enabled
cp -R nginxconfig.io/ /etc/nginx/
cp nginx.conf /etc/nginx/

openssl dhparam -out /etc/nginx/dhparam.pem 2048
mkdir -p /var/www/_letsencrypt
chown www-data /var/www/_letsencrypt

# Comment out SSL related directives in the configuration
sed -i -r 's/(listen .*443)/\1; #/g; s/(ssl_(certificate|certificate_key|trusted_certificate) )/#;#\1/g; s/(server \{)/\1\n    ssl off;/g' /etc/nginx/sites-available/babytracker.skennerton.net.conf

sudo nginx -t && sudo systemctl reload nginx

snap install --classic certbot

#Obtain SSL certificates from Let's Encrypt using Certbot
certbot certonly --webroot -d babytracker.skennerton.net --email info@babytracker.skennerton.net -w /var/www/_letsencrypt -n --agree-tos --force-renewal

#Uncomment SSL related directives in the configuration
sed -i -r -z 's/#?; ?#//g; s/(server \{)\n    ssl off;/\1/g' /etc/nginx/sites-available/babytracker.skennerton.net.conf

# Reload your NGINX server
sudo nginx -t && sudo systemctl reload nginx

# Configure Certbot to reload NGINX when it successfully renews certificates
echo -e '#!/bin/bash\nnginx -t && systemctl reload nginx' | sudo tee /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
sudo chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
