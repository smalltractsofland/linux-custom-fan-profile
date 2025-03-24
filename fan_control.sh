#!/bin/bash

# Function to set fan speed using ipmitool
set_fan_speed() {
    local speed_hex=$1
    echo "Setting fan speed to $((16#$speed_hex))%"
    ipmitool raw 0x30 0x30 0x02 0xff 0x$speed_hex
}

# Function to read CPU temperature from Temp sensor
get_cpu_temp() {
    ipmitool sensor | grep -i "Temp" | awk '{print $2}'
}

# Main loop
while true; do
    # Get the current CPU temperature
    cpu_temp=$(get_cpu_temp)
    
    if [[ -z "$cpu_temp" ]]; then
        echo "Failed to read CPU temperature. Setting fan speed to 20%."
        set_fan_speed "20"  # 20% fan speed
        sleep 60
        continue
    fi

    echo "Current CPU temperature: $cpu_temp°C"

    # Determine fan speed based on temperature
    if (( $(echo "$cpu_temp <= 50" | bc -l) )); then
        set_fan_speed "05"  # 5% fan speed
    elif (( $(echo "$cpu_temp > 50 && $cpu_temp <= 60" | bc -l) )); then
        set_fan_speed "0A"  # 10% fan speed
    elif (( $(echo "$cpu_temp > 60 && $cpu_temp <= 70" | bc -l) )); then
        set_fan_speed "32"  # 50% fan speed
    else
        set_fan_speed "64"  # 100% fan speed
    fi

    # Wait before checking the temperature again
    sleep 5
done

