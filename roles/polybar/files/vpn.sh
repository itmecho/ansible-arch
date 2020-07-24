#!/bin/sh

if nmcli c show --active | grep -q "Boomi Flow"; then
    echo "%{F#599a74} 旅 %{F-}"
else
    echo "%{F#386261} 旅 %{F-}"
fi
