prompt_user_config() {
    if grep -q "config_selected=0" "$CONFIG_FILE"; then
        echo -e "${YELLOW}[•] Running Skyscraper for info...${NC}"
        Skyscraper &  # Runs in the background
        
        sleep 2  # Give it a moment before showing the prompt
        
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
