## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato all'hardware su cui deve girare.

Io ho usato EndeavourOS installato in modalità "online" e senza scegliere un ambiente desktop nel menù. Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da SSH, per dire).

Installare i pacchetti e poi copiare i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

Il tutto è ottimizzato per un display da 1920x1200 pixel e per un Mini PC Desktop. Su un monitor con risoluzione diversa (soprattutto 4K) bisogna controllare i parametri del monitor nel config di Hyprland e cambiare font (perché i bitmap usati qua non saranno nitidi).

Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.


##
### PACCHETTI ESSENZIALI
##

sudo pacman -S qt5ct exa foot micro nemo hyprland ttf-jetbrains-mono waybar otf-font-awesome pamixer swaybg swaylock swayidle polkit-kde-agent python-requests nemo-fileroller nemo-image-converter mako gammastep blueman profile-sync-daemon swappy grim slurp xdg-desktop-portal-hyprland --noconfirm --needed

yay --provides=false --answerdiff None --answerclean None -S wob tofi tamzen-font ohsnap-otb intel-compute-runtime


##
### PACCHETTI OPZIONALI
##

sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)


##
### COPIA DOTFILES
### Posizionarsi dentro la cartella estratta dall'archivio
##

cp -r home/. ~/
sudo cp -r etc/. /etc/


##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable zramswap.service #SOLO SE POCA RAM
systemctl enable paccache.timer

##
#### COSE IMPORTANTI DA FARE
##

- Disattivare cache su disco in firefox about:config (https://wiki.archlinux.org/title/Firefox/Profile_on_RAM)
- Il modulo crypto di waybar (https://github.com/Chadsr/waybar-crypto) ha bisogno delle API gratuite di Coinmarketcap (da inserire poi in /etc/environment)
- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- lxappareance (cambiare font in Misc OhSnap 12)
- qt5ct (cambiare font in Misc OhSnap 12)
- Plugin Hycov Hyprland  https://github.com/DreamMaoMao/hycov/


##
#### INFO
##

- Il tema GTK è WhiteSur Light (https://www.gnome-look.org/p/1403328/)
- Il tema icone è Haiku (https://www.gnome-look.org/p/2087825)
- Lo sfondo è basato su: Joshua Rivera https://unsplash.com/photos/white-and-black-wallpaper-usmhPmT5sj0
- Il tema nero di Firefox è quello di sistema
- Il font del terminale è Tamzen
- Il font di sistema è Misc OhSnap

Consiglio di guardare il file autostart ($HOME/.config/hypr/autostart) di Hyprland per i dettagli.

Per info scrivetemi su Patreon. Buon Linux!
