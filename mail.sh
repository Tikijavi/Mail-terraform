#!/bin/bash
#postfix install
sudo wget https://raw.githubusercontent.com/Tikijavi/Mail-terraform/main/postfix-confjs.sh
sudo sh postfix-confjs.sh
sudo apt-get install -q postfix -y
sudo postconf -e "home_mailbox= Maildir/"

#dovecot install
sudo apt-get install dovecot-core dovecot-imapd dovecot-pop3d -y
sudo wget https://raw.githubusercontent.com/Tikijavi/Mail-terraform/main/10-mail.conf
sudo wget https://raw.githubusercontent.com/Tikijavi/Mail-terraform/main/10-auth.conf
sudo cp 10-mail.conf /etc/dovecot/conf.d/10-mail.conf
sudo cp 10-auth.conf /etc/dovecot/conf.d/10-auth.conf








#reboot services
sudo systemctl restart postfix
sudo systemctl restart dovecot

