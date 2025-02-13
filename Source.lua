
#!/bin/bash

# Enable colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
GRAY='\033[1;30m'
NC='\033[0m' # No Color

INSTALL_DIR="$HOME/.Pegasus-install"
CONFIG_FILE="$INSTALL_DIR/config"

# Ensure the installation folder exists
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo "setup_done=false" > "$CONFIG_FILE"
fi

# Load config
source "$CONFIG_FILE"

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

# Function: Setup Pegasus (Runs setup script, disabled after first run)
setup_pegasus() {
    if [ "$setup_done" = "true" ]; then
        echo -e "${RED}[✗] Setup has already been completed. You cannot run it again.${NC}"
        sleep 2
        return
    fi

    echo -e "${YELLOW}[•] Setting up Pegasus (Skyscraper)...${NC}"
    curl -O -L -q https://raw.githubusercontent.com/SoumyBhow/Skyscraper-Android-Installer-Script/master/termux_update_skyscraper.sh \
        && chmod +x termux_update_skyscraper.sh \
        && bash termux_update_skyscraper.sh

    echo -e "${GREEN}[✓] Pegasus setup complete!${NC}"
    
    # Mark setup as done
    sed -i 's/setup_done=false/setup_done=true/' "$CONFIG_FILE"
    sleep 1.5
}

# Function: Select User Configuration
select_user_config() {
    echo -e "${BLUE}---------------------------------${NC}"
    echo -e "${GREEN}  1. ARMv7${NC}"
    echo -e "${GREEN}  2. Not ready yet${NC}"
    echo -e "${BLUE}---------------------------------${NC}"
    read -p "Select an option: " config_choice

    case $config_choice in
        1)  
            if [ -d "$INSTALL_DIR" ]; then
                cd "$INSTALL_DIR"
                echo -e "${YELLOW}[•] Removing old config.ini...${NC}"
                rm -f config.ini
                echo -e "${YELLOW}[•] Downloading new config.ini...${NC}"
                wget https://github.com/CSCash/EMU-SETUP-PEGASUS-/releases/download/config.ini/config.ini
                echo -e "${GREEN}[✓] Config updated successfully!${NC}"
            else
                echo -e "${RED}[✗] Folder .Pegasus-install not found! Run Setup first.${NC}"
            fi
            sleep 1.5
            ;;
        2)  
            echo -e "${YELLOW}[•] This option is not ready yet!${NC}"
            sleep 1.5
            ;;
        *)  
            echo -e "${RED}[✗] Invalid option! Try again.${NC}"
            sleep 1
            ;;
    esac
}

# Main Menu Loop
while true; do
    show_banner
    echo -e "${BLUE}---------------------------------${NC}"
    echo -e "${GREEN}  1. Open Screenscraper Website${NC}"
    
    if [ "$setup_done" = "true" ]; then
        echo -e "${GRAY}  2. Setup Pegasus (Already Done)${NC}"
    else
        echo -e "${GREEN}  2. Setup Pegasus${NC}"
    fi

    echo -e "${GREEN}  3. Select User Config${NC}"
    echo -e "${GREEN}  4. Exit${NC}"
    echo -e "${BLUE}---------------------------------${NC}"

    # Ask user for input
    read -p "Select an option: " choice

    case $choice in
        1) open_website ;;  
        2) setup_pegasus ;;
        3) select_user_config ;;
        4) echo -e "${YELLOW}Exiting...${NC}"; exit ;;
        *) echo -e "${RED}Invalid option! Try again.${NC}"; sleep 1 ;;
    esac
done
