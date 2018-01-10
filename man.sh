# WEBSERVER DEBUGGING:

    maldet -u && maldet -d && maldet -a / # u == update. d == details. a == all.
    cat > /var/www/html/info.php <<< "<?php phpinfo();"
    netstat -tulpn # List who listens to what on Ubuntu + logins FROM current machine. Grep a port if needed.
    lsof -i -n -P | grep ssh # List logins TO current machine.
    ssh USER@IP -vvv -L 22:localhost:22 -L 2222:localhost:8080

    printf '\n\n General: \n\n'; nginx -t; printf '\n\n Access: \n\n'; tail /var/log/nginx/access.log; printf '\n\n Errors: \n\n'; tail /var/log/nginx/error.log
    tail /var/log/dpkg.log file # See what got updated.
    systemctl restart nginx.service && /etc/init.d/php7.0-fpm restart
    # sed -i == sed inverbose.

# WEBAPP DEBUGGING:

    # Check WSR, DIR, DBU, DBI, CONF.
    wp search-replace "http://" "https://" --all-tables --allow-root
    wp plugin deactivate --all --allow-root
    wp plugin uninstall xyz --allow-root
    # Power cycle (refreshes iptables).
    # Plugin options (if CSS unloads or if browser gives SSL related warnings).
    chown www-data:www-data /var/www/html/* -R && find /var/www/html/* -type d -exec chmod 755 {} \; && find /var/www/html/* -type f -exec chmod 644 {} \;

# Wordpress for webapp substate:

    # 2. Point domain users to hoster DNSs via domain register.
    # 3. Declare domain at hoster.
    # 4. Install Wordpress online.
