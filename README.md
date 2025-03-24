# Linux Custom Fan Profile

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple and customizable solution for dynamically adjusting fan speeds on Linux servers, designed to optimize cooling performance and minimize noise. This project includes a Bash script and a systemd service file to create and automate custom fan profiles using `ipmitool`.

## Features

-   **Dynamic Fan Control:** Adjusts fan speeds based on real-time CPU temperatures.
-   **Configurable Profiles:** User-configurable temperature thresholds and fan speed profiles.
-   **Systemd Integration:** Automatically starts at boot using systemd.
-   **Fail-Safe Mechanism:** Provides fail-safe behavior in case temperature readings are unavailable.
-   **Compatibility:** Compatible with Dell PowerEdge servers and their Baseboard Management Controller (BMC).

## Requirements

-   A Linux system with `ipmitool` and `bc` installed.
-   Access to the server's Baseboard Management Controller (BMC).
-   Basic knowledge of shell scripting and system administration.

## Installation

1.  **Clone the Repository:**

    ```bash
    wget https://github.com/smalltractsofland/linux-custom-fan-profile.git && cd linux-custom-fan-profile
    ```

2.  **Install Dependencies:**

    Ensure `ipmitool` and `bc` are installed:

    ```bash
    sudo apt update &&
    sudo apt install ipmitool bc
    ```

3.  **Copy the Files:**

    -   Move `fan_control.sh` to `/opt/scripts/` or another directory of your choice:

        ```bash
        sudo mkdir -p /opt/scripts/ &&
        sudo mv fan_control.sh /opt/scripts/ &&
        sudo chmod +x /opt/scripts/fan_control.sh
        ```

    -   Move `fan_control.service` to the systemd directory:

        ```bash
        sudo mv fan_control.service /etc/systemd/system/
        ```

4.  **Set Up the Systemd Service:**

    -   Reload systemd:

        ```bash
        sudo systemctl daemon-reload
        ```

    -   Enable the service:

        ```bash
        sudo systemctl enable fan_control.service
        ```

    -   Start the service:

        ```bash
        sudo systemctl start fan_control.service
        ```

## Configuration

### Adjust Temperature Thresholds and Fan Speeds

The default configuration sets the fan speed based on the following CPU temperature ranges:

-   $\leq 50^\circ C$: 5% fan speed
-   $51-60^\circ C$: 10% fan speed
-   $61-70^\circ C$: 50% fan speed
-   $> 70^\circ C$: 100% fan speed

You can modify these thresholds and percentages in `fan_control.sh` to suit your needs.

### Fail-Safe Mode

If the script cannot read the CPU temperature, it sets the fan speed to 20% and retries every 60 seconds.

## Usage

### Manually Start the Script:

```bash
sudo /opt/scripts/fan_control.sh
Check the Service Status:
Bash

sudo systemctl status fan_control.service
Stop the Service:
Bash

sudo systemctl stop fan_control.service
Contributing
Contributions are welcome! Feel free to open issues or submit pull requests to improve the script or add new features.

License
This project is licensed under the MIT License. See the LICENSE file for details.
