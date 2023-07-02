#!/bin/bash

# Check if the script is run as root (with sudo)
if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

# Function 1
function installZSH() {
  echo "Installing ZSH..."

  # Install Zsh
  apt install -y zsh

  # Change the default shell to Zsh
  chsh -s /usr/bin/zsh

  # Print installation completion message
  echo "Zsh has been installed successfully."
}

# Function 2
function installTabby() {
  echo "Installing Tabby..."
  # Ask the user for the Tabby version
  read -p "Enter the Tabby version to install (default: 1.0.197): " TABBY_VERSION
  TABBY_VERSION=${TABBY_VERSION:-1.0.197}

  # Download Tabby
  # Tabby is not part of the official Ubuntu repositories, so we need to download and install it manually

  # Download Tabby (change the URL if needed)
  TABBYY_FILE="tabby-${TABBY_VERSION}-linux-x64.deb"
  TABBYY_DOWNLOAD_URL="https://github.com/Eugeny/tabby/releases/download/v${TABBY_VERSION}/${TABBYY_FILE}"
  wget "$TABBYY_DOWNLOAD_URL" -O /tmp/"$TABBYY_FILE"

  # Install Tabby
  dpkg -i /tmp/"$TABBYY_FILE"

  # Clean up temporary files
  rm /tmp/"$TABBYY_FILE"

  # Print installation completion message
  echo "Zsh and Tabby have been installed successfully."
}

# Interactive prompt to select functions
# Interactive prompt to select functions
# Interactive prompt to select functions
# Global list of available functions

# Global array to store selected functions
declare -a selected_functions=()

# Interactive prompt to select functions
function_prompt() {
  local cursor=0
  local options=("ZSH" "Tabby")

  # Function to display checkboxes
  display_checkboxes() {
    for ((i = 0; i < ${#options[@]}; i++)); do
      local checkbox="  "
      if [ $i -eq $cursor ]; then
        checkbox=" >"
      fi

      if [[ " ${selected_functions[@]} " =~ " $i " ]]; then
        checkbox="[*] ${checkbox}"
      else
        checkbox="[ ] ${checkbox}"
      fi

      echo "$checkbox ${options[i]}"
    done
  }

  # Main loop
  while true; do
    clear
    echo "What to you want to install? (use 'q' to navigate up, 'a' to navigate down, 'y' to toggle, press Enter to confirm)"

    display_checkboxes

    # Read user input
    read -rsn1 input

    case $input in
    'a' | 'A')
      # "q" or "Q" key: move cursor up
      cursor=$(( (cursor - 1 + ${#options[@]}) % ${#options[@]} ))
      ;;
    'b' | 'B')
      # "a" or "A" key: move cursor down
      cursor=$(( (cursor + 1) % ${#options[@]} ))
      ;;
    'c' | 'C' | 'd' | 'D')
      # Toggle checkbox state if the input is 'y' or 'Y'
      local selected_index=$cursor
      if [[ " ${selected_functions[@]} " =~ " $selected_index " ]]; then
        selected_functions=("${selected_functions[@]/$selected_index}")
      else
        selected_functions+=("$selected_index")
      fi
      ;;
    '')
      # Break the loop if the input is Enter (confirm selection)
      break
      ;;
    esac
  done
}

# Execute selected functions
function_prompt

apt update
apt install -y wget curl

echo "Executing selected functions:"
for index in "${selected_functions[@]}"; do
  case $index in
  0)
    installZSH
    ;;
  1)
    installTabby
    ;;
  esac
  sudo apt --fix-broken install
  sudo apt autoremove
done
