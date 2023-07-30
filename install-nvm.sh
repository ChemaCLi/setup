#!/bin/bash

function installNVM() {
  # Get the current logged-in user
  CURRENT_USER=$(logname)

  # Download and install NVM for the current user
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

  # Source NVM for the current user
  sudo -u $CURRENT_USER zsh -c 'source ~/.zshrc'

  # Verify NVM installation
  sudo -u $CURRENT_USER zsh -c 'nvm --version'

  # Install the latest LTS version of Node.js
  sudo -u $CURRENT_USER zsh -c 'nvm install --lts'

  # Verify Node.js installation
  sudo -u $CURRENT_USER zsh -c 'node --version'
}
