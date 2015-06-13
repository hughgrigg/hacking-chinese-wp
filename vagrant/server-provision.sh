#!/bin/bash

# Variables
APPENV=local
DBHOST=localhost
DBNAME=hackingchinese
DBUSER=hackingchinese
DBPASSWD=hackingchinese
DBPREFIX=wp_hc_
DBFILE=hackingchinese__wp_hc_20150521_904.sql

apt-get -y install curl build-essential python-software-properties

echo "mysql-server mysql-server/root_password password ${DBPASSWD}" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${DBPASSWD}" | debconf-set-selections
apt-get -y install mysql-server-5.5

mysql -uroot -p${DBPASSWD} -e "CREATE DATABASE ${DBNAME}"
mysql -uroot -p${DBPASSWD} -e "grant all privileges on ${DBNAME}.* to '${DBUSER}'@'localhost' identified by '${DBPASSWD}'"

apt-get -y install php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-mysql php-apc

chmod +w /etc/apache2/apache2.conf

sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*//" /etc/php5/cli/php.ini

cat >> /etc/apache2/apache2.conf <<EOF

ServerName localhost
EOF

cat > /etc/apache2/sites-available/000-hacking-chinese-wp.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /home/vagrant/hacking-chinese-wp/wordpress/
    ServerName hackingchinese.dev
    ServerAlias *.hackingchinese.dev
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    SetEnv APP_ENV ${APPENV}
    SetEnv DB_HOST ${DBHOST}
    SetEnv DB_NAME ${DBNAME}
    SetEnv DB_USER ${DBUSER}
    SetEnv DB_PASS ${DBPASSWD}
</VirtualHost>
EOF

a2enmod rewrite
a2ensite 000-hacking-chinese-wp.conf
service apache2 restart > /dev/null

cat >> /home/vagrant/.zshrc <<EOF

# Set envvars
export APPENV=${APPENV}
export DBHOST=${DBHOST}
export DBNAME=${DBNAME}
export DBUSER=${DBUSER}
export DBPASS=${DBPASSWD}
EOF

cd /home/vagrant/sync/hc
gunzip -fc ${DBFILE}.gz > ${DBFILE}
mysql -u ${DBUSER} --password=${DBPASSWD} --default-character-set=utf8 ${DBNAME} < ${DBFILE} > /dev/null
rm ${DBFILE}

mysql -uroot -p${DBPASSWD} -e "ALTER DATABASE ${DBNAME} CHARACTER SET utf8"
mysql -uroot -p${DBPASSWD} -e "ALTER TABLE ${DBNAME}.${DBPREFIX}posts CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci"

mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}users (ID, user_login, user_pass, user_nicename, user_email, user_registered, user_status, display_name) VALUES (888, 'developer', MD5('developer'), 'developer', 'developer@hackingchinese.com', NOW(), 0, 'Developer');"
mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT ID FROM ${DBPREFIX}users WHERE user_login = 'developer'), '${DBPREFIX}capabilities', 'a:1:{s:13:\"administrator\";s:1:\"1\";}');"
mysql -uroot -p${DBPASSWD} -e "USE $DBNAME; INSERT INTO ${DBNAME}.${DBPREFIX}usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, (SELECT ID FROM ${DBPREFIX}users WHERE user_login = 'developer'), '${DBPREFIX}user_level', '10');"

mysql -uroot -p$DBPASSWD -e "USE $DBNAME; UPDATE ${DBNAME}.${DBPREFIX}options SET option_value='hc-2015' WHERE option_name='template' OR option_name='stylesheet' LIMIT 2;"

cat > /home/vagrant/hacking-chinese-wp/wordpress/wp-config.php <<EOF
<?php
ini_set('display_startup_errors',1);
ini_set('display_errors',1);
error_reporting(E_ALL);
define('WP_DEBUG', true);
define('DB_NAME', '${DBNAME}');
define('DB_USER', '${DBUSER}');
define('DB_PASSWORD', '${DBPASSWD}');
define('DB_HOST', '${DBHOST}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', 'utf8_unicode_ci');
define ('WPLANG', 'en-EN');
\$table_prefix = '${DBPREFIX}';
define('WP_HOME','http://hackingchinese.dev');
define('WP_SITEURL','http://hackingchinese.dev');
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
