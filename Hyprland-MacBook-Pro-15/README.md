## Riccardo Palombo - email at riccardo dot im

Questo README è specifico per MacBook Pro 15 Late 2013 (ma vale pressappoco per tutti i MacBook Intel di quel periodo).

Consiglio di applicare queste configurazioni ad un OS già adattato al laptop su cui deve girare. Se volete applicarle ad un laptop già in funzione, create un nuovo utente ed usate quello.

Se volete mantenere macOS in Dual Boot, consiglio di creare la partizione per Linux da Utility Disco di macOS, e poi inserire la chiavetta USB con Linux e tenere premuto Option all'avvio per fare il boot da questa; il resto procede come su qualsiasi PC.

Io ho usato EndeavourOS installato in modalità "online" e senza scegliere un ambiente desktop nel menù. Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da un'altra macchina via "SSH", per dire, e copio l'archivio zip dei dots con il comando "SCP").

Quindi installate i pacchetti e poi copiate i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

Guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.

##
### PACCHETTI ESSENZIALI
##

sudo pacman -S brightnessctl qt5ct foot micro nemo nemo-fileroller nemo-image-converter hyprland ttf-jetbrains-mono otf-font-awesome terminus-font pamixer swaybg swaylock swayidle grim swappy lazygit polkit-kde-agent python-requests powertop acpid mako gammastep evince mpv htop blueman lxappearance profile-sync-daemon imv  --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S rofi-lbonn-wayland-git wob waybar-hyprland-git xdg-desktop-portal-hyprland-git batsignal zramswap

##
### PACCHETTI OPZIONALI
##

sudo pacman -S libva-intel-driver libvdpau-va-gl libva-utils vdpauinfo intel-media-sdk (acc hw gpu, da abilitare nel file /etc/environment)


##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable zramswap.service (solo se poca RAM)
systemctl enable paccache.timer
systemctl --user enable batsignal.service


##
#### COSE DA FARE
##

- abilitare la GPU Intel: seguire le istruzioni su https://gist.github.com/stefanocoding/c6dbf4489f330021bd9335d655c9fbbf)

- spegnere la GPU Nvidia (fare riferimento a https://wiki.archlinux.org/title/MacBookPro11,x#Graphics)
yay -S systemd-vgaswitcheroo-units
sudo systemctl enable vgaswitcheroo.service

- disabilitare il VP9 perché la GPU Intel non lo decodifica:
Su Firefox, in "about:config" cercare "media.mediasource.vp9.enabled" e mettere "false"

- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)

- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)

- lxappareance (cambiare font in Jetbrains Mono 10)

- qt5ct (cambiare font in Jetbrains Mono 10)

### PER NORDVPN
- installare il pacchetto nordvpn-bin da AUR e fare il login a NORDVPN: istruzioni su https://wiki.archlinux.org/title/NordVPN


Gli sfondi "OS9" si scaricano da qui: https://arun.is/blog/os9-wallpaper/

Per info scrivetemi su Patreon. Buon Linux!
