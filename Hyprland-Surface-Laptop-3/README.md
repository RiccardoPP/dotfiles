## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare.
Io ho usato Endeavour OS installato in modalità "online" e senza scegliere un ambiente desktop nel menù.

Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da SSH, per dire).

Installare i pacchetti e poi copiare i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.
Il tutto, come detto, è preparato per Arch Linux (anche Endeavour OS va bene) e Surface Laptop 3 da 15 pollici AMD.

Ha bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, qualche posizionamento e dimensione se usate un pannello diverso dal 1920x1080 del ThinkPad in esame).
Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.

##
### PACCHETTI ESSENZIALI
##

sudo pacman -Sy --noconfirm --needed brightnessctl qt5ct exa foot micro nemo nemo-fileroller nemo-image-converter hyprland ttf-jetbrains-mono otf-font-awesome terminus-font pamixer swaybg swaylock swayidle grim swappy slurp lazygit polkit-kde-agent python-requests powertop acpid mako gammastep evince mpv htop blueman lxappearance profile-sync-daemon imv

yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S rofi-lbonn-wayland-git wob waybar-hyprland-git xdg-desktop-portal-hyprland-git batsignal zramswap zenpower3-dkms

##
### PACCHETTI OPZIONALI
##

##PER AMD
sudo pacman -S libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)

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

- Se volete installare il kernel specifico per Surface, fate riferimento a https://github.com/linux-surface/linux-surface
- Il tema "green" di Firefox è "Lush - Soft", autore Firefox.
- rimuovere xdg-gnome se c'è errore all'avvio di Hyperland (sudo pacman -R xdg-desktop-portal-gnome)
- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- valutare o meno se installare tlp (oltre a auto-cpufreq)
- controllare gli alias di vostro interesse in .bashrc
- lxappareance (cambiare font in Jetbrains Mono 10)
- qt5ct (cambiare font in Jetbrains Mono 10)
- lo script per la VPN mostrato nel video (https://youtu.be/qYIehiwYRSc) è una versione modificata di https://github.com/loiccoyle/rofi-nordvpn

Per info scrivetemi su Patreon. Buon Linux!
