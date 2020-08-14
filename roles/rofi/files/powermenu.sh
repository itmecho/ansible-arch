#!/bin/sh

read -r -d '' choices <<EOF
Reboot:systemctl reboot
Shutdown/Power Off:systemctl poweroff
EOF

choice=$(echo "${choices}" | cut -d':' -f1 | rofi -dmenu -i -no-custom)

eval "$(echo "${choices}" | grep "${choice}" | cut -d':' -f2)"
