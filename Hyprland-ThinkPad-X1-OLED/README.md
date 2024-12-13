## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare.
Io ho usato Endeavour OS installato in modalità "online" e senza scegliere un ambiente desktop nel menù.
Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da SSH, per dire).

Installare i pacchetti e poi copiare i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

Il tutto è ottimizzato per un ThinkPad X1 Carbon con display OLED da 2880x1800 pixel. Su un display con risoluzione diversa bisogna controllare i parametri del monitor nel config di Hyprland.

Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.


##
### PACCHETTI ESSENZIALI
##

sudo pacman -S brightnessctl qt5ct exa foot micro nemo hyprland ttf-jetbrains-mono waybar otf-font-awesome terminus-font pamixer swaybg swaylock swayidle polkit-kde-agent python-requests nemo-fileroller nemo-image-converter acpid mako gammastep mpv blueman profile-sync-daemon imv swappy grim slurp xdg-desktop-portal-hyprland --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None -S wob batsignal rofi-lbonn-wayland-git


##
### PACCHETTI OPZIONALI
##

sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)
sudo pacman -S telegram-desktop hugo gucharmap nodejs npm gnome-disk-utility code gprename evince zramswap lazygit powertop htop

yay -S obs-studio-git gimp-devel wf-recorder apostrophe


##
### COPIA DOTFILES
##

cp -r home/. ~/
sudo cp -r etc/. /etc/


##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable zramswap.service #SOLO SE POCA RAM
systemctl enable paccache.timer
systemctl --user enable batsignal.service


##
#### DETTAGLI GRAFICI
##

Il tema icone del video è kora-yellow
Il tema GTK del video è Material-Black-Cherry
Il tema nero di Firefox è Matte Black

Consiglio di guardare il file autostart ($HOME/.config/hypr/autostart) di Hyprland per i dettagli.

##
#### COSE DA FARE
##

- Il modulo crypto di waybar (https://github.com/Chadsr/waybar-crypto) ha bisogno delle API gratuite di Coinmarketcap (da inserire poi in /etc/environment)
- Disattivare cache su disco in firefox about:config (https://wiki.archlinux.org/title/Firefox/Profile_on_RAM)
- Profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- Cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- Lxappareance (cambiare font in Jetbrains Mono 10)
- Qt5ct (cambiare font in Jetbrains Mono 10)

Per info scrivetemi su Patreon. Buon Linux!
