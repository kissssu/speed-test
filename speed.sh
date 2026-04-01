#!/bin/bash

# Default config
SERVER="8.8.8.8"
PACKETS=(32 128 512 1024 2048)
COUNT=3

# Colors (optional but nice)
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m"

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --server <ip>         Target server (default: 8.8.8.8)"
    echo "  --packets <sizes>     Packet sizes (comma-separated)"
    echo "  --count <n>           Ping count per test (default: 3)"
    echo "  --help                Show this help"
    echo ""
    echo "Example:"
    echo "  $0 --server 1.1.1.1 --packets 64,256,1024 --count 5"
    exit 0
}

# Parse CLI args
while [[ $# -gt 0 ]]; do
    case $1 in
        --server)
            SERVER="$2"
            shift 2
            ;;
        --packets)
            IFS=',' read -r -a PACKETS <<< "$2"
            shift 2
            ;;
        --count)
            COUNT="$2"
            shift 2
            ;;
        --help)
            show_help
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Progress bar (clean)
progress_bar() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local done=$((percent / 2))
    local left=$((50 - done))

    printf "\r${BLUE}Progress:${NC} ["
    printf "%0.s#" $(seq 1 $done)
    printf "%0.s-" $(seq 1 $left)
    printf "] %d%%" "$percent"
}

# Header
echo -e "${GREEN}=== Network Speed Tool ===${NC}"
echo "Server: $SERVER"
echo "Packets: ${PACKETS[*]}"
echo "Count per test: $COUNT"
echo ""

printf "%-12s | %-15s | %-12s\n" "Packet Size" "Avg RTT (ms)" "Speed (Mbps)"
printf "%-12s-+-%-15s-+-%-12s\n" "------------" "---------------" "------------"

TOTAL_SPEED=0
SUCCESS=0
TOTAL=${#PACKETS[@]}
INDEX=0

for SIZE in "${PACKETS[@]}"; do
    ((INDEX++))
    progress_bar "$INDEX" "$TOTAL"

    RESULT=$(ping -c "$COUNT" -s "$SIZE" "$SERVER" 2>/dev/null)

    if [[ $? -ne 0 ]]; then
        printf "\n%-12s | %-15s | %-12s\n" "$SIZE B" "FAIL" "FAIL"
        continue
    fi

    RTT=$(echo "$RESULT" | awk -F'time=' '/time=/{print $2}' | awk '{ sum+=$1; n++ } END { if(n>0) print sum/n }')

    if [[ -n "$RTT" ]]; thens
        SPEED=$(echo "scale=2; ($SIZE * 8) / $RTT / 1000" | bc)

        TOTAL_SPEED=$(echo "$TOTAL_SPEED + $SPEED" | bc)
        SUCCESS=$((SUCCESS + 1))

        printf "\n%-12s | %-15.2f | %-12.2f\n" "$SIZE B" "$RTT" "$SPEED"
    else
        printf "\n%-12s | %-15s | %-12s\n" "$SIZE B" "FAIL" "FAIL"
    fi
done

echo ""
echo "----------------------------------------------"

if [[ $SUCCESS -gt 0 ]]; then
    AVG=$(echo "scale=2; $TOTAL_SPEED / $SUCCESS" | bc)
    echo -e "${GREEN}Average Speed:${NC} $AVG Mbps"
else
    echo -e "${RED}Test Failed${NC}"
fi

echo -e "${GREEN}Done (готово = done)${NC}"