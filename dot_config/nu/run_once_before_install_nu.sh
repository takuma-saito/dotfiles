#!/bin/bash -eu
brew install zoxide asdf starship 1password-cli nushell
mkdir -p ~/.config/nu
zoxide init nushell > ~/.config/nu/zoxide.nu
cp "$(brew --prefix asdf)/libexec/asdf.nu" ~/.config/nu/asdf.nu
starship init nu > ~/.config/nu/starship.nu
mkdir -p ~/.1password
ln -sfn ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
if [[ "$(grep nu /etc/shells)" == "" ]]; then
    sudo bash -c 'echo $(which nu) >> /etc/shells'
fi
chsh -s $(which nu)
nu -c 'echo "source ~/.config/nu/init.nu" | save --append $nu.loginshell-path'
