## AIDE Demo WalkThru

### Requirements
* Minimum VM: 1vCPU x 1G mem, running RHEL 7
* Setup script, ```aide-setup.sh```, will create additional requirements

### WalkThru
* Setup via aide-setup.sh
  * Will need root or sudo to execute
* Create initial database
```
      # aide --init
```
* Rename DB to begin use
```
      # mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
```
* Initiate a manual integrity check
```
      # aide --check
```
  * Expect a clean check on the initial run since nothing should have changed.
* Now let's make a change.  Edit secret-file and recheck
```
      # sed -i s/mypassword/mynewpassword/ /root/secret-file
      # cat /root/secret-file
      # aide --check
```
  * Aha!  We've successfully detected the change
* View conf file -- talk about parameters
```
      # less /etc/aide.conf
```
  * The comments in aide.conf do a good job of explaining purpose.
    * DBDIR -- if changed need to edit SELinux context
    * Default rules section -- see exactly what is being evaluated
    * Custom rules section -- use existing or create-your-own
    * Files/Dirs section -- notice use of above rules, mostly CONTENT_EX
* Add dir to conf file and re-check (anything happen?)
```
      # mkdir -p /important-dir/finance
      # mkdir -p /important-dir/hr
      # touch /important-dir/finance/important-finance-file
      # touch /important-dir/hr/important-hr-file
      # echo -e "\n#my custom dirs\n/important-dir CONTENT_EX" >> /etc/aide.conf
      # aide --check
```
  * AIDE will not pick up the changes to /important-dir, but does pick up change to aide.conf
* Update & recheck, now did anything happen?
```
      # aide --update
      # mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
      # aide --check
```
 * Files and dirs not defined in aide.conf are ignored
 * Once added to aide.conf an update is required to refresh the DB
* Option: implement regular checks via cron
  * For example, insert the following into /etc/crontab
  > 05 4 * * * root /usr/sbin/aide --check

* Mess everything up by running aide-hack.sh, recheck, talk thru results
  * Run ```aide --check``` after aide-hack.sh
  * Notice changes made:
    * New suspicious file = /sbin/backdoor
    * Modified /etc/hosts
    ```
          # cat /etc/hosts
    ```
    * Change user password (shadow)
    * Added package = zip
    * Add suspicious cronjob = /etc/cron.hourly/backdoor.sh
    * Changed owner and perms on secret-file
    ```
          # stat /root/secret-file
    ```
    * Removed a critical file = /root/keep-file
* By default sends output to file=/var/log/aide/aide.log
  * Option: email logfile after check
```
      # cat /var/log/aide/aide.log
```
* Cleanup via aide-cleanup.sh
  * Optional if demo VM is disposable
