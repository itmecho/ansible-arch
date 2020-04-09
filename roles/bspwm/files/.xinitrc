#!/bin/sh

#eval $(/usr/bin/gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK

xrandr --auto
xrandr --setprovideroutputsource modesetting NVIDIA-0

numlockx on

exec bspwm
