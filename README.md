## MySQL: Converting all tables in all databases from MyISAM to InnoDB
#### convert-to-innodb
<hr>

If you have plenty of databases with tables in MyISAM format which you'd like to convert to InnoDB, here is a bash script which will do it.

The script only converts MyISAM tables, and will not re-convert already existing InnoDB tables.

Based on: https://lxadm.com/MySQL:_Converting_all_tables_in_all_databases_from_MyISAM_to_InnoDB

My fork is a multi-threaded version of this script for faster usage on multi-core machines.
