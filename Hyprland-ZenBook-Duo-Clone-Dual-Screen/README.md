## Riccardo Palombo - email at riccardo dot im

Questo README è specifico per N-one Nbook Fly e simili (quindi anche lo ZenBook Pro Duo originale).

Consiglio di applicare queste configurazioni ad un OS già adattato al laptop su cui deve girare. Se volete applicarle ad un laptop già in funzione, create un nuovo utente ed usate quello.

Io ho usato EndeavourOS installato in modalità "online" e senza scegliere un ambiente desktop nel menù. Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR (io lo faccio da un'altra macchina via "SSH", per dire, e copio l'archivio zip dei dots con il comando "SCP").

Guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware. Quindi installate i pacchetti e poi copiate i file estratti dallo zip nelle proprie "home" e in "etc" seguendo la struttura originale delle cartelle.

# PACCHETTI ESSENZIALI
sudo pacman -S brightnessctl qt5ct exa foot micro nemo hyprland ttf-jetbrains-mono waybar otf-font-awesome terminus-font pamixer swaybg swaylock swayidle lazygit polkit-kde-agent python-requests nemo-fileroller nemo-image-converter powertop acpid mako gammastep mpv htop blueman lxappearance profile-sync-daemon imv swappy grim wtype --noconfirm --needed

yay --noprovides --answerdiff None --answerclean None -S wob xdg-desktop-portal-hyprland-git batsignal zramswap keyd tofi

# PACCHETTI OPZIONALI
sudo pacman -S intel-media-driver libva-mesa-driver mesa-vdpau libva-utils (acc hw gpu, poi da abilitare nel file /etc/environment)

# SERVIZI DA ABILITARE
systemctl enable keyd # PER MAPPARE TASTO RIGHT SHIFT
systemctl start acpid.service #PER POTER GESTIRE IL PWR_OFF
systemctl enable --now bluetooth.service
systemctl enable zramswap.service #SOLO SE AVETE POCA RAM
systemctl enable paccache.timer
systemctl --user enable batsignal.service

# COSE DA FARE
- controllare che il tasto "Delete" sia Right Shift e che "Power" sia Backspace
- Disattivare cache su disco in firefox about:config (https://wiki.archlinux.org/title/Firefox/Profile_on_RAM)
- profile sync daemon (comando psd, controllare il config e poi abilitare il servizio per l'utente seguendo le istruzioni a schermo)
- cpu-autofreq (da installare e attivare seguendo le istruzioni su https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer)
- valutare o meno se installare e attivare anche tlp (il config per lavorare insieme ad auto-cpufreq è nei dots)
- lxappareance (cambiare font in Jetbrains Mono 10)
- qt5ct (cambiare font in Jetbrains Mono 10)

# PER NORDVPN
Installare il pacchetto nordvpn-bin da AUR e fare il login a NORDVPN: istruzioni su https://wiki.archlinux.org/title/NordVPN

# I PROFILI COLORE
Nel pacchetto zip abbinato trovate anche i profili colore icc (formato icm perché sono stati fatti da Windows - ma restano degli icc) dei monitor. Applicarli a questo setup Wayland è un macello, ma se avete un altro ambiente desktop (Gnome, KDE, altro), vi basta applicarli dalle rispettive interfacce utente. Oppure usateli su Windows, se lo avete.

Per info scrivetemi su Patreon. Buon Linux!
