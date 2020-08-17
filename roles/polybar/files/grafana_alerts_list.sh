#!/bin/sh

. ~/.manywho/ops.conf

if nmcli c show --active | grep -q "Boomi Flow"; then
    curl -s -u "$GRAFANA_AUTH" ${GRAFANA_URL}/api/alerts\?state=alerting | jq -r '.[].name' | rofi -dmenu -i -p "Filter"
fi
