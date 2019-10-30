#!/bin/bash
set -e

if [ ! -f "/home/mnemosyne/.local/share/mnemosyne/machine.id" ] ; then
    echo "from mnemosyne.libmnemosyne.utils import rand_uuid;print(rand_uuid())" | python3 > "/home/mnemosyne/.local/share/mnemosyne/machine.id" 
fi

chown -R mnemosyne:mnemosyne /home/mnemosyne/.local/share/mnemosyne/
cp /home/mnemosyne/.local/share/mnemosyne/machine.id /home/mnemosyne/.config/mnemosyne/machine.id



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
