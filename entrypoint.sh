#!/bin/bash
set -e

if [ "$1" = 'mnemosyne' ]; then
    if [ -z ${USERNAME+x} ] || [ -z ${PASSWORD+x} ] ;  then 
        echo "You have to provide a username(env: USERNAME) and password (env: PASSWORD)"
        exit 1
    fi
    echo "UPDATE config SET value='$USERNAME' WHERE key='remote_access_username'" | sqlite3 /home/mnemosyne/.config/mnemosyne/config.db
    echo "UPDATE config SET value='$PASSWORD' WHERE key='remote_access_password'" | sqlite3 /home/mnemosyne/.config/mnemosyne/config.db
    unset USERNAME
    unset PASSWORD
    exec mnemosyne --sync-server --webserver
fi
exec "$@"