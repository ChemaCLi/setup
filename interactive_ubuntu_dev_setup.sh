#!/bin/bash

# Check if the script is run as root (with sudo)
if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

source ./install-tabby.sh
source ./install-zsh.sh

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
    echo "What to you want to install? (use 'up' and 'down' to navigate, and 'left' or 'right' to toggle, press Enter to confirm)"

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
