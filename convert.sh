#!/bin/bash

# Converts all MyISAM tables in all databases to InnoDB


DATABASES="db1 db2"     # Convert databases db1 and db2 only

#DATABASES="ALL"         # Convert all databases

MYSQL_USER=root
# Uncomment if you're not using ~/.my.cnf file (will receive "Warning: Using a password on the command line interface can be insecure" warnings)
#MYSQL_PASS='some-secret-password'
MYSQL_HOST=localhost


### no need to change anything below
# bail out on undefined variables
set -u

# mysql command we will use
MYSQL_COMMAND="mysql -s -u "$MYSQL_USER" -h $MYSQL_HOST"
# Uncomment if you're not using ~/.my.cnf file (will receive "Warning: Using a password on the command line interface can be insecure" warnings)
#MYSQL_COMMAND="mysql -s -u "$MYSQL_USER" --password="$MYSQL_PASS" -h $MYSQL_HOST"

# get a list of databases if we want to convert all databases
if [ "$DATABASES" == "ALL" ] ; then
    DATABASES=$(echo "SHOW DATABASES" | $MYSQL_COMMAND | egrep -v '(performance_schema|information_schema|mysql)')
fi


for DATABASE in $DATABASES ; do
    echo Converting $DATABASE
    # Check if the table is MyISAM (we don't want to convert InnoDB tables over and over again)
    TABLES=$(echo "SELECT TABLE_NAME FROM information_schema.TABLES where TABLE_SCHEMA = '$DATABASE' and ENGINE = 'MyISAM'" | $MYSQL_COMMAND)
    for TABLE in $TABLES ; do
        echo Converting MyISAM $TABLE to InnoDB
        echo "ALTER TABLE $TABLE ENGINE = INNODB" | $MYSQL_COMMAND $DATABASE
    done
    if [ "x$TABLES" = "x" ] ; then
        echo No MyISAM tables found in $DATABASE database
    fi
    echo
done
