#!/bin/bash

DB_NAME="wordpress"
SITE_ROOT="/var/www/"

# extract the WordPress archive
tar zxf wordpress-3.5.2.tar.gz
sudo mv wordpress/* $SITE_ROOT

# create the database
mysql -u $WERCKER_MYSQL_USERNAME --password=$WERCKER_MYSQL_PASSWORD \
    --port $WERCKER_MYSQL_PORT -e "SHOW TABLES" $WERCKER_MYSQL_DATABASE;

# mysql -u $WERCKER_MYSQL_USERNAME --password=$WERCKER_MYSQL_PASSWORD \
#     --port $WERCKER_MYSQL_PORT -e "CREATE DATABASE $DB_NAME";
# mysql -u $WERCKER_MYSQL_USERNAME --password=$WERCKER_MYSQL_PASSWORD \
#     --port $WERCKER_MYSQL_PORT -e "GRANT ALL PRIVILEGES ON site.* TO $WERCKER_MYSQL_USERNAME@$WERCKER_MYSQL_HOST IDENTIFIED BY '$WERCKER_MYSQL_PASSWORD'"


# create the wp-config file
sed -e "s/{{DB_NAME}}/$WERCKER_MYSQL_DATABASE/" \
    -e "s/{{DB_USER}}/$WERCKER_MYSQL_USERNAME/" \
    -e "s/{{DB_PASSWORD}}/$WERCKER_MYSQL_PASSWORD/" \
    -e "s/{{DB_HOST}}/$WERCKER_MYSQL_HOST:$WERCKER_MYSQL_PORT/" \
 < wp-config.template > wp-config.php

 sudo mv wp-config.php $SITE_ROOT/wp-config.php
