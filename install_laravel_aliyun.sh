yum install epel-release -y
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum install php70 mysql-server nginx -y
yum install php70-php-fpm php70-php-mysql
source /opt/remi/php70/enable
/etc/init.d/mysqld restart
/usr/bin/mysql_secure_installation
