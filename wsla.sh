apt-get update -y && apt-get upgrade -y && apt-get install tree zip unzip lamp-server^ phpmyadmin -y
a2enmod mcrypt ; a2enmod mbstring ; a2enmod rewrite ; a2enmod deflate ; a2enmod headers; a2enmod expires
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

cat <<-AWSM > /etc/apache2/sites-available/awsm
    #!/bin/sh
    for domain; do
      cat <<-EOF > /etc/apache2/sites-available/${domain}.conf
          <VirtualHost *:80>
              DocumentRoot "/var/www/html/${domain}"
              ServerName "${domain}"
              <Directory "/var/www/html/${domain}">
              Options +SymLinksIfOwnerMatch
              Require all granted
              </Directory>
              ServerAlias www.${domain}
          </VirtualHost>
      EOF
      a2ensite "${domain}"
    done
    systemctl restart apache2.service
    echo "Please enter password for user ${domain}: "; read -s waps
    mysql -u root -p <<-MYSQL
        create user "${domain}"@"localhost" identified by "${waps}";
        create database ${domain};
        GRANT ALL PRIVILEGES ON ${domain}.* TO ${domain}@localhost;
    MYSQL
AWSM
chmod +x /etc/apache2/sites-available/awsm

cat <<-'BASHRC' > /etc/bash.bashrc
  alias brc="nano /etc/bash.bashrc"
  alias www="cd /var/www/html"
  alias Awsm="bash /etc/apache2/sites-available/awsm"
  alias rss="systemctl restart apache2.service"
  alias imb="bash /opt/backup.sh"
BASHRC
