#!/bin/sh

read -r -d '' choices <<EOF
/home/iain/.quickedit
/home/iain/.config/alacritty/alacritty.yml
/home/iain/.config/nvim/init.vim
/home/iain/.config/bspwm/bspwmrc
/home/iain/.config/sxhkd/sxhkdrc
EOF

echo "${choices}" | rofi -dmenu -i | xargs -r alacritty -e vim
