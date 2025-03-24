Linux Custom Fan Profile
A simple and customizable solution for dynamically adjusting fan speeds on Linux servers, designed to optimize cooling performance and minimize noise. This project includes a Bash script and a systemd service file to create and automate custom fan profiles using ipmitool.

Features
Dynamically adjusts fan speeds based on real-time CPU temperatures.

Includes user-configurable temperature thresholds and fan speed profiles.

Automatically starts at boot using systemd.

Provides fail-safe behavior in case temperature readings are unavailable.

Compatible with Dell PowerEdge servers and their BMC.

Requirements
A Linux system with ipmitool installed.

Access to the server's Baseboard Management Controller (BMC).

Basic knowledge of shell scripting and system administration.

Installation
Clone the Repository:

bash
git clone https://github.com/smalltractsofland/linux-custom-fan-profile.git
cd linux-custom-fan-profile
Install Dependencies: Ensure ipmitool is installed:

bash
sudo apt update
sudo apt install ipmitool
Copy the Files:

Move fan_control.sh to /opt/scripts/ or another directory of your choice:

bash
sudo mkdir -p /opt/scripts/
sudo mv fan_control.sh /opt/scripts/
Set appropriate permissions:

bash
sudo chmod +x /opt/scripts/fan_control.sh
Set Up the Systemd Service:

Copy fan_control.service to the systemd directory:

bash
sudo mv fan_control.service /etc/systemd/system/
Enable and start the service:

bash
sudo systemctl enable fan_control.service
sudo systemctl start fan_control.service
Configuration
Adjust Temperature Thresholds and Fan Speeds
The default configuration sets the fan speed based on the following CPU temperature ranges:

≤ 50°C: 5% fan speed

51–60°C: 10% fan speed

61–70°C: 50% fan speed

> 70°C: 100% fan speed

You can modify these thresholds and percentages in fan_control.sh to suit your needs.

Fail-Safe Mode
If the script cannot read the CPU temperature, it sets the fan speed to 20% and retries every 60 seconds.

Usage
To manually start the script:

bash
sudo /opt/scripts/fan_control.sh
To check the service status:

bash
sudo systemctl status fan_control.service
To stop the service:

bash
sudo systemctl stop fan_control.service
Contributing
Contributions are welcome! Feel free to open issues or submit pull requests to improve the script or add new features.

License
This project is licensed under the MIT License. See the LICENSE file for details.
