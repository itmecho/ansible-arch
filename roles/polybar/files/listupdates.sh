#!/bin/sh

polybar-msg hook updates 1 &>/dev/null

checkupdates | rofi -dmenu -i -p "Filter"
