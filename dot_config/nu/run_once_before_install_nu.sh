#!/bin/bash -eu
brew install zoxide asdf starship 1password-cli
mkdir -p ~/.config/nu
zoxide init nushell > ~/.config/nu/zoxide.nu
cp "$(brew --prefix asdf)/libexec/asdf.nu" ~/.config/nu/asdf.nu
starship init nu > ~/.config/nu/starship.nu
ln -sfn ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
