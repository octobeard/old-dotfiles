#!/bin/bash
echo "Creating symbolic links in home directory! Warning: will overwrite any existing files!"
DOTFILE_PATH="$(pwd)"

ln -s $DOTFILE_PATH/.bash_alias ~/.bash_alias
ln -s $DOTFILE_PATH/.bash_func ~/.bash_func
ln -s $DOTFILE_PATH/.bash_profile ~/.bash_profile
ln -s $DOTFILE_PATH/.bashrc ~/.bashrc
ln -s $DOTFILE_PATH/.profile ~/.profile
ln -s $DOTFILE_PATH/.zshrc ~/.zshrc
ln -s $DOTFILE_PATH/.p10k.zsh ~/.p10k.zsh

#echo "Installing oh-my-zsh"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#echo "Installing p10k"
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#echo "Installed. Be sure to run 'p10k configure' once everything is up"

source ~/.profile
