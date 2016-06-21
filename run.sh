#!/bin/bash -xe

xhost local:root 
docker run -it -e DISPLAY=unix$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Dropbox/dropsync:/home/mnemosyne/dropsync \
    -v ~/Dropbox/dropsync/mnemosyne-config/.config/mnemosyne/:/home/mnemosyne/.config/mnemosyne \
    -v ~/Dropbox/dropsync/mnemosyne-config/.local/share/mnemosyne:/home/mnemosyne/.local/share/mnemosyne \
    sublimino/mnemosyne:latest
