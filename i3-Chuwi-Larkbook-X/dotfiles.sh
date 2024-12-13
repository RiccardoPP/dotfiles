#!/bin/bash
# Una cosa terribile, lo so, ma quando avrò tempo...

DIR="$HOME/Documenti/GitHub/dotfiles"
HOST="notebook-larkbook-x"

cp $HOME/.config/i3/* $DIR/$HOST/.config/i3/ 
cp $HOME/.config/rofi/* $DIR/$HOST/.config/rofi/ 
cp $HOME/.config/picom.conf $DIR/$HOST/.config/ 
cp $HOME/.config/micro/settings.json $DIR/$HOST/.config/micro/ 
cp $HOME/.config/Code\ -\ OSS/User/settings.json $DIR/$HOST/.config/Code\ -\ OSS/User/
cp $HOME/.bashrc $DIR/$HOST/ 
cp $HOME/.profile $DIR/$HOST/
cp $HOME/dotfiles.sh $DIR/$HOST/ 
cp $HOME/.xinitrc $DIR/$HOST/ 
cp $HOME/dotfiles.sh $DIR/$HOST/  
cp $HOME/.Xresources* $DIR/$HOST/  
cp $HOME/Immagini/mappa*.png $DIR/$HOST/Immagini/
cp -r $HOME/.config/kitty/* $DIR/$HOST/.config/kitty/
cp -r $HOME/scripts $DIR/$HOST/
echo "Fatto."
