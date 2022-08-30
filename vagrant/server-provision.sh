#!/bin/bash

# Variables
export APPENV=local
export DBHOST=localhost
export DBNAME=hackingchinese_
export DBUSER=hackingchinese
export DBPASSWD=hackingchinese
export DBPREFIX=wp_hc_
export DBFILE=hackingchinese_com_mysql_service_one_com.sql

apt-get -fy install ca-certificates apt-transport-https software-properties-common
apt-get -fy install curl build-essential

add-apt-repository -y ppa:ondrej/php
apt-get update && apt-get upgrade

echo "mysql-server mysql-server/root_password password ${DBPASSWD}" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${DBPASSWD}" | debconf-set-selections
apt-get -fy install mysql-server

mysql -uroot -p${DBPASSWD} -e "CREATE DATABASE ${DBNAME}"
mysql -uroot -p${DBPASSWD} -e "grant all privileges on ${DBNAME}.* to '${DBUSER}'@'localhost' identified by '${DBPASSWD}'"

apt-get -fy install lamp-server^
apt-get -fy install php8.1 apache2 libapache2-mod-php php8.1-curl php8.1-gd php8.1-mcrypt php8.1-mysql php8.1-apc
apt-get -fy install php8.1-dev php8.1-xdebug

XDEBUGSO=$(find / -name 'xdebug.so' 2> /dev/null)
echo "zend_extension=\"${XDEBUGSO}\"" >> /etc/php/8.1/apache2/php.ini
cat > /etc/php/8.1/apache2/conf.d/20-xdebug.ini <<EOF
zend_extension=xdebug.so

xdebug.default_enable=1
xdebug.extended_info=1
xdebug.force_display_errors=1
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_host=192.168.56.10
EOF

chmod +w /etc/apache2/apache2.conf

sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

sed -i "s/error_reporting = .*/error_reporting = 341/" /etc/php/8.1/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/apache2/php.ini
sed -i "s/disable_functions = .*//" /etc/php/8.1/cli/php.ini

cat >> /etc/apache2/apache2.conf <<EOF

ServerName localhost
EOF

chown -R www-data:www-data /home/vagrant/hacking-chinese-wp/wordpress
echo 'DirectoryIndex index.html index.cgi index.pl index.php index.xhtml' >> /etc/apache2/apache2.conf

cat > /etc/apache2/sites-available/000-hacking-chinese-wp.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /home/vagrant/hacking-chinese-wp/wordpress/
    DirectoryIndex index.php
    <Directory /home/vagrant/hacking-chinese-wp/wordpress/>
      Options FollowSymLinks
      AllowOverride Limit Options FileInfo
      DirectoryIndex index.php
      Require all granted
    </Directory>
    <Directory /home/vagrant/hacking-chinese-wp/wordpress/wp-content>
      Options FollowSymLinks
      Require all granted
    </Directory>
    ServerName hackingchinese.localhost
    ServerAlias *.hackingchinese.localhost
    ServerAlias "*"
    #ErrorLog \${APACHE_LOG_DIR}/error.log
    #CustomLog \${APACHE_LOG_DIR}/access.log combined
    SetEnv APP_ENV ${APPENV}
    SetEnv DB_HOST ${DBHOST}
    SetEnv DB_NAME ${DBNAME}
    SetEnv DB_USER ${DBUSER}
    SetEnv DB_PASS ${DBPASSWD}
    SetEnv DBPREFIX ${DBPREFIX}
</VirtualHost>
EOF

a2dismod ssl
a2enmod rewrite
a2ensite 000-hacking-chinese-wp.conf
a2dissite 000-default.conf
service apache2 restart
systemctl reload apache2

cat >> /home/vagrant/.bashrc <<EOF

# Set envvars
export APPENV=${APPENV}
export DBHOST=${DBHOST}
export DBNAME=${DBNAME}
export DBUSER=${DBUSER}
export DBPASSWD=${DBPASSWD}
export DBFILE=${DBFILE}
export DBPREFIX=${DBPREFIX}
EOF

