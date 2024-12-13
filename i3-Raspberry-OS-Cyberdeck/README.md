## Riccardo Palombo - email at riccardo dot im

VIDEO: https://youtu.be/b35hHezrAr0


### PACCHETTI BASE PER RASPBERRY OS LITE
    sudo apt install i3-wm xserver-xorg xinit rxvt-unicode unclutter fonts-terminus fonts-roboto fonts-jetbrains-mono git xfonts-terminus xscreensaver


### PACCHETTI UTILI DOPO PER COMPILARE
    sudo apt install libxinerama-dev libxft-dev ninja-build libncursesw5-dev liblua5.3-dev zlib1g-dev libsdl2-dev libsdl2-ttf-dev golang


### INSTALLARE LOG2RAM (https://github.com/azlux/log2ram)
    echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/azlux.list
    sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
    sudo apt update
    sudo apt install log2ram

    # Riavviare e controllare
    sudo reboot
    systemctl status log2ram (per controllare che sia attivo. Se non lo è, leggere a fine pagina nel sito ufficiale come ridurre il log esistente).


### INSTALLARE LAZYGIT (prendere ultima release "armv6" da https://github.com/jesseduffield/lazygit/releases)
    wget https://github.com/jesseduffield/lazygit/releases/download/v0.34/lazygit_0.34_Linux_armv6.tar.gz
    tar xvfz lazygit_0.34_Linux_armv6.tar.gz
    sudo mv lazygit /usr/bin/


### COMPILARE DMENU CON PATCHES
    cd ~/code && git clone git://git.suckless.org/dmenu && cd dmenu/ && wget https://tools.suckless.org/dmenu/patches/border/dmenu-border-20201112-1a13d04.diff https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-5.0.diff && git apply dmenu-lineheight-5.0.diff && git apply dmenu border-20201112-1a13d04.diff && make && sudo make install


### COMPILARE WORDGRINDER 0.8 (CON LE SUCCESSIVE NON VA XWORDGRINDER) PER DISATTIVARE LE BARRE IN BASSO
    cd ~/code && wget https://github.com/davidgiven/wordgrinder/archive/refs/tags/0.8.tar.gz && cd tar xvfz 0.8.tar.gz
    micro src/lua/document.lua (cambiare in "false" la riga 704)
    micro src/lua/main.lua (commentare la riga 238)
    micro src/lua/addons/autosave.lua (commentare la riga 15)
    make PREFIX=/usr && sudo make install PREFIX=/usr


### COMPILARE GLUQLO (OROLOGIO SALVASCHERMO)
    sudo apt install build-essential libsdl1.2-dev libsdl-ttf2.0-dev libsdl-gfx1.2-dev libx11-dev
    git clone https://github.com/alexanderk23/gluqlo.git && cd gluqlo
    make && sudo make install && sudo cp /usr/lib/xscreensaver/gluqlo /usr/bin/
