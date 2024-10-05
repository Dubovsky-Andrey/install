# AWS CLI Installation Playbook

This Ansible playbook is designed to install the AWS CLI on the following Linux distributions:

- Ubuntu 24.04
- Fedora 40
- Amazon Linux 2023
- Arch Linux 6.11*
- RHEL 9.4
- Debian 12

The playbook includes tasks to detect the OS version, install the necessary dependencies (`unzip` and `curl`), and finally install the AWS CLI.

## Supported OS Versions

This playbook has been tested and verified on the following OS versions:

- **Ubuntu** 24.04
- **Fedora** 40
- **Amazon Linux** 2023
- **Arch Linux** 6.11*
- **RHEL** 9.4
- **Debian** 12

## Usage

1. Clone the repository or download the playbook.
2. Ensure your Ansible inventory is configured to point to the target hosts.
3. Run the playbook using the following command:

Remote

   ```bash
   ansible-playbook -i <your_inventory_file> install_aws_cli.yml --ask-become-pass
   ```
Local

   ```bash
   ansible-playbook -i localhost, install_aws_cli.yml --connection=local
   ```


## Prerequisites

Ensure you have the following prerequisites before running the playbook:

- Ansible installed on your control machine.
- Sudo privileges on the target machines.
- **On RHEL systems**: Ensure that `/usr/local/bin` is included in the `PATH` for both interactive and non-interactive sessions.