#!/bin/bash
  echo "This is Function 3."
}

# Interactive prompt to select functions
# Interactive prompt to select functions
# Interactive prompt to select functions
# Global list of available functions
declare -a available_functions=("function1" "function2" "function3")

# Global array to store selected functions
declare -a selected_functions=()

# Interactive prompt to select functions
function_prompt() {
  local cursor=0
  local options=("Option 1" "Option 2" "Option 3")

  # Function to display checkboxes
  display_checkboxes() {
    for ((i = 0; i < ${#options[@]}; i++)); do
      local checkbox="[ ]"
      if [ $i -eq $cursor ]; then
        checkbox=" >"
      fi

      if [[ " ${selected_functions[@]} " =~ " ${options[i]} " ]]; then
        checkbox="[${checkbox}*]"
      else
        checkbox="[${checkbox}]"
      fi

      echo "$checkbox ${options[i]}"
    done
  }

  # Main loop
  while true; do
    clear
    echo "Select functions to execute: (use 'q' to navigate up, 'a' to navigate down, 'y' to toggle, press Enter to confirm)"

    display_checkboxes

    # Read user input
    read -rsn1 input

    case $input in
    'q' | 'Q')
      # "q" or "Q" key: move cursor up
      cursor=$(( (cursor - 1 + ${#options[@]}) % ${#options[@]} ))
      ;;
    'a' | 'A')
      # "a" or "A" key: move cursor down
      cursor=$(( (cursor + 1) % ${#options[@]} ))
      ;;
    'y' | 'Y')
      # Toggle checkbox state if the input is 'y' or 'Y'
      local selected_option=${options[cursor]}
      if [[ " ${selected_functions[@]} " =~ " $selected_option " ]]; then
        selected_functions=("${selected_functions[@]/$selected_option}")
      else
        selected_functions+=("$selected_option")
      fi
      ;;
    '')
      # Break the loop if the input is Enter (confirm selection)
      break
      ;;
    esac
  done
}

# Prompt the user to select functions
array_name=("string1" "string2" "string3")
array_name+=("string4", "string5")

echo "function_prompt loaded"

# Execute selected functions
function_prompt

echo "Selected functions:"
for function in "${selected_functions[@]}"; do
  echo "- $function"
done
#!/bin/bash

# Function 1
function function1() {
  echo "This is Function 1."
}

# Function 2
function function2() {
  echo "This is Function 2."
}

# Function 3
function function3() {
  echo "This is Function 3."
}

# Interactive prompt to select functions
# Interactive prompt to select functions
# Interactive prompt to select functions
# Global list of available functions
declare -a available_functions=(function1 function2 function3)

# Global array to store selected functions
declare -a selected_functions=()

# Interactive prompt to select functions
function_prompt() {
  local cursor=0
  local options=("Function 1" "Function 2" "Function 3")

  # Function to display checkboxes
  display_checkboxes() {
    for ((i = 0; i < ${#options[@]}; i++)); do
      local checkbox="[ ]"
      if [ $i -eq $cursor ]; then
        checkbox=" >"
      fi

      if [[ " ${selected_functions[@]} " =~ " $i " ]]; then
        checkbox="[${checkbox}*]"
      else
        checkbox="[${checkbox}]"
      fi

      echo "$checkbox ${options[i]}"
    done
  }

  # Main loop
  while true; do
    clear
    echo "Select functions to execute: (use 'q' to navigate up, 'a' to navigate down, 'y' to toggle, press Enter to confirm)"

    display_checkboxes

    # Read user input
    read -rsn1 input

    case $input in
    'q' | 'Q')
      # "q" or "Q" key: move cursor up
      cursor=$(( (cursor - 1 + ${#options[@]}) % ${#options[@]} ))
      ;;
    'a' | 'A')
      # "a" or "A" key: move cursor down
      cursor=$(( (cursor + 1) % ${#options[@]} ))
      ;;
    'y' | 'Y')
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

# Prompt the user to select functions
array_name=("string1" "string2" "string3")
array_name+=("string4", "string5")

echo "function_prompt loaded"

# Execute selected functions
function_prompt

echo "Executing selected functions:"
for index in "${selected_functions[@]}"; do
  case $index in
  0)
    function1
    ;;
  1)
    function2
    ;;
  2)
    function3
    ;;
  esac
done

# all right, my bad. Discard this last change.
# Now, using the previous version of the script, instead of saving the selected option string to the selected_functions array, I need to store the position of the selected option only
