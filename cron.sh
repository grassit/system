# /etc/init.d/cron status
# journalctl -u cron
#
# m h dom m dow
# 0-59 | 0-23 | 1-31 | 1-12 | 0-6
#
# +\%Y-\%m-\%d-\%H-\%M-\%S
#
# +\%F == %Y-%m-%d
# +\%T == %H:%M:%S
#
# min/time arguments:
#
# amin == Inode last accessed n*60 minutes ago.
# mmin == Inode last modified (data) n*60 minutes ago.
# cmin == Inode last changed (data and/or permissions) n*60 minutes ago.
# -amin +1, -mmin +1, -cmin +1 == All 1*60 MINUTES (common) | 0*60 means anything less than 60 minutes.
# -atime +1, -mtime +1, ctime +1 == Inode last accessed respectively, n*24 HOURS (common, 1*24).
#
# Always give full paths in cron.
#
# Make sure DBU rootp is inserted directly after -p.

# ------------------------------------------------------------------------------------- #

mkdir -p /root/backups/{db,dirs}

cat <<-"CRON_DAILY" > /etc/cron.daily/nses_cron_daily
	cat /dev/null > /var/mail/root
	for dir in /var/www/html/*/; do cd "$dir" && /usr/local/bin/wp plugin update --all --allow-root; done
	for dir in /var/www/html/*/; do cd "$dir" && /usr/local/bin/wp core update --allow-root; done
	for dir in /var/www/html/*/; do cd "$dir" && /usr/local/bin/wp theme update --all --allow-root; done
	chown www-data:www-data /var/www/html/* -R && find /var/www/html/* -type d -exec chmod 755 {} \; && find /var/www/html/* -type f -exec chmod 644 {} \;
CRON_DAILY
chmod +x /etc/cron.daily/nses_cron_daily

# ------------------------------------------------------------------------------------- #

cat <<-"CRON_WEEKLY" > /etc/cron.weekly/nses_cron_weekly
	certbot renew -q
	
	for dir in /var/www/html/*/wp-content; do cd "$dir" && cd cache && rm -rf *; done;
	zip -r /root/backups/dirs/html-$(date +\%F-\%T).zip /var/www/html
	find /root/backups/dirs/* -mtime +30 -exec rm {} \;
	mysqldump -u root -pPASSWORD --all-databases > /root/backups/db/db-$(date +\%F-\%T).sql
	find /root/backups/db/* -mtime +30 -exec rm {} \;
CRON_WEEKLY
chmod +x /etc/cron.weekly/nses_cron_weekly

echo "Change DB root password in crontab."
