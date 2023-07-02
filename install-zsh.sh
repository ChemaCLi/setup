#!/bin/bash

function installZSH() {
  echo "Installing ZSH..."

  # Install Zsh
  apt install -y zsh

  # Change the default shell to Zsh
  chsh -s /usr/bin/zsh

  # Print installation completion message
  echo "Zsh has been installed successfully."
}
