#!/bin/bash
# Una cosa terribile, lo so, ma quando avrò tempo...

DIR="$HOME/dotfiles"
HOST="notebook-xps-13"

cp -r $HOME/.config/sway/ $DIR/$HOST/home/.config/ 
cp -r $HOME/.config/rofi/ $DIR/$HOST/home/.config/
cp -r $HOME/.config/waybar/ $DIR/$HOST/home/.config/
cp -r $HOME/script $DIR/$HOST/home/
cp -r $HOME/pics $DIR/$HOST/home/
cp -r $HOME/.themes/Dracula-rp/ $DIR/$HOST/home/.themes/
cp $HOME/.config/libinput-gestures.conf $DIR/$HOST/home/.config/
cp $HOME/.config/electron* $DIR/$HOST/home/.config/
cp $HOME/.config/foot/foot.ini $DIR/$HOST/home/.config/foot/
cp $HOME/.config/micro/settings.json $DIR/$HOST/home/.config/micro/ 
cp $HOME/.config/nwg-wrapper/logo* $DIR/$HOST/home/.config/nwg-wrapper/
cp $HOME/.config/nwg-wrapper/info* $DIR/$HOST/home/.config/nwg-wrapper/
cp $HOME/.config/Code\ -\ OSS/User/settings.json $DIR/$HOST/home/.config/Code\ -\ OSS/User/
cp $HOME/.bashrc $DIR/$HOST/home/ 
cp $HOME/dotfiles.sh $DIR/$HOST/ 
cp $HOME/.Xdefaults $DIR/$HOST/home/
cp /etc/environment $DIR/$HOST/etc/  
echo "Fatto."
