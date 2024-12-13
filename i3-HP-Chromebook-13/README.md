## Riccardo Palombo - email at riccardo dot im

Installare i pacchetti e poi copiare i file in home e etc (opzionale) seguendo la struttura originale delle cartelle.
Il tutto è preparato per Arch Linux ed ha bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, forse qualche libreria).

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare. Guardare il video su "Come costruire un laptop" su YouTube per capire come fare ogni passo.

Il font del terminale è mPlus Nerd Font Mono (da scaricare su AUR). L'altro è Roboto Condensed Mono.
Per scaricare e configurare Herbe e Wordgrinder, seguire le istruzioni di: https://riccardo.im/voidlinux/voidtools

Per far andare l'audio su questo modello: https://github.com/iofq/chell_audio
Per mappare la tastiera di ChromeOS: https://wiki.archlinux.org/index.php/Chrome_OS_devices#Fixing_audio

Le gesture sono configurare con Touchégg e la sua UI Touche.

ATTENZIONE: questa rice è pensata per il Chromebook e quindi ha i DPI regolati per uno schermo da 3200x1800 pixel. Togliere le voci in .Xdefault se si usa su laptop con risoluzione diversa.

Pacchetti base:

mplus-nerd-font
redshift
touchégg + touche
fonts-roboto-ttf (font GTK)
git
i3-gaps
lazygit
brightnessctl
rofi
lm_sensors
lxappearance (per regolare icone e tema GTK)
micro
picom
rxvt-unicode
scrot
tlp
unclutter (nascondere il puntatore mouse dopo tot)
wordgrinder (ricompilato senza status bar - vedi file voidtools)

Per info, scrivetemi su Patreon. Buon Linux!
