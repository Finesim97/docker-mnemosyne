#!/bin/bash
set -e
chown -R mnemosyne:mnemosyne /home/mnemosyne/.local/share/mnemosyne/

if [ -z ${USERNAME+x} ] || [ -z ${PASSWORD+x} ] ;  then 
    echo "You have to provide a username(env: USERNAME) and password (env: PASSWORD)"
    exit 1
fi

echo "UPDATE config SET value='''$USERNAME''' WHERE key='remote_access_username'" | su mnemosyne -c "sqlite3 /home/mnemosyne/.config/mnemosyne/config.db"
echo "UPDATE config SET value='''$PASSWORD''' WHERE key='remote_access_password'" | su mnemosyne -c  "sqlite3 /home/mnemosyne/.config/mnemosyne/config.db"

unset USERNAME
unset PASSWORD

if [ "$1" = 'mnemosyne' ]; then
    su mnemosyne -c "mnemosyne --sync-server --web-server"
else
    su mnemosyne -c "exec '$@'"
fi