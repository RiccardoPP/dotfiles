## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare.
Io ho usato Endeavour OS installato in modalità "online" e senza scegliere un ambiente desktop nel menù.
Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da SSH, per dire).

Installare i pacchetti e poi copiare i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.
Il tutto, come detto, è preparato per Arch Linux (anche Endeavour OS va bene) e ThinkPad X1 Carbon Full HD.
Ha bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, qualche posizionamento e dimensione se usate un pannello diverso dal 1920x1080 del ThinkPad in esame).
Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.


##
### PACCHETTI ESSENZIALI
##

sudo pacman -S brightnessctl qt5ct exa foot micro nemo nemo-fileroller nemo-image-converter hyprland ttf-jetbrains-mono otf-font-awesome terminus-font pamixer swaybg swaylock swayidle grim swappy lazygit polkit-kde-agent python-requests powertop acpid mako gammastep evince mpv htop blueman lxappearance profile-sync-daemon imv t2fand --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S rofi-lbonn-wayland-git wob waybar-hyprland-git xdg-desktop-portal-hyprland-git batsignal zramswap

##
### PACCHETTI OPZIONALI
##

sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)
sudo pacman -S telegram-desktop hugo gucharmap nodejs npm code gprename gnome-disk-utility

yay -S obs-studio-git gimp-devel wf-recorder apostrophe

##
### RIPRISTINO DCONF
##

dconf load / < dconf-dump

##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable zramswap.service
systemctl enable paccache.timer
systemctl --user enable batsignal.service

##
#### COSE DA FARE
##

- Il modulo crypto di waybar (https://github.com/Chadsr/waybar-crypto) ha bisogno delle API gratuite di Coinmarketcap (da inserire poi in (/etc/environment))
- profile sync daemon, per far girare il profilo di Firefox in RAM (comando "psd", controllare il config in home e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo). Vi consiglio di leggere https://wiki.archlinux.org/title/Firefox/Profile_on_RAM perché servono altri passaggi, forse.
- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- lxappareance (cambiare font in Jetbrains Mono 10)
- qt5ct (cambiare font in Jetbrains Mono 10)

Per info scrivetemi su Patreon. Buon Linux!

Credits:

- Schema colori: https://www.reddit.com/r/UsabilityPorn/comments/meqbw1/how_i_use_fvwm/
- r/UnixPorn: https://www.reddit.com/r/unixporn/
