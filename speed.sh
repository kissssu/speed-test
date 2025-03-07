#!/bin/bash

calculate_speed() {
    server="8.8.8.8" # Google DNS server
    packet_sizes=("32" "128" "512" "1024" "2048") # Different packet sizes
    total_speed=0
    successful_packets=0
    total_packets=${#packet_sizes[@]}

    echo "--- Speed Test Results ---"
    echo "Packet Size | Average RTT (ms) | Speed (Mbps)"
    echo "--------------------------------------------"

    for size in "${packet_sizes[@]}"; do
        rtt=$(ping -c 3 -s "$size" "$server" | awk '/time=/ {print $7}' | cut -d '=' -f 2 | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n }')

        if [[ -n "$rtt" ]]; then
            speed=$(echo "scale=2; ($size * 8) / $rtt / 1000" | bc) # Mbps
            total_speed=$(echo "scale=2; $total_speed + $speed" | bc)
            successful_packets=$((successful_packets + 1))
            printf "%-12s | %-18s | %-12s\n" "$size bytes" "$rtt" "$speed"
        else
            printf "%-12s | %-18s | Failed\n" "$size bytes" "N/A"
        fi
    done

    echo "--------------------------------------------"
    echo "Total Packets Sent: $total_packets"
    echo "Successful Packets: $successful_packets"

    if [[ $successful_packets -gt 0 ]]; then
        average_speed=$(echo "scale=2; $total_speed / $successful_packets" | bc)
        echo "Estimated Average Speed: $average_speed Mbps"
    else
        echo "Speed test failed."
    fi
}

calculate_speed &
pid=$!
wait $pid
