```shell
#!/bin/bash -xe

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cask 1password
brew install 1password-cli chezmoi
open -a '1Password'
chezmoi init https://github.com/takuma-saito/dotfiles
```
