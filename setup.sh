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

# Set up rules directory
setup_rules_directory() {
    RULES_DIR="rules"
    RULES_ZIP="yara-forge-rules-full.zip"
    RULES_URL="https://github.com/YARAHQ/yara-forge/releases/download/20241103/$RULES_ZIP"

    echo "Setting up rules directory..."
    mkdir -p "$RULES_DIR"
}

# Download, unpack, and move YARA Forge rule file
download_and_unpack_rules() {
    echo "Downloading YARA Forge rules..."
    wget -O "$RULES_ZIP" "$RULES_URL"

    echo "Unpacking the YARA Forge rules..."
    unzip "$RULES_ZIP" -d "$RULES_DIR"

    # Move the specific rule file to the rules directory
    echo "Moving yara-rules-full.yar to the rules directory..."
    mv "$RULES_DIR/packages/full/yara-rules-full.yar" "$RULES_DIR/"

    # Clean up unnecessary directories and the ZIP file
    echo "Cleaning up..."
    rm -rf "$RULES_DIR/packages"
    rm "$RULES_ZIP"
    echo "YARA Forge rules downloaded, unpacked, and organized in the rules directory."
}

# Main execution
install_yara
setup_rules_directory
download_and_unpack_rules

