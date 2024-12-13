## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare.

Installare i pacchetti e poi copiare i file in "home" seguendo la struttura originale delle cartelle.
Il tutto è preparato per Arch Linux (anche Endeavour OS va bene) ed ha bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, software - come light o xbacklight a seconda della vostra scheda video).


Pacchetti base:

ttf-roboto (font GTK)
ttf-jetbrains-mono (font terminale)
apple-fonts (da AUR. San Francisco Pro Text è usato su herbe e rofi)

feh
git
i3-gaps
rofi
lm_sensors
lxappearance (per regolare icone e tema GTK)
micro
picom
kitty
unclutter (nascondere il puntatore del mouse dopo tot)
thunar (file manager)
thunar-archive-plugin
thunar-volman
udiskie (automunt usb)
xsettingsd (per modificare il tema GTK al volo)


Il tema GTK usato è Akwa e Akwa-dark (pre-impostato nello script di switch). Si può scaricare e installare con:

git clone https://github.com/berkiyo/akwa.git && cd akwa && mkdir -p ~/.themes && cp -r Akwa* ~/.themes

poi va attivato da lxappearance.


Per compilare herbe patchato per usato .Xresources (così da cambiare tema al volo):

git clone https://github.com/dudik/herbe.git && cd herbe
wget https://patch-diff.githubusercontent.com/raw/dudik/herbe/pull/11.diff
git apply 11.diff
sudo make install

Per info, scrivetemi su Patreon. Buon Linux!
