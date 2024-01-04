# Ubuntu OS Hardening Script

## Introduction
This script is designed to automate the process of hardening Ubuntu Linux 22.04 LTS based on CIS Benchmarks v8. It offers a menu-based interface to guide users through various hardening tasks, including system configuration, network setup, and more.

## Prerequisites
- Ubuntu Linux 22.04 LTS
- Root privileges
- `apt` package manager
- `figlet` tool for ASCII art (the script will attempt to install it if not present)

## Installation
1. Clone the repository or download the script.
2. Make the script executable: `chmod +x OS_Hardening.sh`
3. Run the script as root: `sudo ./OS_Hardening.sh`

## Usage
The script provides a menu-driven interface for various sections:
1. **Initial Setup**: System configuration tasks like partitioning, software updates, and disabling USB automounting.
2. **Services**: Information about service-related controls (Not implemented as not a part of IG-1).
3. **Network Configuration**: Firewall settings and network security configurations.
4. **Logging & Auditing**: (Coming soon).
5. **Access, Authentication & Authorization**: (Coming soon).
6. **System Maintenance**: (Coming soon).

Navigate through the menu and select the desired option to perform the corresponding action.

## Additional Notes
- Some actions (like partitioning) may require a system reboot to take effect.
- Ensure you have a backup of critical data before making system changes.
- This script is currently aligned with CIS Benchmarks v8 for IG1 controls.
