#!/bin/bash

create_symlink() {
  local source_file="$1"
  local dest_link="$2"
  if [ -e "$dest_link" ] || [ -L "$dest_link" ]; then
    rm -rf "$dest_link"
  fi
  ln -s "$source_file" "$dest_link"
  echo "Created symlink: $dest_link -> $source_file"
}

echo "Creating symbolic links in home directory! Warning: will overwrite any existing files!"
DOTFILE_PATH="$(pwd)"

create_symlink "$DOTFILE_PATH"/.bash_alias ~/.bash_alias
create_symlink "$DOTFILE_PATH"/.bash_func ~/.bash_func
create_symlink "$DOTFILE_PATH"/.bash_profile ~/.bash_profile
create_symlink "$DOTFILE_PATH"/.bashrc ~/.bashrc
create_symlink "$DOTFILE_PATH"/.profile ~/.profile
create_symlink "$DOTFILE_PATH"/.zshrc ~/.zshrc
create_symlink "$DOTFILE_PATH"/.p10k.zsh ~/.p10k.zsh
create_symlink "$DOTFILE_PATH"/.aerospace.toml ~/.aerospace.toml

#echo "Installing oh-my-zsh"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#echo "Installing p10k"
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#echo "Installed. Be sure to run 'p10k configure' once everything is up"

