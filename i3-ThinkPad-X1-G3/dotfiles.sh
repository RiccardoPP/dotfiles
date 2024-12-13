#!/bin/bash
# Una cosa terribile, lo so, ma quando avrò tempo...

DIR="$HOME/Documenti/GitHub/dotfiles"
HOST="notebook-thinkpad-x1"

cp $HOME/.config/i3/* $DIR/$HOST/.config/i3/ 
cp $HOME/.config/polybar/* $DIR/$HOST/.config/polybar/ 
cp $HOME/.config/rofi/* $DIR/$HOST/.config/rofi/ 
cp $HOME/.config/compton.conf $DIR/$HOST/.config/ 
cp $HOME/.bashrc $DIR/$HOST/ 
cp $HOME/dotfiles.sh $DIR/  

echo "Fatto."
