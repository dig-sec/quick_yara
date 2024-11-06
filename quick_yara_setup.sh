#!/bin/bash

# Function to check and install YARA
install_yara() {
    if command -v yara &> /dev/null; then
        echo "YARA is already installed."
    else
        echo "Installing YARA..."
        if [ -f /etc/fedora-release ]; then
            sudo dnf install -y yara
        elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
            sudo apt update && sudo apt install -y yara
        else
            echo "Unsupported OS. Please install YARA manually."
            exit 1
        fi
        echo "YARA installed successfully."
    fi
}

# Set up project structure
setup_project_structure() {
    PROJECT_DIR="yara_project"
    RULES_DIR="$PROJECT_DIR/rules"
    RULES_ZIP="yara-forge-rules-full.zip"
    RULES_URL="https://github.com/YARAHQ/yara-forge/releases/download/20241103/$RULES_ZIP"

    echo "Creating project structure..."
    mkdir -p "$RULES_DIR"
    echo "Project directory created at: $PROJECT_DIR"
}

# Download and unpack YARA Forge rules
download_and_unpack_rules() {
    echo "Downloading YARA Forge rules..."
    wget -O "$PROJECT_DIR/$RULES_ZIP" "$RULES_URL"

    echo "Unpacking the YARA Forge rules..."
    unzip "$PROJECT_DIR/$RULES_ZIP" -d "$RULES_DIR"

    echo "Cleaning up..."
    rm "$PROJECT_DIR/$RULES_ZIP"
    echo "YARA Forge rules downloaded, unpacked, and project structure created successfully."
}

# Main execution
install_yara
setup_project_structure
download_and_unpack_rules
