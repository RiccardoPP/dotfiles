## Riccardo Palombo - email at riccardo dot im

## PROCEDURA PER ALPINE DISKLESS-IBRIDO
## INSTALLATA SU DISCO LOCALE MA AVVIATA IN RAM AL BOOT
## CON /HOME SU PARTIZIONE ESTERNA PERSISTENTE

- Boot da Live USB
- Configurazione di base con "setup-keymap, setup-hostname, setup-interfaces + ifup wlan0 e setup-ntp"
- apk add cfdisk e2fsprogs lsblk
- cfdisk /dev/nome-disco-locale
- Creare partizione di tipo EFI
- modprobe vfat e mkfs.vfat /dev/nome-disco-locale-partizione
- setup-bootable -v /media/sda/ /dev/nome-disco-locale-partizione (Nota: /dev/sda o chi per lei)
- reboot

## Creazione partizione e modifica fstab
- Conf base con "setup-keymap, setup-hostname, setup-interfaces + ifup wla n0 e setup-ntp"
- apk add cfdisk e2fsprogs lsblk
- cfdisk /dev/nome-disco-locale
- Creare partizione di tipo EXT4 per "config" (10GB avanzano)
- mkfs.ext4 -O ^has_journal /dev/nome-partizione-appena-creata (variante: mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/nome-partizione-appena-creata)
- mkdir /media/nome-partizione-appena-creata
- nano /etc/fstab e aggiungerla con "noatime,rw,0 0"
- mount -a e poi controllare con mount se è stata montata bene
- mkdir -p /media/nome-partizione-creata/data/home
- nano /etc/fstab e aggiungerla con "/media/nome-partizione-creata/data/home /home none bind,rw 0 0"

## Installazione finale
- setup-alpine
- Dopo server SSH rispondere "no" al boot partition; i campi successivi dovrebbero essere già compilati correttamente (con nome-partizione-creata)
- Se si è aggiunto un utente tramite setup-alpine, rimuovere la sua "home" da lbu nel file /etc/apk/protected-path
- lbu commit (se ok, siamo a posto)
- reboot

Da qui si configura tutto e poi si fa lbu commit per salvare le modifiche fatte al di fuori della home.


## CONFIGURAZIONE POST-INSTALLAZIONE
## RICORDARSI "LBU COMMIT" PRIMA DEI RIAVVI

setup-apkrepos (poi "e", passare ad edge e abilitare community+testing)
apk -U upgrade
apk add micro
reboot

apk add sudo
visudo (togliere commento a riga NOPASSW)
addgroup $USER wheel

Installare labwc, driver intel e servizi necessari seguendo il wiki di Alpine
Modificare il .profile per settare XDG in modo permanente (pagina Wayland del wiki)
Poi continuare come sotto

Copiare file "word" via scp da un altro computer
apk fix
reboot

# Fix user permissions
addgroup $USER lp
addgroup $USER audio
addgroup $USER input
addgroup $USER video
addgroup $USER seat

# Services
rc-update add seatd
rc-update add bluetooth
rc-update add tlp

# Some Bluetooth stuff
setup-devd udev
modprobe btusb

# Bash Shell for user (instead of ash)
chsh $USER e poi scrivere /bin/bash

# Fonts and icons
mkdir ~/.icons ~/.fonts
unzip ohsnap.zip -d ~/.fonts/
tar xvfz Haiku.gz -C ~/.icons/

# Copy home dots (da dentro la cartella dei dots scaricati da Patreon)
cp -r home/. /home/$USER

# Fix scripts permission
chmod +x ~/.config/scripts/*

# Disable root login
passwd -l root

# Disable Firefox cache
about:config > cercare "cache" = false
download and set theme Elemental – Soft

# Move Firefox Profile to RAM and sync it
Seguire le istruzioni su https://wiki.archlinux.org/title/Firefox/Profile_on_RAM#Place_profile_in_RAM_using_tools

# Extra - Configurazione EFI Boot Stub
Installare efibootmgr
Copiare lo script dal sito di Alpine/Bootloader
Modificare le partizioni
Avviare lo script
Copiare i file di loader e initrd da /boot a /boot/efi
cp /boot/initramfs-lts /boot/vmlinuz-lts /boot/EFI/

Per info scrivetemi su Patreon (riccardopalombo). Buon Linux!
