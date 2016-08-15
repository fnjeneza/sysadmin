#!/usr/bin/bash

sudo apt-get install -y tmux tree python-flake8 python-pep8 vim 

git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

#download the vimrc.conf
wget https://raw.githubusercontent.com/fnjeneza/sysadmin/master/vimrc.conf
mv vimrc.conf ~/.vimrc
#run Vundle
vim +PluginInstall

mv tmux.conf ~/.tmux.conf
