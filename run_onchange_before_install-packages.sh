#!/bin/bash -eu

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

# System
defaults write -g NSRequiresAquaSystemAppearance -bool Yes

# Touch Bar
defaults write com.apple.touchbar.agent PresentationModeGlobal -string fullControlStrip
killall "ControlStrip" || true

brew bundle --force --file=/dev/stdin <<EOF
# Basic Setup
cask "google-chrome"
cask "google-japanese-ime"
cask "karabiner-elements"
cask "coteditor"
cask "1password"
cask "zoom"
cask "alfred"
cask "stats"
cask "maccy"

# CLI Must Use
brew "nvim"
brew "nushell"
brew "starship"
brew "zellij"
brew "peco"
brew "sd"
brew "fd"
brew "ripgrep"
brew "pre-commit"
brew "gh"
cask "docker"
cask "alacritty"
cask "1password-cli"

# CLI Development
brew "shellcheck"
brew "shfmt"
brew "mas"
brew "openvpn"

# Development
brew "jq"
brew "asdf"
EOF

# op account add --address my.1password.com

# Spotlight
sudo mdutil -a -i off
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# Menu
cat <<EOF | defaults import com.apple.controlcenter -
{
    "LastHeartbeatDateString.daily" = "2023-10-15T14:12:16Z";
    "NSStatusItem Preferred Position Battery" = 215;
    "NSStatusItem Preferred Position BentoBox" = 143;
    "NSStatusItem Preferred Position FocusModes" = 333;
    "NSStatusItem Preferred Position WiFi" = 177;
    "NSStatusItem Visible AudioVideoModule" = 0;
    "NSStatusItem Visible Battery" = 1;
    "NSStatusItem Visible BentoBox" = 1;
    "NSStatusItem Visible Clock" = 1;
    "NSStatusItem Visible FocusModes" = 1;
    "NSStatusItem Visible Item-0" = 0;
    "NSStatusItem Visible Item-1" = 0;
    "NSStatusItem Visible Item-2" = 0;
    "NSStatusItem Visible Item-3" = 0;
    "NSStatusItem Visible Item-4" = 0;
    "NSStatusItem Visible Item-5" = 0;
    "NSStatusItem Visible WiFi" = 1;
}
EOF

cat <<EOF | defaults import com.apple.menuextra.clock -
{
    FlashDateSeparators = 0;
    IsAnalog = 0;
    ShowAMPM = 1;
    ShowDate = 2;
    ShowDayOfWeek = 1;
    ShowSeconds = 0;
}
EOF

# Install 1password extension to chrome
readonly chrome_ext_dir=~/"Library/Application Support/Google/Chrome/External Extensions/"
mkdir -p "$chrome_ext_dir"
cat <<EOF >"$chrome_ext_dir/aeblfdkhhhdcdjpifhhbdiojplfjncoa.json"
{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}
EOF

# Google Input Method
cat <<EOF | defaults import com.apple.inputsources -
{
    AppleEnabledThirdPartyInputSources =     (
                {
            "Bundle ID" = "com.google.inputmethod.Japanese";
            InputSourceKind = "Keyboard Input Method";
        },
                {
            "Bundle ID" = "com.google.inputmethod.Japanese";
            "Input Mode" = "com.apple.inputmethod.Japanese";
            InputSourceKind = "Input Mode";
        }
    );
}
EOF

if [[ "" == "$(gh auth token)" ]]; then
    gh auth login
fi
