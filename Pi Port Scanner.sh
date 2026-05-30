#!/bin/bash

echo "============================="
echo "       PI PORT SCANNER       "
echo "============================="
echo ""

if ! command -v ss &>/dev/null; then
    echo "Installing required tools..."
    sudo apt install iproute2 -y
fi

echo "--- Listening Ports ---"
echo ""
printf "%-10s %-10s %-25s %-20s %s\n" "Protocol" "Port" "Address" "Process" "Service"
echo "----------------------------------------------------------------------"

ss -tulnp | grep LISTEN | while read line; do
    proto=$(echo "$line" | awk '{print $1}')
    address=$(echo "$line" | awk '{print $5}')
    port=$(echo "$address" | rev | cut -d: -f1 | rev)
    addr=$(echo "$address" | rev | cut -d: -f2- | rev)
    process=$(echo "$line" | grep -o 'users:(("[^"]*"' | cut -d'"' -f2 | head -1)
    service=$(grep -w "$port/tcp" /etc/services 2>/dev/null | awk '{print $1}' | head -1)
    if [ -z "$service" ]; then
        service=$(grep -w "$port/udp" /etc/services 2>/dev/null | awk '{print $1}' | head -1)
    fi
    printf "%-10s %-10s %-25s %-20s %s\n" "$proto" "$port" "$addr" "${process:-unknown}" "${service:-unknown}"
done

echo ""
echo "--- Active Connections ---"
echo ""
printf "%-10s %-25s %-25s %s\n" "Protocol" "Local Address" "Remote Address" "State"
echo "----------------------------------------------------------------------"
ss -tunp | grep -v LISTEN | grep -v "Local" | while read line; do
    proto=$(echo "$line" | awk '{print $1}')
    state=$(echo "$line" | awk '{print $2}')
    local=$(echo "$line" | awk '{print $5}')
    remote=$(echo "$line" | awk '{print $6}')
    printf "%-10s %-25s %-25s %s\n" "$proto" "$local" "$remote" "$state"
done

echo ""
echo "--- Connection Summary ---"
echo ""
total=$(ss -tunp | grep -v Local | tail -n +2 | wc -l)
established=$(ss -tunp | grep ESTAB | wc -l)
listening=$(ss -tulnp | grep LISTEN | wc -l)
echo "  Total connections:    $total"
echo "  Established:          $established"
echo "  Listening ports:      $listening"

echo ""
echo "--- Top Processes Using Ports ---"
echo ""
sudo ss -tulnp | grep -o 'users:(("[^"]*",[^)]*))' | \
    grep -o '"[^"]*"' | sort | uniq -c | sort -rn | head -10 | \
    while read count name; do
        printf "  %-5s connections: %s\n" "$count" "$name"
    done

echo ""
echo "============================="
