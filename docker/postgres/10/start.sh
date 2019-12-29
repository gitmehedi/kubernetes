#!/bin/bash
set -e
echo -e "===== Start Postgres database ====="
pg_ctlcluster 10 main start

echo -e "===== Create Postgres User    ====="
su - postgres psql -c "CREATE ROLE odoo WITH LOGIN PASSWORD 'odoo' SUPERUSER CREATEDB CREATEROLE REPLICATION;" 2> /dev/null || true


bin/bash
