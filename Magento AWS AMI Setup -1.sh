############################## Varibles ############################## 
url='Your Website URL example: www.example.com'
adminEmail='Your Magento Admin Emial support@example.com'
adminUser='Your Magento Admin User'
adminPassword='Your Admin User Password'
webUser='Your new Apache System User'

database='New Database Name' ### What do you want to call your database?
dbRoot='root' ### This is the default user for a new database DONT CHANGE
dbRootPassword='New Database Password' #### Create a new password
dbHost='localhost' ### Where is your database installed?
dbUser='New DB User' ### What do you want to call your database user?
dbUserPassword='New DB User Password' ### Create a new password
############################## AWS AMI Setup ############################## 
sudo yum install -y update
sudo yum install -y httpd24 php72 mysql57-server php72-mysqlnd nginx php72-opcache php72-xml php72-mcrypt php72-gd php72-soap php72-redis php72-bcmath php72-intl php72-mbstring php72-json php72-iconv php72-fpm php72-zip
sudo service httpd start
sudo chkconfig httpd on
############################## Create User ############################## 
sudo useradd -m -r -d /home/$webUser $webUser
sudo usermod -a -G apache $webUser
sudo su - $webUser

sudo chown -R $webUser:apache /var/www
sudo chmod 770 /var/www
find /var/www -type d -exec sudo chmod 770 {} \;
find /var/www -type f -exec sudo chmod 664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

rm /var/www/html/phpinfo.php
sudo service httpd restart
sudo service mysqld start
sudo mysql_secure_installation57
