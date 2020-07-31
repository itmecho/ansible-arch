#!/bin/sh

if nmcli c show --active | grep -q "Boomi Flow"; then
    echo "%{F#a3be8c} 旅 %{F-}"
else
    echo "%{F#ebcb8b} 旅 %{F-}"
fi
