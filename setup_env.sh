#!/bin/bash

sudo apt-get install -y tmux tree python-flake8 python-pep8 vim 

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# YouCompleteMe dependencies
sudo apt update
sudo apt install -y build-essential cmake
sudo apt install -y python-dev python3-dev

#download the vimrc.conf
wget https://raw.githubusercontent.com/fnjeneza/sysadmin/master/vimrc.conf
mv vimrc.conf ~/.vimrc
#run Vundle
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

mv tmux.conf ~/.tmux.conf
