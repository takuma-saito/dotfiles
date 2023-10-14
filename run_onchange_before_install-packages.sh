#!/bin/bash -euC

brew bundle --file=/dev/stdin <<EOF
# Basic Setup
cask "google-chrome"
cask "google-japanese-ime"
cask "karabiner-elements"
cask "coteditor"
cask "1password"
cask "zoom"

# CLI
brew "nvim"
brew "nushell"
brew "starship"
brew "zellij"
cask "docker"
cask "alacritty"
cask "1password-cli"

# Development
brew "jq"
brew "asdf"

EOF

op account add --address my.1password.com
