#!/bin/bash

DB_NAME="wordpress"
SITE_ROOT="/var/www/"

# extract the WordPress archive
tar zxf wordpress-3.5.2.tar.gz
mv wordpress $DB_NAME

# create the database
mysql -u $WERCKER_MYSQL_USERNAME --password=$WERCKER_MYSQL_PASSWORD \
    -e "CREATE DATABASE $DB_NAME";
mysql -u $WERCKER_MYSQL_USERNAME --password=$WERCKER_MYSQL_PASSWORD \
    -e "GRANT ALL PRIVILEGES ON site.* TO $WERCKER_MYSQL_USERNAME@$WERCKER_MYSQL_HOST IDENTIFIED BY '$WERCKER_MYSQL_PASSWORD'"

# create the wp-config file
sed -e "s/{{DB_NAME}}/$DB_NAME/" \
    -e "s/{{DB_USER}}/$WERCKER_MYSQL_USERNAME/" \
    -e "s/{{DB_PASSWORD}}/$WERCKER_MYSQL_PASSWORD/" \
    -e "s/{{DB_HOST}}/$WERCKER_MYSQL_HOST:$WERCKER_MYSQL_PORT/" \
 < wp-config.template > $SITE_ROOT/wp-config.php
