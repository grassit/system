cat <<-"IMMEDIATE_BACKUP" > /opt/imb.sh
    zip -r /var/www/html/html-$(date +\%F-\%T).zip /var/www/html -x "*wp-content/cache/*"
    
    mysqldump -u root -p --all-databases > /var/www/html/db-$(date +\%F-\%T).sql
    zip /var/www/html/db-$(date +\%F-\%T).zip /var/www/html/db-*.sql
    rm /var/www/html/db-*.sql

    zip -r /var/www/html/html-$(date +\%F-\%T).zip /db-$(date +\%F-\%T).zip /var/www/html/all_zipped.zip
    rm -rf db-$(date +\%F-\%T).zip html-$(date +\%F-\%T).zip
IMMEDIATE_BACKUP
chmod +x /opt/imb.sh
