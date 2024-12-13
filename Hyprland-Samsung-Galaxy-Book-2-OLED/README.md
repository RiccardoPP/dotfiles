## Riccardo Palombo - email at riccardo dot im


Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare.
Io ho usato Endeavour OS installato in modalità "online" e senza scegliere un ambiente desktop nel menù.
Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da SSH, per dire).

Installare i pacchetti e poi copiare i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

Il tutto è ottimizzato per un Samsung Galaxy Book Pro 2 13 con display OLED da 1920x1080 pixel. Su un display con risoluzione diversa bisogna controllare i parametri del monitor nel config di Hyprland.

Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.



##
### PACCHETTI ESSENZIALI
##

sudo pacman -S brightnessctl qt5ct exa foot micro nemo hyprland ttf-jetbrains-mono waybar otf-font-awesome terminus-font pamixer swaybg swaylock swayidle polkit-kde-agent python-requests nemo-fileroller nemo-image-converter acpid mako gammastep mpv htop blueman profile-sync-daemon imv swappy grim slurp xdg-desktop-portal-hyprland --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None -S wob batsignal tofi tamzen-font ohsnap-otb

##
### PACCHETTI OPZIONALI GPU INTEL
##

sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)

##
#### INFO
##

- Il tema GTK è Material-Black-Mango (https://www.gnome-look.org/p/1316887)
- Il tema icone è Haiku (https://www.gnome-look.org/p/2087825)
- Lo sfondo è basato su: Joshua Rivera https://unsplash.com/photos/white-and-black-wallpaper-usmhPmT5sj0
- Il tema nero di Firefox è quello di sistema

Consiglio di guardare il file autostart ($HOME/.config/hypr/autostart) di Hyprland per i dettagli.

##
### COPIA DOTFILES
##

cp -r home/. ~/
sudo cp -r etc/. /etc/

##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable paccache.timer
systemctl --user enable batsignal.service

##
#### COSE DA FARE
##

- Aggiungere riga a Bootloader per supporto luminosità OLED --> i915.enable_dpcd_backlight=3 in "/etc/kernel/cmdline" (se bootload systemd, altrimenti in /etc/deafult/grub)
- Disattivare cache su disco in firefox about:config (https://wiki.archlinux.org/title/Firefox/Profile_on_RAM)
- Il modulo crypto di waybar (https://github.com/Chadsr/waybar-crypto) ha bisogno delle API gratuite di Coinmarketcap (da inserire poi in /etc/environment)
- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- lxappareance (cambiare font in Misc OhSnap 12)
- qt5ct (cambiare font in Misc OhSnap 12)


Per info scrivetemi su Patreon. Buon Linux!
