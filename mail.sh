#!/bin/bash
#change hostname
sudo hostnamectl set-hostname mailserver
sudo rm /etc/hosts
echo "127.0.0.1 localhost" | sudo tee /etc/hosts
echo "127.0.0.1 mailserver.jdajs.cf mailserver" | sudo tee -a /etc/hosts
#users
sudo useradd -m test1
echo test1:qweR1234 | sudo chpasswd
sudo useradd -m test2
echo test1:qweR1234 | sudo chpasswd
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

#mysql install
sudo apt install mysql-server 
sudo apt mysql-server-core-8.0 
sudo apt mysql-server-client-8.0 -y

#Rouncube configurations
sudo apt install php7.4 libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-cli php-pear php7.4-opcache php7.4-gd php7.4-curl php7.4-cli php7.4-imap php7.4-mbstring php7.4-intl php7.4-soap php7.4-ldap php-imagick php7.4-xmlrpc php7.4-xml php7.4-zip -y


#reboot services
sudo systemctl restart postfix
sudo systemctl restart dovecot

