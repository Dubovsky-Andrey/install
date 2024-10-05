# Git Installation Playbook

This Ansible playbook is designed to install Git on the following Linux distributions:

- Ubuntu 24.04
- Fedora 40
- Arch Linux 6.11.1
- Debian 12
- Amazon Linux 2023
- RHEL 9.4

The playbook automatically detects the OS family and installs Git using the appropriate package manager for the target system.

## Supported OS Versions

This playbook has been tested and verified on the following OS versions:

- **Ubuntu** 24.04
- **Fedora** 40
- **Arch Linux** 6.11.1
- **Debian** 12
- **Amazon Linux** 2023
- **RHEL** 9.4

## Usage

1. Clone the repository or download the playbook.
2. Ensure your Ansible inventory is configured to point to the target hosts.
3. Run the playbook using the following command:

Remote

   ```bash
   ansible-playbook -i <your_inventory_file> git.yml --ask-become-pass
   ```
Local

   ```bash
   ansible-playbook -i localhost, git.yml --connection=local
   ```