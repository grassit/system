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

0 0 * * * /opt/cron_daily.sh
0 0 * * 0 /opt/cron.weekly.sh

# Add DB password to cron.
