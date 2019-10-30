# MnemosyneSync Container

This project is for running the [Mnemosyne](https://mnemosyne-proj.org) sync-server in a docker container.

You can run it by creating a `docker-compose.yml` file in a new directory:

```
version: "3.7"
services:
  mnemosyne:
    image: Finesim97/docker-mnemosyne
    environment:
        - USERNAME=user
        - PASSWORD=password
    restart: always
    volumes:
        - ./mnemodata:/home/mnemosyne/.local/share/mnemosyne/ # host:container
    ports:
        - 8512:8512 # Sync Server host:container
#       - 8513:8513 # Web Server, uncomment if you want it
```
And run it in the background with:
```
docker-compose up -d --build
``` 
The database will be in `mnemodata`.

## Config Extraction (Just for Building this image) 

Config paths:
 - Windows: C:\Users\<your user name>\Application Data\Roaming\Mnemosyne
 - Linux: ~/.config/mnemosyne/
 - macOS: ~/Library/Mnemosyne/

Source: https://mnemosyne-proj.org/help/advanced-preferences.php

The `sqllite` command needs to be available:

```
echo ".dump" | sqlite3 config.db > ~/mnemosyne-configdump.sql
```

