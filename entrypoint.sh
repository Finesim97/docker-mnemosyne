#!/bin/bash
set -e
chown -R mnemosyne:mnemosyne /home/mnemosyne/.local/share/mnemosyne/

if [ -z ${USERNAME+x} ] || [ -z ${PASSWORD+x} ] ;  then 
    echo "You have to provide a username(env: USERNAME) and password (env: PASSWORD)"
    exit 1
fi

echo "UPDATE config SET value='''$USERNAME''' WHERE key='remote_access_username'" | sudo -u mnemosyne sqlite3 /home/mnemosyne/.config/mnemosyne/config.db
echo "UPDATE config SET value='''$PASSWORD''' WHERE key='remote_access_password'" | sudo -u mnemosyne sqlite3 /home/mnemosyne/.config/mnemosyne/config.db

unset USERNAME
unset PASSWORD

if [ "$1" = 'mnemosyne' ]; then
    sudo -u mnemosyne exec mnemosyne --sync-server --web-server
else
    sudo -u mnemosyne exec "$@"
fi