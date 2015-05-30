#!/bin/bash

echo "\\n\\n-----Starting server provisioning-----\\n\\n"

# Variables
APPENV=local
DBHOST=localhost
DBNAME=hackingchinese
DBUSER=hackingchinese
DBPASSWD=hackingchinese
DBFILE=hackingchinese__wp_hc_20150521_904.sql

apt-get -y install curl build-essential python-software-properties

echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections
apt-get -y install mysql-server-5.5

mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'"

apt-get -y install php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-mysql php-apc

a2enmod rewrite

sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*//" /etc/php5/cli/php.ini

cat > /etc/apache2/sites-available/000-hacking-chinese-wp.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /home/vagrant/hacking-chinese-wp/wordpress/
    ServerName hackingchinese.dev
    ServerAlias *.hackingchinese.dev
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    SetEnv APP_ENV $APPENV
    SetEnv DB_HOST $DBHOST
    SetEnv DB_NAME $DBNAME
    SetEnv DB_USER $DBUSER
    SetEnv DB_PASS $DBPASSWD
</VirtualHost>
EOF

cat >> /etc/apache2/httpd.conf "ServerName hackingchinese.dev"

a2ensite 000-hacking-chinese-wp.conf
service apache2 restart

cat >> /home/vagrant/.zshrc <<EOF

# Set envvars
export APP_ENV=$APPENV
export DB_HOST=$DBHOST
export DB_NAME=$DBNAME
export DB_USER=$DBUSER
export DB_PASS=$DBPASSWD
EOF

cd /home/vagrant/sync/hc
gunzip -f $DBFILE.gz > $DBFILE
mysql -u $DBUSER --password=$DBPASSWD $DBNAME < $DBFILE > /dev/null
rm $DBFILE

echo "\\n\\n-----Finished server provisioning-----\\n\\n"
