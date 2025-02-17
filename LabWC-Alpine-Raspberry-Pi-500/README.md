## Riccardo Palombo - email at riccardo dot im
##
## CONFIGURAZIONE POST-INSTALLAZIONE DI ALPINE LINUX
## A PARTE QUALCHE DETTAGLIO, SI PUÒ USARE ANCHE SU ARCH O ALTRE
##

# Installazione su microSD
Fare riferimento a https://wiki.alpinelinux.org/wiki/Raspberry_Pi

# Aggiungere i repo e passare ad "edge"
setup-apkrepos (poi "e", passare ad edge e abilitare community e testing)
apk -U upgrade
apk add micro

reboot

# Installare sudo al posto di doas (comodo per gli script)
apk add sudo
visudo (togliere commento a riga NOPASSW)
addgroup $USER wheel

# Installare labwc e driver GPU seguendo il wiki di alpine (https://wiki.alpinelinux.org/wiki/LabWC)
setup-devd udev
apk add mesa-dri-gallium mesa-va-gallium
apk add labwc labwc-doc

# Modificare il .profile per dichiarare XDG_RUNTIME_DIR in modo permanente (pagina Wayland del wiki https://wiki.alpinelinux.org/wiki/Wayland).

micro ~/.profile

if [ -z "$XDG_RUNTIME_DIR" ]; then
	XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"

	mkdir -pm 0700 "$XDG_RUNTIME_DIR"
	export XDG_RUNTIME_DIR
fi

## Installare il resto
## Attenzione: il file world nel repository contiene tutti i miei pacchetti installati. Consiglio di controllarlo prima di procedere.

apk add adwaita-icon-theme alsa-utils bash-completion bluez curl firefox font-awesome font-dejavu font-jetbrains-mono font-tamzen font-terminus foot git grim gsettings-desktop-schemas gucharmap helix imv iw lazygit libnotify lm-sensors lsblk lxappearance mako mpv pciutils pcmanfm pipewire pipewire-alsa pipewire-pulse qt5ct shadow simp1e-cursors slurp swaybg swayidle tofi waybar wireplumber zzz

# Permessi utente
usermod -G lp,wheel,audio,input,video,seat $USER

# Avviare servizi
rc-update add seatd
rc-update add dbus
#rc-update add bluetooth
#rc-update add tlp

# Altro
setup-devd udev
modprobe btusb
chsh $USER # Bash for user (instead of ash)

# Passaggio a NetworkManager >> https://wiki.alpinelinux.org/wiki/NetworkManager
sudo apk add network-manager-applet networkmanager networkmanager-cli networkmanager-tui networkmanager-wifi

# Installare openvpn (se serve)
sudo apk add openvpn networkmanager-openvpn
sudo rc-update add openvpn default
modprobe tun
sudo modprobe tun
sudo echo "tun" >> /etc/modules-load.d/tun.conf

##
## DOTFILES E FINEZZE
##

# Copiare pacchetto zip scaricato da Patreon con scp da un'altra macchina
Esempio: scp dotfiles.zip user@ip:/home/user/
unzip dotfiles.zip

# Fonts, tema e icone
mkdir ~/.icons ~/.fonts ~/.themes
unzip ohsnap.zip -d ~/.fonts/
tar xvfz Haiku.gz -C ~/.icons/
tar xvf WhiteSur-Light.tar.xz -C ~/.themes/

# Copiare i dots
cp -r home/. /home/$USER

# Correggere i permessi degli scripts
chmod +x ~/.config/scripts/*

sudo reboot

##
## EXTRA
##

# Disabilitare utente root (se serve)
passwd -l root

# Disabilitare la cache di Firefox (se serve)
about:config > cercare "cache" = false

# Audio Fix (solo per Chromebook)
#In pulseaudio config abilitare il profilo "pro"

# Extra - Configurazione EFI Boot Stub
Installare efibootmgr
Copiare lo script dal sito di Alpine/Bootloader
Modificare le partizioni
Avviare lo script
Copiare i file di loader e initrd da /boot a /boot/efi
cp /boot/initramfs-lts /boot/vmlinuz-lts /boot/EFI/

Happy Linux!
