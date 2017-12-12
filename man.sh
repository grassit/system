# WEBSERVER DEBUGGING:

alias brc="nano /etc/bash.bashrc"
alias wsm="bash /etc/nginx/sites-available/wsm.sh"
alias rss="systemctl restart nginx.service"
alias www="cd /var/www/html"
alias imb="bash /opt/imb.sh"
alias dwa="bash /opt/dwa.sh"

maldet -d && maldet -u && maldet -a / # d == details. u == update. a == all.
cat > /var/www/html/info.php <<< '<?php phpinfo();'
ssh USER@IP -vvv -L 22:localhost:22 -L 2222:localhost:8080
# ifconfig || ping || nmap.
netstat -tulpn # List who listens to what on Ubuntu + logins FROM current machine. Grep a port if needed.
lsof -i -n -P | grep ssh # List logins TO current machine.
nginx -t
tail /var/log/nginx/error.log
tail /var/log/nginx/access.log
/etc/init.d/php7.0-fpm restart
systemctl restart nginx.service

# WEBAPP DEBUGGING:

# DR, DBUN, DBIN, CONFF.
wp search-replace 'http://' 'https://' --all-tables --allow-root
wp plugin deactivate --all --allow-root
wp plugin uninstall xyz --allow-root
# Power cycle (refreshes iptables).
# Plugin options (if CSS unloads or if browser gives SSL related warnings).

chown www-data:www-data /var/www/html/* -R &&
find /var/www/html/* -type d -exec chmod 755 {} \; &&
find /var/www/html/* -type f -exec chmod 644 {} \;

# Wordpress for webapp substate:

# 1. Edit webapp CONFF.
# 2. Point domain users to hoster DNSs via domain register.
# 3. Declare domain at hoster.
# 4. Install Wordpress online.
