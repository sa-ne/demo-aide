#!/bin/bash

yum remove -y aide
rm -rf /var/lib/aide
rm -f /root/keep-file

# remove /sbin/backdoor
rm -f /sbin/backdoor
# fix /etc/hosts
mv /etc/hosts.bak /etc/hosts
# change password (shadow)
passwd mark
# remove package
yum remove -y zip
# remove cronjob
rm -f /etc/cron.hourly/backdoor.sh
# remove secret-file
rm -f /root/secret-file


