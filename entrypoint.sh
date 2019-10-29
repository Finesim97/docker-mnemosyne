#!/bin/bash
set -e

echo "UPDATE config SET value='$USERNAME' WHERE key='remote_access_username'" | sqlite3 /home/mnemosyne/.config/mnemosyne/config.db
echo "UPDATE config SET value='$PASSWORD' WHERE key='remote_access_password'" | sqlite3 /home/mnemosyne/.config/mnemosyne/config.db

if [ "$1" = 'mnemosyne' ]; then
    if [ -z ${USERNAME+x} ] || [ -z ${PASSWORD+x} ] ;  then 
        echo "You have to provide a username(env: USERNAME) and password (env: PASSWORD)"
        exit 1
    fi
    unset USERNAME
    unset PASSWORD
    echo "WHY1"
    exec mnemosyne --sync-server --web-server
    echo "WHY"
fi
unset USERNAME
unset PASSWORD
exec "$@"