#!/bin/bash
echo Installing Required Packages
pacman -Syu
cat config-required-packages | xargs pacman -S

echo Installing Powerline Fonts
cd /tmp
git clone https://github.com/powerline/fonts && cd fonts
./install.sh
cd .. && rm -rf fonts
