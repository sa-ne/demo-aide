# demo-aide
Quick demo of Advanced Intrusion Detection Environment (AIDE)

Advanced Intrusion Detection Environment (AIDE) is a utility that creates a database of files on the system, and then uses that database to ensure file integrity and detect system intrusions.

To install the aide package, enter the following command as root:

```# yum install aide```

To generate an initial database, enter the following command as root.  To start using the database, remove the .new substring from the initial database file name

```# aide --init```

To initiate a manual check, enter the following command as root:

```# aide --check```

After the changes of your system such as package updates or configuration files adjustments are verified, update your baseline AIDE database:

```# aide --update && mv -f /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz```

At a minimum, AIDE should be configured to run a weekly scan. At most, AIDE should be run daily. For example, to schedule a daily execution of AIDE at 4:05 am using cron, add the following line to /etc/crontab:

```05 4 * * * root /usr/sbin/aide --check```

In the default configuration, the aide --init command checks just a set of directories and files defined in the /etc/aide.conf file. To include additional directories or files in the AIDE database, and to change their watched parameters, edit /etc/aide.conf accordingly

To change the location of the AIDE database, edit the /etc/aide.conf file and modify the DBDIR value. For additional security, store the database, configuration, and the /usr/sbin/aide binary file in a secure location such as a read-only media.

Important: To avoid SELinux denials after the AIDE database location change, update your SELinux policy accordingly.

[Reference Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using-aide)
