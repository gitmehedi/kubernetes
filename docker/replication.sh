#!/bin/bash

echo -e "Master Server IP (EX: 10.45.10.73): "
read MASTER_IP

systemctl stop postgresql@10-main.service

DB_PATH=/var/lib/postgresql/10/replication

rm -rf $DB_PATH

pg_basebackup -h $MASTER_IP  -D $DB_PATH -P -U odoo --wal-method=stream
chown -R postgres:postgres $DB_PATH

echo "
standby_mode = 'on'
primary_conninfo = 'host=$MASTER_IP port=5432 user=odoo password=gen@200'
restore_command = 'cp /var/lib/pgsql/10/data/archive/%f %p'
trigger_file = '/tmp/postgresql.trigger.5432'
" >> $DB_PATH/recovery.conf

systemctl start postgresql@10-main.service



/usr/lib/postgresql/10/bin/pg_controldata -D /var/lib/postgresql/10/main
du -shc
ls -larth
/usr/lib/postgresql/10/bin/pg_archivecleanup -n -d /odoo  000000010000000800000084


systemctl stop postgresql@10-main.service && systemctl start postgresql@10-main.service
