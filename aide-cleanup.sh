#!/bin/bash

echo -e "Cleaning up ...
"
yum remove -y aide
rm -rf /var/lib/aide
rm -f /root/keep-file

# remove /sbin/backdoor
rm -f /sbin/backdoor
# fix /etc/hosts
mv /etc/hosts.bak /etc/hosts
# remove user
userdel -rf aideuser
# remove package
yum remove -y zip
# remove cronjob
rm -f /etc/cron.hourly/backdoor.sh
# remove secret-file
rm -f /root/secret-file
# remote important-dir
rm -rf /important-dir
