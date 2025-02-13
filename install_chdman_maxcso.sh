#!/bin/bash

# Define install paths
INSTALL_DIR="$HOME/.local/bin"

# Function to install CHDMAN
install_chdman() {
    echo "Checking for CHDMAN..."
    if ! command -v chdman &>/dev/null; then
        echo "CHDMAN not found! Downloading and installing."

        echo "Installing dependencies..."
        pkg install -y build-essential git ninja

        echo "Cloning CHDMAN source..."
        git clone https://github.com/CharlesThobe/chdman.git || exit 1
    else
        echo "Updating CHDMAN..."
        cd chdman || exit 1
        git pull
        cd ..
    fi

    echo "Compiling CHDMAN..."
    cd chdman || exit 1
    rm -rf build && mkdir build && cd build || exit 1
    cmake -G Ninja .. && ninja || exit 1

    echo "Installing CHDMAN..."
    mkdir -p "$INSTALL_DIR"
    cp chdman "$INSTALL_DIR/chdman"
    chmod +x "$INSTALL_DIR/chdman"
    echo "CHDMAN installed successfully in $INSTALL_DIR"
}

# Function to install MaxCSO
install_maxcso() {
    echo "Checking for MaxCSO..."
    if ! command -v maxcso &>/dev/null; then
        echo "MaxCSO not found! Downloading and installing."

        echo "Installing dependencies..."
        pkg install -y binutils build-essential git liblz4 libuv

        echo "Cloning MaxCSO source..."
        git clone https://github.com/unknownbrackets/maxcso.git || exit 1
    else
        echo "Updating MaxCSO..."
        cd maxcso || exit 1
        git pull
        cd ..
    fi

    echo "Compiling MaxCSO..."
    cd maxcso || exit 1
    make || exit 1

    echo "Installing MaxCSO..."
    mkdir -p "$INSTALL_DIR"
    cp maxcso "$INSTALL_DIR/maxcso"
    chmod +x "$INSTALL_DIR/maxcso"
    echo "MaxCSO installed successfully in $INSTALL_DIR"
}

# Main execution
install_chdman
install_maxcso
echo "Installation complete. Make sure $INSTALL_DIR is in your PATH."
