## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un OS già adattato al laptop su cui deve girare. Se volete applicarle ad un laptop già in funzione, create un nuovo utente ed usate quello.

Seguite le istruzioni per l'installazione di Linux su MacBook con T2: https://t2linux.org/

Come ho detto nel video, è un sito un po' incasinato ma contiene tutto il necessario quindi vale la pena passarci del tempo. Dovete disabilitare il Secure Boot da macOS, preparare la partizione per Linux da macOS, e poi inserire la chiavetta USB e tenere premuto Option all'avvio per il boot da questa; il resto procede come sempre.

Io ho usato EndeavourOS installato in modalità "online" e senza scegliere un ambiente desktop nel menù. Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da "SSH", per dire, e copio l'archivio zip dei dots con il comando "SCP").

Quindi installate i pacchetti e poi copiate i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

Il tutto, come detto, è preparato per MacBook Pro 13 2019 quindi potrebbe aver bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, qualche posizionamento e dimensione dei pannelli, forse la grandezza dei font) se usate un laptop con schermo diverso.

Guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware.


##
### PACCHETTI ESSENZIALI
##

sudo pacman -S brightnessctl qt5ct exa foot micro nemo nemo-fileroller nemo-image-converter hyprland ttf-jetbrains-mono otf-font-awesome terminus-font pamixer swaybg swaylock swayidle grim swappy lazygit polkit-kde-agent python-requests powertop acpid mako gammastep evince mpv htop blueman lxappearance profile-sync-daemon imv t2fand --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S rofi-lbonn-wayland-git wob waybar-hyprland-git xdg-desktop-portal-hyprland-git batsignal zramswap

##
### PACCHETTI OPZIONALI
##

sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, da abilitare nel file /etc/environment)

##
### SERVIZI DA ABILITARE
##

systemctl enable --now bluetooth.service
systemctl enable zramswap.service
systemctl enable paccache.timer
systemctl --user enable batsignal.service
systemctl enable --now t2fand.service

##
#### COSE DA FARE
##

- rimuovere moduli brcmfmac blacklist da /usr/lib/modprobe.d/broadcom-wl-dkms.conf
- attenzione ai tasti swappati nella tastiera Apple in /etc/modprobe.d/hid_apple.conf
- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- lxappareance (cambiare font in Jetbrains Mono 10)
- qt5ct (cambiare font in Jetbrains Mono 10)
- personalizzare il comportamento della touchbar con "sudo touchbar"

Gli sfondi "OS9" si scaricano da qui: https://arun.is/blog/os9-wallpaper/

Per info scrivetemi su Patreon. Buon Linux!
