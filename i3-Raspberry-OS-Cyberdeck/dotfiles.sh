#!/bin/bash
# Questo script serve solo a fare una copia dei dots in una cartella che poi sincronizzeremo.
# Una cosa terribile, lo so, ma quando avrò tempo...

DIR="$HOME/dotfiles"
HOST="cyberdeck"

cp -r $HOME/.config/i3/ $DIR/$HOST/home/.config/ 
cp -r $HOME/.wordgrinder $DIR/$HOST/home/
cp $HOME/dotfiles.sh $DIR/$HOST/ 
cp $HOME/temp.sh $DIR/$HOST/home/
cp $HOME/.config/micro/settings.json $DIR/$HOST/home/.config/micro/ 
cp $HOME/.bash_aliases $DIR/$HOST/home/ 
cp $HOME/.Xdefaults $DIR/$HOST/home/
cp $HOME/.xscreensaver $DIR/$HOST/home/
cp /boot/config.txt $DIR/$HOST/boot/  
echo "Fatto."
