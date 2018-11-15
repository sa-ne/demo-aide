#!/bin/bash

echo -e "Installing AIDE ...
"
yum install -y aide

echo -e "Creating local user for demo ...
"
# This is obviously a terrible security practice, never do this in real life!
useradd --password fakeencryptedpassword aideuser

echo -e " Create directory and content for later ...
"


echo -e "
Creating secret file ...

cat /root/secret-file
"
echo "password=mypassword">/root/secret-file
cat /root/secret-file

echo -e "
Creating keep file ...

cat /root/keep-file
"
echo "keep this file">/root/keep-file
cat /root/keep-file
