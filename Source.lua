#!/bin/bash

# Enable colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

INSTALL_DIR="$HOME/.Pegasus-install"
CONFIG_FILE="$INSTALL_DIR/config"

# Ensure the Pegasus-install folder exists
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo -e "${GREEN}[✓] Created installation folder: $INSTALL_DIR${NC}"
fi

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
    echo "config_selected=0" > "$CONFIG_FILE"
    echo -e "${GREEN}[✓] Created config file.${NC}"
fi

# Function: Show Pegasus Banner
show_banner() {
    clear
    echo -e "${BLUE}"
    echo "██████╗ ███████╗ ██████╗  █████╗  ██████╗ ██╗   ██╗ ██████╗ "
    echo "██╔══██╗██╔════╝██╔════╝ ██╔══██╗██╔════╝ ██║   ██║██╔════╝ "
    echo "██████╔╝█████╗  ██║  ███╗███████║██║  ███╗██║   ██║██║  ███╗"
    echo "██╔══██╗██╔══╝  ██║   ██║██╔══██║██║   ██║██║   ██║██║   ██║"
    echo "██║  ██║███████╗╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝╚██████╔╝"
    echo "╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚═════╝ "
    echo -e "${NC}"
}

# Function: Open Website (Screenscraper link)
open_website() {
    echo -e "${YELLOW}[•] Opening Screenscraper website...${NC}"
    xdg-open "https://screenscraper.fr/membreinscription.php"  
    sleep 1
}

# Function: Setup Pegasus (Runs Skyscraper setup)
setup_pegasus() {
    echo -e "${YELLOW}[•] Setting up Pegasus (Skyscraper)...${NC}"
    curl -O -L -q https://raw.githubusercontent.com/SoumyBhow/Skyscraper-Android-Installer-Script/master/termux_update_skyscraper.sh \
        && chmod +x termux_update_skyscraper.sh \
        && bash termux_update_skyscraper.sh
    echo -e "${GREEN}[✓] Pegasus setup complete!${NC}"
    sleep 1.5

    # Run Skyscraper immediately after installation
    echo -e "${YELLOW}[•] Running Skyscraper for initial setup...${NC}"
    Skyscraper &  # Runs in the background
    sleep 2  

    # Prompt for user configuration
    prompt_user_config
}

# Function: Prompt User Configuration (After Install)
prompt_user_config() {
    if grep -q "config_selected=0" "$CONFIG_FILE"; then
        echo -e "${BLUE}---------------------------------${NC}"
        echo -e "${GREEN}  Select Your Configuration:${NC}"
        echo -e "${GREEN}  1. ARMv7${NC}"
        echo -e "${GREEN}  2. Not available yet${NC}"
        echo -e "${BLUE}---------------------------------${NC}"
        read -p "Select an option: " config_choice

        case $config_choice in
            1)  
                echo "config_selected=1" > "$CONFIG_FILE"
                echo -e "${GREEN}[✓] Configuration set to ARMv7.${NC}"
                sleep 1
                ;;
            2)  
                echo -e "${YELLOW}[•] This option is not ready yet!${NC}"
                sleep 1
                ;;
            *)  
                echo -e "${RED}[✗] Invalid option! Try again.${NC}"
                sleep 1
                prompt_user_config
                ;;
        esac
    fi
}

# Function: Config Management (Login to Scraper)
config_management() {
    while true; do
        echo -e "${BLUE}---------------------------------${NC}"
        echo -e "${GREEN}  1. Login to Scraper${NC}"
        echo -e "${GREEN}  2. Back to Main Menu${NC}"
        echo -e "${BLUE}---------------------------------${NC}"
        read -p "Select an option: " config_choice

        case $config_choice in
            1) login_to_scraper ;;
            2) break ;;
            *) echo -e "${RED}Invalid option! Try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Main Menu Loop (WITHOUT Config Option)
while true; do
    show_banner
    echo -e "${BLUE}---------------------------------${NC}"
    echo -e "${GREEN}  1. Open Screenscraper Website${NC}"
    echo -e "${GREEN}  2. Setup Pegasus${NC}"
    echo -e "${GREEN}  3. Config Management${NC}"
    echo -e "${GREEN}  4. Exit${NC}"
    echo -e "${BLUE}---------------------------------${NC}"

    read -p "Select an option: " choice

    case $choice in
        1) open_website ;;
        2) setup_pegasus ;;  # Runs Skyscraper + Prompts User Config
        3) config_management ;;
        4) echo -e "${YELLOW}Exiting...${NC}"; exit ;;
        *) echo -e "${RED}Invalid option! Try again.${NC}"; sleep 1 ;;
    esac
done
