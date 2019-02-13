############################## Setup Database ############################## 
mysql -u $dbRoot -p$dbRootPassword  -e "CREATE DATABASE $database"
mysql -u $dbRoot -p$dbRootPassword  -e "GRANT ALL ON $database.* TO $dbUser@localhost IDENTIFIED BY '$dbUserPassword';"

sudo service mysqld stop
sudo chkconfig mysqld on
sudo service mysqld start
############################## Configure PHP ############################## 
sudo sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php.ini
sudo sed -i "s/zlib.output_compression = .*/zlib.output_compression = on/" /etc/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 18000/" /etc/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php.ini
sudo sed -i "s/;opcache.save_comments.*/opcache.save_comments = 1/" /etc/php.d/10-opcache.ini
sudo sed -i "s/;opcache.save_comments.*/opcache.save_comments = 1/" /etc/php.d/10-opcache.ini
sudo service httpd restart
############################## Install Composer ############################## 
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
############################## Install Magento ############################## 
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html/