#!/bin/bash

# Colors and symbols for better visualization
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
CHECK_MARK="${GREEN}✓${NC}"
CROSS_MARK="${RED}✗${NC}"
PENDING_MARK="${YELLOW}•${NC}"

# Initialize checklist items as unchecked
declare -A checklist=(
    ["Reviewed all changes"]="false"
    ["Tested the code"]="false"
    ["Updated documentation"]="false"
    ["Removed debug statements"]="false"
    ["Checked for sensitive data"]="false"
)

# Function to display the current state of the checklist
display_checklist() {
    echo -e "\n=== Pre-Push Checklist ==="
    local index=1
    for item in "${!checklist[@]}"; do
        local mark=$([[ ${checklist[$item]} == "true" ]] && echo "$CHECK_MARK" || echo "$PENDING_MARK")
        echo -e "$index. $mark $item"
        ((index++))
    done
}

# Function to toggle a checklist item
toggle_item() {
    local index=$1
    local current_index=1

    for item in "${!checklist[@]}"; do
        if [[ $current_index -eq $index ]]; then
            checklist[$item]=$([[ ${checklist[$item]} == "false" ]] && echo "true" || echo "false")
            break
        fi
        ((current_index++))
    done
}

# Function to check if all items are checked
all_checked() {
    for value in "${checklist[@]}"; do
        if [[ $value == "false" ]]; then
            return 1
        fi
    done
    return 0
}

# Main interactive loop
while true; do
    clear
    display_checklist
    echo -e "\nCommands:"
    echo "• Enter a number (1-${#checklist[@]}) to toggle an item"
    echo "• Enter 'c' to continue if all items are checked"
    echo "• Enter 'q' to quit and cancel the push"

    read -p $'\nEnter command: ' cmd </dev/tty

    case $cmd in
        [1-9])
            if [[ $cmd -le ${#checklist[@]} ]]; then
                toggle_item $cmd
            fi
            ;;
        "c")
            if all_checked; then
                echo -e "\n${GREEN}✅ All items checked! Proceeding with push...${NC}"
                exit 0
            else
                echo -e "\n${RED}⚠️  Please complete all checklist items before continuing.${NC}"
                read -n 1 -s -r -p "Press any key to continue..."
            fi
            ;;
        "q")
            echo -e "\n${YELLOW}Push cancelled. Take your time to review and try again when ready!${NC}"
            exit 1
            ;;
        *)
            echo -e "\n${RED}Invalid command. Please try again.${NC}"
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done
