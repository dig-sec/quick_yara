#!/bin/bash

# Install YARA
echo "Installing YARA..."
if command -v yara &> /dev/null
then
    echo "YARA is already installed."
else
    sudo apt update && sudo apt install -y yara
    echo "YARA installed successfully."
fi

# Define project directory
PROJECT_DIR="yara_project"
RULES_DIR="$PROJECT_DIR/rules"

# Create project structure
echo "Setting up project structure..."
mkdir -p "$RULES_DIR"
echo "Project directory created at: $PROJECT_DIR"

# Download YARA Forge rules zip
RULES_ZIP="yara-forge-rules-full.zip"
RULES_URL="https://github.com/YARAHQ/yara-forge/releases/download/20241103/$RULES_ZIP"

echo "Downloading YARA Forge rules..."
wget -O "$PROJECT_DIR/$RULES_ZIP" "$RULES_URL"

# Unpack the zip
echo "Unpacking the YARA Forge rules..."
unzip "$PROJECT_DIR/$RULES_ZIP" -d "$RULES_DIR"

# Remove the zip file
echo "Cleaning up..."
rm "$PROJECT_DIR/$RULES_ZIP"

echo "YARA Forge rules downloaded, unpacked, and project structure created successfully."
