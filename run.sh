#!/bin/bash -xe

xhost local:root 
docker rm --force mnemosyne
docker run -d \
    -e DISPLAY=unix$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Dropbox/dropsync:/home/mnemosyne/dropsync \
    -v ~/Dropbox/dropsync/mnemosyne-config/.config/mnemosyne/:/home/mnemosyne/.config/mnemosyne \
    -v ~/Dropbox/dropsync/mnemosyne-config/.local/share/mnemosyne:/home/mnemosyne/.local/share/mnemosyne \
    --name mnemosyne \
    sublimino/mnemosyne:latest

sleep $((5))
notify-send "Shutdown alert" "Terminating Mnemosyne in 5s..." -u critical --expire-time 5000
sleep 5
wmctrl -c "Mnemosyne"

