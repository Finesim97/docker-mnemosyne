#!/bin/bash -xe

xhost local:root 
docker build --tag mnemosyne:latest .
docker run -it -e DISPLAY=unix$DISPLAY    -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.config/mnemosyne/:/home/mnemosync/.config/mnemosyne -v ~/.local/share/mnemosyne:/home/mnemosyne/.local/share/mnemosyne mnemosyne:latest
