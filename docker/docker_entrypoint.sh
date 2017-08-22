#! /bin/sh

if [ ! -f /app/var/db.sqlite3 ]; then
    echo "Importing initial.sql"
    cat /app/src/initial.sql | sqlite3 /app/var/db.sqlite3
fi

exec /app/bin/python /app/src/broker.py
