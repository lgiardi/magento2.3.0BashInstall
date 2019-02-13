############################# Magento Config ################################ 
cd /var/www/html/
php bin/magento setup:install --base-url=http://$url/ \
                        --base-url-secure=https://$url/ \
                        --admin-firstname="John" \
                        --admin-lastname="Doe" \
                        --admin-email="$adminEmail" \
                        --admin-user="$adminUser" \
                        --admin-password="$adminPassword" \
                        --db-name="$database" \
                        --db-host="$dbHost" \
                        --db-user="$dbUser" \
                        --currency=USD \
                        --timezone=America/Chicago \
                        --use-rewrites=1 \
                        --db-password="$dbUserPassword"
############################## Install Static ##############################
php bin/magento setup:static-content:deploy -f
ver=$(cat /var/www/html/pub/static/deployed_version.txt)
cp -R /var/www/html/pub/static/frontend/ /var/www/html/pub/static/version$ver/
cp -R /var/www/html/pub/static/adminhtml/ /var/www/html/pub/static/version$ver/

php bin/magento deploy:mode:set production
php bin/magento cron:install

cd /var/www/html/
find . -type d -exec sudo chmod 770 {} \;
find . -type f -exec sudo chmod 660 {} \;
find ./var -type d -exec sudo chmod 777 {} \;
find ./pub/media -type d -exec sudo chmod 777 {} \;
find ./pub/static -type d -exec sudo chmod 777 {} \;
sudo chmod 777 ./app/etc
sudo chmod 644 ./app/etc/*.xml
sudo chown -R :apache .
sudo chmod 750 bin/magento
############################## Finished ##############################
exit
