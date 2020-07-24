#!/bin/sh

. ~/.manywho/ops.conf

if nmcli c show --active | grep -q "Boomi Flow"; then
    count=$(curl -s -u "$GRAFANA_AUTH" ${GRAFANA_URL}/api/alerts\?state=alerting | jq '. | length')
    echo "%{F#ed254e}  %{F-}$count"
fi
