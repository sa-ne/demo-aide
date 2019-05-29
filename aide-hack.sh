#!/bin/bash

# Run this to simulate a "hack" on the system

# add /sbin/backdoor
touch /sbin/backdoor
# modify /etc/hosts
cp /etc/hosts /etc/hosts.bak && echo "1.2.3.4  backdoor.darkweb.ru">>/etc/hosts
# change password (shadow)
# This is obviously a terrible security practice, never do this in real life!
echo "mynewpassword" | passwd --stdin aideuser
# add package
yum install -y zip
# add cronjob
touch /etc/cron.hourly/backdoor.sh
# change owner and perms
chown aideuser /root/secret-file
chmod 0600 /root/secret-file
# remove a file
rm -f /root/keep-file
