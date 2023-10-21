#!/bin/bash -euC
mkdir -p ~/.config/alacritty/themes
if [[ ! -d ~/.config/alacritty/themes ]]; then
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
else
  cd ~/.config/alacritty/themes
  git pull origin
fi
