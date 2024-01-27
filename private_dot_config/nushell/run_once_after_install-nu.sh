#!/bin/bash -eu
mkdir -p ~/.config/nushell
zoxide init nushell | str replace --all "-- $rest" "-- ...$rest" | str replace --all "def-env" "def --env" | save -f ~/.config/nushell/zoxide.nu # https://github.com/ajeetdsouza/zoxide/issues/662#issuecomment-1893740288
cp "$(brew --prefix asdf)/libexec/asdf.nu" ~/.config/nushell/asdf.nu
starship init nu > ~/.config/nushell/starship.nu
atuin init nu --disable-up-arrow > ~/.config/nushell/atuin.nu
mise activate nu > ~/.config/nushell/mise.nu
mkdir -p ~/.1password
ln -sfn ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
if [[ "$(grep nu /etc/shells)" == "" ]]; then
    sudo bash -c 'echo $(which nu) >> /etc/shells'
    chsh -s $(which nu)
fi
cat <<EOF | op inject | sh
atuin login \
  --username "{{ op://Personal/atuin/username }}" \
  --password "{{ op://Personal/atuin/password }}" \
  --key "{{ op://Personal/atuin/key }}"
atuin sync
EOF
nu -c 'config reset; if (open $nu.config-path | lines | where $it =~ "~/.config/nushell/init.nu" | is-empty) { "source ~/.config/nushell/init.nu" | save --append $nu.config-path }'
