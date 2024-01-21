#!/bin/bash

# Exit status:
# 0 - Success
# 1 - Invalid option
# 2 - Command not found
# 3 - Path not found
# 4 - Failed to rename file
# 5 - Failed to create symlink
# 6 - Failed to change default shell

# Error handling
handle_error() {
    local exit_code=$?
    local line_number=$1
    local error_message=$2
    echo "An error occurred on line $line_number: $error_message. Exit status: $exit_code"
    exit $exit_code
}
trap 'handle_error $LINENO' ERR

# Define script path and color codes
SCRIPTPATH=$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET_COLOR='\033[0m' # Reset color

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${RESET_COLOR}"
}

# Function to check if a command exists
check_command_exists() {
    local command=$1
    command -v $command > /dev/null 2>&1 || { echo "$command not found"; return 2; }
}

# Reduced code duplication
check_and_rename() {
    local path=$1
    local backup_path="${path}.backup"
    if [[ -f $path ]] || [[ -d $path ]]; then
        mv $path $backup_path > /dev/null 2>&1 || { echo "Failed to rename $path"; return 4; }
    else
        echo "$path not found"
        return 3
    fi
}

# Function to create a symlink by checking if the target exists and renaming it
create_symlink() {
    local source_path=$1
    local target_path=$2
    local target_name=$(basename -- "$target_path")
    # check_and_rename $target_path
    ln -s $source_path $target_path > /dev/null 2>&1 || { echo "Failed to create symlink $target_name from $source_path to $target_path"; return 5; }
}

# Function to set the default shell if it is installed
set_default_shell_if_installed() {
    local desired_shell=$1
    if check_command_exists $desired_shell; then
        if chsh -s $(which $desired_shell) ; then
            echo "Successfully changed the default shell to $desired_shell"
        else
            print_message $RED "Failed to change the default shell to $desired_shell. Please check your permissions and try again."
            return 6
        fi
    else
        print_message $RED "$desired_shell is not installed. Please install it and rerun the script."
        return 1
    fi
}

# User input validation
config_choice=""
prompt_choice() {
    local prompt=${1:-"Enter your choice: "}
    local choices=${2:-"y n"}
    local invalid_message=${3:-"Invalid choice. Please try again."}

    while true; do
        echo "$prompt"
        read -r config_choice
        config_choice=$(echo "$config_choice" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
        if [[ -z "$config_choice" ]] || ! [[ $choices =~ (^|[[:space:]])$config_choice($|[[:space:]]) ]]; then
            echo "$invalid_message"
        else
            break
        fi
    done
}

# Oh-my-zsh
zshrc_symlink() {
    create_symlink "$SCRIPTPATH/zsh/.zshrc" "$HOME/.zshrc" 
    create_symlink "$SCRIPTPATH/zsh/plugins" "$HOME/.oh-my-zsh/custom/plugins" 

    prompt_choice "Do you want to set Zsh as the main shell?" "y n" "Invalid option. Please enter y or n."
    if [[ $config_choice == "y" ]]; then
        set_default_shell_if_installed "zsh"
    fi
}

# Starship
starship_symlink() {
    create_symlink "$SCRIPTPATH/.config/starship.toml" "$HOME/.config/starship.toml" 
}

# Function to handle a configuration
handle_config() {
    local config_name=$1
    local install_function=$2

    prompt_choice "Do you want to install $config_name config?" "y n" "Invalid option. Please enter y or n."
    if [[ $config_choice == "y" ]]; then
        $install_function
    fi
}

# Main script execution
declare -A configs=( ["oh-my-zsh"]="zshrc_symlink" ["starship"]="starship_symlink" )

for config_name in "${!configs[@]}"; do
    handle_config "$config_name" "${configs[$config_name]}"
done