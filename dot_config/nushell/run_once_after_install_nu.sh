#!/bin/bash -eu
mkdir -p ~/.config/nushell
zoxide init nushell > ~/.config/nushell/zoxide.nu
cp "$(brew --prefix asdf)/libexec/asdf.nu" ~/.config/nushell/asdf.nu
starship init nu > ~/.config/nushell/starship.nu
mkdir -p ~/.1password
ln -sfn ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
if [[ "$(grep nu /etc/shells)" == "" ]]; then
    sudo bash -c 'echo $(which nu) >> /etc/shells'
    chsh -s $(which nu)
fi
nu -c 'config reset; if (open $nu.config-path | lines | where $it =~ "~/.config/nushell/init.nu" | is-empty) { "source ~/.config/nushell/init.nu" | save --append $nu.config-path }'
