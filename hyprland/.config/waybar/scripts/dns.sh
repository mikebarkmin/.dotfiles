#!/bin/bash

# Get the active connection (excluding Hotspot)
ACTIVE_CONN=$(nmcli -t -f NAME,TYPE,STATE connection show --active | grep ':activated$' | grep -v '^Hotspot:' | head -n1 | cut -d: -f1)

if [ -z "$ACTIVE_CONN" ]; then
    echo '{"text": "", "class": "no-dns", "tooltip": "No active connection"}'
    exit 0
fi

# Get DNS servers for the active connection
DNS_SERVERS=$(nmcli -g IP4.DNS connection show "$ACTIVE_CONN")

if [ -z "$DNS_SERVERS" ]; then
    echo "{\"text\": \"\", \"class\": \"dns\", \"tooltip\": \"Connection: $ACTIVE_CONN\\nDNS: Automatic (DHCP)\"}"
else
    # Format multiple DNS servers for tooltip
    DNS_LIST=$(echo "$DNS_SERVERS" | tr '|' '\n' | sed 's/^/  • /')
    PRIMARY_DNS=$(echo "$DNS_SERVERS" | cut -d'|' -f1)
    
    echo "{\"text\": \"\", \"class\": \"dns\", \"tooltip\": \"Connection: $ACTIVE_CONN\\nDNS Servers:\\n$DNS_LIST\"}"
fi
