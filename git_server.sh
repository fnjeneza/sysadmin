#!/bin/bash

adduser git
ssh_folder='/home/git/.ssh'
mkdir $ssh_folder
chmod 700 $ssh_folder
touch $ssh_folder/authorized_keys
chmod 600 $ssh_folder/authorized_keys
chown -R git:git $ssh_folder

apt update
apt install git-core -y

# add git-shell to /etc/shells
git_shell=`which git-shell`
sed -i "\$a$git_shell" /etc/shells
chsh -s $git_shell git

