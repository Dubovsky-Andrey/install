#!/bin/bash

#--------------------------------------------------------------------
# Script to Install Docker and Docker Compose on Ubuntu
# Tested on: 
#           Ubuntu 24.04
# Developed by Andrey Dubovsky
#--------------------------------------------------------------------
# How to Use:
#   1. Make the script executable:
#      chmod +x ubuntu_24_04_install_docker.sh
#
#   2. Run the script with the required --user parameter:
#      ./ubuntu_24_04_install_docker.sh --user <username>
#      Example:
#      ./ubuntu_24_04_install_docker.sh --user jenkins
#
#   3. Use --help for more information:
#      ./ubuntu_24_04_install_docker.sh --help
#
#   The --user parameter specifies which user will be added to the docker group.
#   If the parameter is missing, the script will terminate with an error.
#--------------------------------------------------------------------

LOG_FILE="/var/log/docker_install.log"

# Function for logging info
function log_info() {
    echo "[INFO] $1"
}

# Function for logging success
function log_success() {
    echo "[SUCCESS] $1"
}

# Function for logging errors
function log_error() {
    echo "[ERROR] $1"
    exit 1
}

# Function to check if the previous command succeeded
function check_command_success() {
    if [ $? -ne 0 ]; then
        log_error "$1"
    else
        log_success "$2"
    fi
}

# Remove old Docker versions and related programs
function remove_old_docker() {
    log_info "Removing old Docker versions and related programs..."
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt-get remove -y $pkg
        check_command_success "Failed to remove $pkg" "$pkg removed successfully"
    done
}

# Add Docker's official GPG key
function add_docker_keys() {
    log_info "Adding Docker's official GPG key..."
    sudo apt-get update
    check_command_success "Failed to update package lists" "Package lists updated successfully"
    
    sudo apt-get install -y ca-certificates curl
    check_command_success "Failed to install ca-certificates and curl" "ca-certificates and curl installed successfully"
    
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    check_command_success "Failed to download Docker GPG key" "Docker GPG key downloaded successfully"
    
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    check_command_success "Failed to set permissions on Docker GPG key" "Permissions set successfully on Docker GPG key"
}

# Add Docker repository to Apt sources
function add_docker_repository() {
    log_info "Adding Docker repository to Apt sources..."
    
    VERSION_CODENAME=$(lsb_release -cs)
    check_command_success "Failed to get Ubuntu codename" "Ubuntu codename is $VERSION_CODENAME"
    
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    ${VERSION_CODENAME} stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    check_command_success "Failed to add Docker repository" "Docker repository added successfully"
}

# Install Docker and Docker Compose
function install_docker() {
    log_info "Installing Docker and Docker Compose..."
    sudo apt-get update
    check_command_success "Failed to update package lists" "Package lists updated successfully"
    
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
    check_command_success "Failed to install Docker and Docker Compose" "Docker and Docker Compose installed successfully"
}

# Verify Docker and Docker Compose installation
function verify_docker_installation() {
    log_info "Verifying Docker installation..."
    
    sudo docker run hello-world
    check_command_success "Failed to run hello-world Docker container" "Docker hello-world container ran successfully"
    
    sudo docker version
    check_command_success "Failed to get Docker version" "Docker version obtained successfully"
    
    sudo docker compose version
    check_command_success "Failed to get Docker Compose version" "Docker Compose version obtained successfully"
}

# Add user to Docker group
function add_user_to_docker_group() {
    log_info "Adding user $DOCKER_USER to Docker group"
    
    sudo usermod -aG docker $DOCKER_USER
    check_command_success "Failed to add user $DOCKER_USER to docker group" "User $DOCKER_USER added to docker group successfully"
}

# Parse named parameters
function parse_params() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --user) DOCKER_USER="$2"; shift ;; # Устанавливаем DOCKER_USER если передан --user
            --help) 
                echo "Usage: $0 --user <username>"
                exit 0
                ;;
            *)
                echo "Unknown parameter passed: $1"
                echo "Use --help for usage information."
                exit 1
                ;;
        esac
        shift
    done

    # Если DOCKER_USER не задан, выводим ошибку
    if [ -z "$DOCKER_USER" ]; then
        echo "Error: --user parameter is required"
        echo "Usage: $0 --user <username>"
        exit 1
    fi
}

# Main function
function main() {
    log_info "Starting Docker installation process..."

    remove_old_docker
    add_docker_keys
    add_docker_repository
    install_docker
    verify_docker_installation
    add_user_to_docker_group

    log_info "Docker installation completed successfully"
}

# Parse command-line arguments
parse_params "$@"

# Start the main function
main
