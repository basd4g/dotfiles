#!/bin/bash -c
apt install -y gdebi
apt install -y ffmpeg
apt install -y git
apt install -y lynx
apt install -y mysql-server
apt install -y mysql-client
apt install -y nkf
apt install -y nmap
apt install -y shellcheck
apt install -y tree
apt install -y ibus-mozc

# xkeysnail
apt install python3-pip
pip3 install xkeysnail

snap install --classic code
snap install --classic heroku

bash "$HOME/dotfiles/bin/packages-init-ubuntu/aptfile.sh"
bash "$HOME/dotfiles/bin/packages-init-ubuntu/docker.sh"
bash "$HOME/dotfiles/bin/packages-init-ubuntu/google-chrome.sh"
bash "$HOME/dotfiles/bin/packages-init-ubuntu/hackgen.sh"
bash "$HOME/dotfiles/bin/packages-init-ubuntu/hyper.sh"
bash "$HOME/dotfiles/bin/packages-init-ubuntu/postgresql.sh"