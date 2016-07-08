#!/bin/bash -xe

xhost local:root 
docker rm --force mnemosyne || true
docker run -d \
    -e DISPLAY=unix$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/Dropbox/dropsync:/home/mnemosyne/dropsync \
    -v ~/Dropbox/dropsync/mnemosyne-config/.config/mnemosyne/:/home/mnemosyne/.config/mnemosyne \
    -v ~/Dropbox/dropsync/mnemosyne-config/.local/share/mnemosyne:/home/mnemosyne/.local/share/mnemosyne \
    --name mnemosyne \
    sublimino/mnemosyne:latest

PAUSE=0.1

activate_window() {
    wmctrl -R Mnemosyne && sleep ${PAUSE} && xdotool getactivewindow && xdotool key ctrl+m && sleep ${PAUSE}
}

shutdown() {
    activate_window && sleep ${PAUSE} && xdotool key alt+e && sleep 2 && xdotool key alt+d
    sleep 2
    wmctrl -c "Mnemosyne"
}

until wmctrl -R Mnemosyne; do sleep 0.1; done

echo Importing
activate_window && sleep ${PAUSE} && xdotool key alt+i && sleep ${PAUSE} && xdotool key alt+d

trap shutdown EXIT

sleep $((60 * 5))
wmctrl -R Mnemosyne
notify-send "Shutdown alert" "Terminating Mnemosyne in 5s..." -u critical --expire-time 5000
sleep 5

trap echo bye EXIT
shutdown