cd /home/vagrant/sync/hc
ls ${DBFILE}
mysql -u ${DBUSER} --password=${DBPASSWD} --default-character-set=utf8 ${DBNAME} < ${DBFILE} > /dev/null

mysql -uroot -p${DBPASSWD} -e "ALTER DATABASE ${DBNAME} CHARACTER SET utf8"
mysql -uroot -p${DBPASSWD} -e "ALTER TABLE ${DBNAME}.${DBPREFIX}posts CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci"

mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}users (ID, user_login, user_pass, user_nicename, user_email, user_registered, user_status, display_name) VALUES (888, 'developer', MD5('developer'), 'developer', 'developer@hackingchinese.com', NOW(), 0, 'Developer');"
mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT ID FROM ${DBPREFIX}users WHERE user_login = 'developer'), '${DBPREFIX}capabilities', 'a:1:{s:13:\"administrator\";s:1:\"1\";}');"
mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT ID FROM ${DBPREFIX}users WHERE user_login = 'developer'), '${DBPREFIX}user_level', '10');"

mysql -uroot -p$DBPASSWD -e "USE $DBNAME; UPDATE ${DBNAME}.${DBPREFIX}options SET option_value='hc-2015' WHERE option_name='template' OR option_name='stylesheet' LIMIT 2;"
mysql -uroot -p$DBPASSWD -e "USE $DBNAME; UPDATE ${DBNAME}.${DBPREFIX}options SET option_value='http://localhost:8888' WHERE option_name='siteurl' LIMIT 1;"
mysql -uroot -p$DBPASSWD -e "USE $DBNAME; UPDATE ${DBNAME}.${DBPREFIX}options SET option_value='http://localhost:8888' WHERE option_name='home' LIMIT 1;"

cat > /home/vagrant/hacking-chinese-wp/wordpress/wp-config.php <<EOF
<?php
ini_set('display_startup_errors',0);
ini_set('display_errors',0);
error_reporting(341);
define('WP_DEBUG', true);
define('DB_NAME', '${DBNAME}');
define('DB_USER', '${DBUSER}');
define('DB_PASSWORD', '${DBPASSWD}');
define('DB_HOST', '${DBHOST}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', 'utf8_unicode_ci');
define ('WPLANG', 'en-EN');
\$table_prefix = '${DBPREFIX}';
define('WP_HOME','http://localhost:8888');
define('WP_SITEURL','http://localhost:8888');
define('AUTH_KEY', 'a+YRrM~U,x+Z?^[)@8K$9gTx!vaT?T?^lVaaW*TA~$o=tk3]@+,59h}~Lg6a?J#r');
define('SECURE_AUTH_KEY', 'V#f^IDC)}]TENs%ZsN&DjUIaHwF;A1&j:B^t63 L/h0h*~S(NZf/rY6i]s1DH&(c');
define('LOGGED_IN_KEY', 'Y!:,5bJd]a.]2pwD{}S^F#3#S]6z$msoR0t--(mO-a@e&5+fx[a&I#m1%sB?|6?h');
define('NONCE_KEY', 'sYG*F[3aaRW$Y]V3-NFCSKNEBi!|+Z0su .|OEazF.h|wIsp)lCaev(IO{ZjaBwq');
define('AUTH_SALT', '.2+X-%a?{~4E hx..wFdLwY5?H-?q9L5?J!v)S),tHRv_+vIcn@xYt-![~*bc*;h');
define('SECURE_AUTH_SALT', 'K#8|fKac==]F.O@n.7d!!6E )+Y47^#|K-iPvc]G|jaj5Kam]LI!L]qv^i2tUz)x');
define('LOGGED_IN_SALT', 'H1-+xm[{+dh,Qe+s0,kJ%rCLhaD+*s18:$gJF[?pGrIYs-be%R|~;O}[!SA@%uza');
define('NONCE_SALT', 'z[Eaza=MD[e1,52pa_{u?|2)7@UO@Y6ummqMjbamOU)Q^@l4_W-QlGER:KMd(;_?');
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
EOF

cat > /home/vagrant/hacking-chinese-wp/wordpress/.htaccess <<EOF
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
</IfModule>
EOF

service apache2 restart
systemctl reload apache2
