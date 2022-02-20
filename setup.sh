#!/bin/bash

python -m pip install --user ansible
python -m pip install --user paramiko

sudo python get-pip.py
sudo python -m pip install ansible

export PATH=${HOME}/Library/Python/3.8/bin:${PATH}

ansible-galaxy install -r requirements.yml

sudo xcodebuild -license

sudo chown -R $(whoami) /opt/homebrew/Cellar

echo 'export PATH=/opt/homebrew/bin:${PATH}' >> ${HOME}/.zshrc
echo 'export PATH="/opt/homebrew/sbin:$PATH"' >> ~/.zshrc
echo 'export PATH=/opt/homebrew/Cellar/mas/1.8.6/bin:${PATH}' >> ${HOME}/.zshrc
echo 'export PATH=${HOME}/Library/Python/3.8/bin:${PATH}' >> ${HOME}/.zshrc

git config --global init.defaultBranch main

(cd; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")

ansible-playbook main.yml -i localhost, -K
