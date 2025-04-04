## Riccardo Palombo - email at riccardo dot im
##
## CONFIGURAZIONE POST-INSTALLAZIONE DI ALPINE LINUX
## A PARTE QUALCHE DETTAGLIO, SI PUÒ USARE ANCHE SU ARCH O ALTRE
##

# Aggiungere i repo e passare ad "edge"
setup-apkrepos (poi "e", passare ad edge e abilitare community e testing)
apk -U upgrade
apk add micro

reboot

# Installare sudo al posto di doas (comodo per gli script)
apk add sudo
visudo (togliere commento a riga NOPASSW)
addgroup $USER wheel

# Installare labwc e driver intel seguendo il wiki di alpine (https://wiki.alpinelinux.org/wiki/LabWC)
setup-devd udev
apk add mesa-dri-gallium mesa-va-gallium intel-media-driver (intel-media-driver per CPU recenti, altrimenti libva-intel-driver)
apk add labwc labwc-doc

# Modificare il .profile per dichiarare XDG_RUNTIME_DIR in modo permanente (pagina Wayland del wiki https://wiki.alpinelinux.org/wiki/Wayland).

micro ~/.profile

if [ -z "$XDG_RUNTIME_DIR" ]; then
	XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"

	mkdir -pm 0700 "$XDG_RUNTIME_DIR"
	export XDG_RUNTIME_DIR
fi

## Installare il resto
apk add adwaita-icon-theme alpine-base alsa-utils bash bash-completion bluez brightnessctl busybox-mdev-openrc chrony curl dbus dbus-x11 doas e2fsprogs eudev firefox font-awesome font-dejavu font-jetbrains-mono font-tamzen font-terminus foot gammastep git grim gsettings-desktop-schemas gucharmap helix imv intel-ucode iw labwc labwc-doc lazygit libnotify libva-intel-driver libva-utils linux-firmware-i915 linux-firmware-none linux-firmware-other linux-lts lm-sensors lsblk lxappearance mako mesa-dri-gallium mesa-va-gallium micro mount mpv neomutt networkmanager networkmanager-cli networkmanager-tui networkmanager-wifi openssh openssl pciutils pcmanfm pipewire pipewire-alsa pipewire-pulse polkit qt5ct seatd shadow simp1e-cursors slurp sudo swaybg swayidle sylpheed syslinux tlp tofi udev-init-scripts udev-init-scripts-openrc udiskie udisks2 waybar wf-recorder wireplumber wordgrinder wpa_supplicant zzz

# Permessi utente
usermod -G lp,wheel,audio,input,video,seat $USER

# Avviare servizi
rc-update add seatd
rc-update add dbus
#rc-update add bluetooth
rc-update add tlp

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
In pulseaudio config abilitare il profilo "pro"

# Extra - Configurazione EFI Boot Stub
Installare efibootmgr
Copiare lo script dal sito di Alpine/Bootloader
Modificare le partizioni
Avviare lo script
Copiare i file di loader e initrd da /boot a /boot/efi
cp /boot/initramfs-lts /boot/vmlinuz-lts /boot/EFI/

Per info scrivetemi su Patreon. Buon Linux!
