#!/bin/sh

if nmcli c show --active | grep -q "Boomi Flow"; then
    echo "%{F#599a74}  %{F-}"
else
    echo "%{F#386261}  %{F-}"
fi
