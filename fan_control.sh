#!/bin/bash

# Function to set fan speed using ipmitool
set_fan_speed() {
    local speed_hex=$1
    echo "Setting fan speed to $((16#$speed_hex))%"
    ipmitool raw 0x30 0x30 0x02 0xff 0x$speed_hex
}

# Function to read CPU temperature from Temp sensor
get_cpu_temp() {
    ipmitool sensor | grep -i "Temp" | awk '/Temp/ {print $3}' | grep -Eo '[0-9]+(\.[0-9]+)?'
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

    # Convert the floating-point temperature to an integer
    cpu_temp_int=$(printf "%.0f" "$cpu_temp")

    echo "Current CPU temperature: $cpu_temp°C (converted to $cpu_temp_int°C)"

    # Determine fan speed based on temperature
    if (( cpu_temp_int <= 50 )); then
        set_fan_speed "05"  # 5% fan speed
    elif (( cpu_temp_int > 50 && cpu_temp_int <= 60 )); then
        set_fan_speed "0A"  # 10% fan speed
    elif (( cpu_temp_int > 60 && cpu_temp_int <= 70 )); then
        set_fan_speed "32"  # 50% fan speed
    else
        set_fan_speed "64"  # 100% fan speed
    fi

    # Wait before checking the temperature again
    sleep 5
done

