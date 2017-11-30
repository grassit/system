#!/bin/bash -x
function ses {

# 1) SETUP A BASIC SERVER ENVIRONMENT:

	adduser benqzq
	apt-get update -y && apt-get upgrade -y
	apt-get install unattended-upgrades tree zip unzip -y
	dpkg-reconfigure --priority=low unattended-upgrades
	mkdir /root/backups /root/backups/db /root/backups/dirs
	cd ~ && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

	cd /usr/src && rm -fv csf.tgz
	wget https://download.configserver.com/csf.tgz && tar -xzf csf.tgz
	cd csf && sh install.sh
	sed -i 's/TESTING = "1"/TESTING = "0"/g' /etc/csf/csf.conf
	csf -r && perl /usr/local/csf/bin/csftest.pl
	# sh /etc/csf/uninstall.sh

	cd /usr/local/src && wget http://www.rfxn.com/downloads/maldetect-current.tar.gz && tar -xzf maldetect-current.tar.gz
	cd maldetect-* && bash ./install.sh

	echo -e "\07" && echo -e "\077" # Insert password.
	apt-get install lamp-server^ php-zip php-curl php-xml php-gd -y
	a2enmod mcrypt ; a2enmod mbstring ; a2enmod rewrite ; a2enmod deflate ; a2enmod headers; a2enmod expires
	sed -i 's/post_max_size \= .M/post_max_size \= 200M/g' /etc/php/7.0/apache2/php.ini # regex dot instead any default character.
	sed -i 's/upload_max_filesize \= .M/upload_max_filesize \= 200M/g' /etc/php/7.0/apache2/php.ini

# ------------------------------------------------------------------------------------------- #
# 2) Create a Vhost maker:

	cat <<-'CSB' > /etc/nginx/sites-available/csb
		#!/bin/sh
		for domain; do
		> "/etc/nginx/sites-available/${domain}.conf" cat <<EOF
			server {
				listen 80;
				listen [::]:80;
				root /var/www/html/${domain};
				index index.php index.html index.htm index.nginx-debian.html;
				"${domain}" www.${domain};

				location / {
					try_files $uri $uri/ =404;
				}

				location ~ \.php$ {
					include snippets/fastcgi-php.conf;
					fastcgi_pass unix:/run/php/php7.0-fpm.sock;
				}

				location ~ /\.ht {
					deny all;
				}
			}
		EOF
		sudo ln -s /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/
		done
		systemctl restart nginx.service
	CSB
	chmod +x /etc/nginx/sites-available/csb

# ------------------------------------------------------------------------------------------- #
# 3) SETUP SERVER ENVIRONMENT EXTRAS:

	cat <<-'LAMPENV' >> /etc/apache2/apache2.conf

		<Directory /var/www/>
		Options Indexes FollowSymLinks
		AllowOverride All
		Require all granted
		</Directory>

		<ifmodule mod_expires.c>
		<Filesmatch "\.(jpg|jpeg|png|gif|js|css|swf|ico|woff|mp3)$">
		ExpiresActive On
		ExpiresDefault "access plus 1 month"
		</Filesmatch>
		</ifmodule>
	LAMPENV

	cat <<-'CVH' > /etc/apache2/sites-available/cvh
		#!/bin/sh
			for domain; do
			> "/etc/apache2/sites-available/${domain}.conf" cat <<EOF
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
	CVH
	chmod +x /etc/apache2/sites-available/cvh

	cat <<-'PMA' > /opt/pma.sh
		#!/bin/bash
			find ./ -iname '*phpmyadmin*' -exec rm -rf {} \;
			cd /var/www/html && wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip
			find ./ -type f -iname '*phpmyadmin*.zip' -exec unzip {} \;
			find ./ -type d -iname 'phpmyadmin-*' -exec mv {} phpmyadmin \;
			sleep 2h
			find ./ -iname '*phpmyadmin*' -exec rm -rf {} \;
			tmux kill-session
		PMA
	chmod +x /opt/pma.sh

	cat <<-'BACKUP' > /opt/backup.sh
		mysqldump -u root -p --all-databases > /var/www/html/db-$(date +\%F-\%T-).sql
		zip -r /var/www/html/html-$(date +\%F-\%T-).zip /var/www/html -x '*wp-content/cache*'
	BACKUP
	chmod +x /opt/backup.sh

	cat <<-'BASHRC' > /etc/bash.bashrc

		alias brc="nano /etc/bash.bashrc"
		alias cvh="bash /etc/apache2/sites-available/cvh"
		alias rss="systemctl restart apache2.service"

		alias pma="tmux new-session -d 'bash /opt/pma.sh'"
		alias cbu="bash /opt/backup.sh"

		alias www="cd /var/www/html"
		alias bud="cd ~/backups
		alias ap2="cd /etc/apache2"
		alias asa="cd /etc/apache2/sites-available"
	BASHRC

# ------------------------------------------------------------------------------------------- #
# 4) Finishes:

	sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
	reboot
} ses