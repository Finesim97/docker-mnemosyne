# MnemosyneSync Container

This project is for running the Mnemosyne Sync server in a docker container.




## Building 

Config paths:
 - Windows: C:\Users\<your user name>\Application Data\Roaming\Mnemosyne
 - Linux: ~/.config/mnemosyne/
 - macOS: ~/Library/Mnemosyne/

Source: https://mnemosyne-proj.org/help/advanced-preferences.php

The `sqllite` command needs to be available:

```
echo ".dump" | sqlite3 config.db > ~/mnemosyne-configdump.sql
```

