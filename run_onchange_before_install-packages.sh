#!/bin/bash -euC

# https://macos-defaults.com/dock/orientation.html
# https://developer.apple.com/documentation/devicemanagement

# Dock
defaults write com.apple.dock "orientation" -string "right"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "static-only" -bool "true"
defaults write com.apple.dock "tilesize" -int "48"
killall Dock || true

# Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
killall Finder || true

# Music
defaults write com.apple.Music "userWantsPlaybackNotifications" -bool "false"
killall Music || true

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
