#!/bin/bash
set -e
pg_ctlcluster 10 main start

su - postgres -c "createuser -s odoo" 2> /dev/null || true

bin/bash
