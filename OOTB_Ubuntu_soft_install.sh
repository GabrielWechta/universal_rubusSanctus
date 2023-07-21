#!/bin/bash
# Run with root privileges
set -x

# Repositories
apt-get update
apt-get upgrade -y

# Git
apt-get install git-all
apt-get install git-lfs

# CLI utils	
apt install tree -y
apt-get install tshark -y

# Python
apt install python3 -y
apt install python3-pip -y
snap install jupyter
snap install pycharm-professional --classic
snap install dataspell --classic
apt install ipython3 -y

# Python 3.9
# this installation should work for every Python version
apt update
apt install software-properties-common -y
add-apt-repository ppa:deadsnakes/ppa
apt install python3.9 -y
apt install python3.9-distutils -y

# Pipenv
pip3 install pipenv

# Java
apt install default-jre -y

# Virtual Box
apt install virtualbox -y

# C-libs
apt-get install libgmp3-dev -y

# Web Browser - Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Wireless config utils
apt install net-tools -y
apt install nmap -y
snap install curl

# Wireshark
echo | add-apt-repository ppa:wireshark-dev/stable
apt-get update
apt-get install wireshark -y
adduser $USER wireshark
dpkg-reconfigure wireshark-common 
usermod -a -G wireshark $USER


# Microsoft Teams
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.5153_amd64.deb -P /tmp
dpkg -i /tmp/teams_1.3.00.5153_amd64.deb

# Editors
snap install code --classic
snap install notepad-plus-plus
snap install sublime-text --classic

# Media
snap install gimp
snap install vlc
apt-get install nomacs -y

apt --fix-broken install -y

# Social
snap install rambox
snap install slack
snap install spotify

# Screen
apt install screen -y

# Htop
snap install htop 

# Signal
cd /tmp
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop
cd 

# Mendeley
# visit this site: https://www.mendeley.com/guides/download-mendeley-desktop/ubuntu/instructions
# then: dpkg -i mendeleydesktop_1.19.8-stable_amd64.deb 

# Gnome
add-apt-repository universe
apt install gnome-tweaks -y
apt install gnome-shell-extensions -y
# visit: https://extensions.gnome.org/
# https://extensions.gnome.org/extension/779/clipboard-indicator/
# https://extensions.gnome.org/extension/750/openweather/

# Firewall
apt install gufw -y

# Cleaner
add-apt-repository ppa:gerardpuig/ppa
apt-get update
apt-get install ubuntu-cleaner -y

# PyWal
apt install imagemagick
pip3 install pywal
export PATH="${PATH}:${HOME}/.local/bin/"

# Rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | bash
source "$HOME/.cargo/env"
rustup update

# Repositories again
apt-get update
apt-get upgrade -y

apt autoremove -y
set +x

echo "After script finishes you may want to delete repeated lines in '/etc/apt/sources.list.d/signal-xenial.list'"
