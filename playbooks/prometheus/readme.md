# Prometheus Node Exporter Installation Playbook

This Ansible playbook is designed to install Prometheus Node Exporter on the following Linux distributions:

- Ubuntu 24.04
- Fedora 40
- Arch Linux 6.11.1
- Debian 12
- Amazon Linux 2023
- RHEL 9.4

The playbook automates the download, installation, and configuration of Prometheus Node Exporter as a systemd service on the target system.

## Supported OS Versions

This playbook has been tested on the following OS versions:

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
   ansible-playbook -i <your_inventory_file> install_node_exporter.yml --ask-become-pass
   ```
Local

   ```bash
   ansible-playbook -i localhost, install_node_exporter.yml --connection=local
   ```

