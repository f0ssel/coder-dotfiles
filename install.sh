#!/usr/bin/env bash

DOTFILES_CLONE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for dotfile in "$DOTFILES_CLONE_PATH/".*; do
  # Skip `..` and '.'
  [[ $dotfile =~ \.{1,2}$ ]] && continue
  # Skip Git related
  [[ $dotfile =~ \.git$ ]] && continue
  [[ $dotfile =~ \.gitignore$ ]] && continue
  [[ $dotfile =~ \.gitattributes$ ]] && continue

  echo "Symlinking $dotfile"
  ln -sf "$dotfile" "$HOME"
done

yes | sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s $(readlink -f $(which zsh)) $USER

if [ ! -d "$HOME/c" ] ; then
    git clone git@github.com:cdr/c.git "$HOME/c"
fi