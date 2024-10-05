# Terraform Installation Playbook

This Ansible playbook is designed to install Terraform on the following Linux distributions:

- Ubuntu 24.04
- Fedora 40
- Amazon Linux 2023
- Arch Linux 6.11
- RHEL 9.4
- Debian 12

The playbook detects the OS version, installs the necessary dependencies, and installs Terraform on the target machines.

## Supported OS Versions

This playbook has been tested and verified on the following OS versions:

- **Ubuntu** 24.04
- **Fedora** 40
- **Amazon Linux** 2023
- **Arch Linux** 6.11
- **RHEL** 9.4
- **Debian** 12

## Usage

1. Clone the repository or download the playbook.
2. Ensure your Ansible inventory is configured to point to the target hosts.
3. Run the playbook using the following command:

   ```bash
   ansible-playbook -i <your_inventory_file> install_terraform.yml --ask-become-pass
