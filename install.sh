#!/usr/bin/env bash

# zsh
sudo apt update && yes | sudo apt install zsh unzip
if [ ! -d "$HOME/c" ] ; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi	
sudo chsh -s $(readlink -f $(which zsh)) $USER

# aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# dotfiles
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

# git
if [ ! -d "$HOME/c" ] ; then
    git clone git@github.com:cdr/c.git "$HOME/c"
fi
