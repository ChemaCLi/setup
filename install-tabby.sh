#!/bin/bash

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
