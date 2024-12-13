## Riccardo Palombo - email at riccardo dot im

Consiglio di applicare queste configurazioni ad un sistema operativo già adattato al laptop su cui deve girare. Io ho usato Endeavour OS installato in modalità "online" e senza scegliere un ambiente desktop nel menù. Finita l'installazione, dopo il primo boot, ho iniziato ad aggiungere i pacchetti con Pacman e AUR.

Controllate il video per avere un'idea dell'effetto finale: https://youtu.be/4-2fH_0IPlA
Altro video dedicato alla rice: https://youtu.be/6r0QQu7xnrQ

Installare i pacchetti e poi copiare i file in "home" e in "etc" seguendo la struttura originale delle cartelle.
Il tutto, come detto, è preparato per Arch Linux (anche Endeavour OS va bene) e Surface Laptop Go. Ha bisogno di essere adattato al vostro ambiente (percorsi dei file, nomi, qualche posizionamento e dimensione se usate un pannello diverso dal 1536x1024 di Surface Laptop Go). Quindi guardate dentro ogni singolo file di configurazione e controllate quei parametri assoluti per regolarli al vostro hardware. Ad esempio, usare il font Tamsyn da 12pt su un laptop con schermo 2K o 4K significa non vedere nulla! Non dovreste aver problemi su laptop con schermo fino al Full HD.


Pacchetti essenziali:

hyprland-git (AUR)
brightnessctl
exa
foot (attenzione perché io lo lancio come server)
micro
nemo
rofi-lbonn-wayland (AUR)
tamsyn-font
ttf-jetbrains-mono
otf-font-awesome
terminus-font
wob (AUR)
waybar-hyprland-git (AUR) - Ricordarsi di configurare il plugin crypto con la propria API di coinmarketcup. Info su https://github.com/chadsr/waybar-crypto
pamixer
apostrophe (AUR)
swaybg


Quindi (yay è pre-installato su EndeavourOS, altrimenti usate il vostro metodo):

sudo pacman -S brightnessctl exa foot micro nemo tamsyn-font ttf-jetbrains-mono otf-font-awesome terminus-font pamixer swaybg

yay -S hyprland-git rofi-lbonn-wayland wob waybar-hyprland-git apostrophe


I temi per le icone, per GTK e per il cursore è Adwaita, e dovrebbe essere già installato nella vostra distro.

Attenzione al kernel perché sui dispositivi Surface bisogna usare il "surface-linux" per avere il completo supporto hardware. Andate sul sito ufficiale e leggete le istruzioni per installarlo sulla vostra distro: https://github.com/linux-surface/linux-surface

Ultimo consiglio: per migliorare la durata della batteria e ridurre la rotazione della ventola usate cpu-autofreq: https://github.com/AdnanHodzic/auto-cpufreq Io l'ho installato come servizio con systemd e ho lasciato che disattivasse anche il Turbo Boost alla CPU. Nulla di complesso, è tutto scritto nella pagina ufficiale o nella pagina man.

Per info scrivetemi su Patreon. Buon Linux!

Credits:

- Schema colori: https://www.reddit.com/r/UsabilityPorn/comments/meqbw1/how_i_use_fvwm/
- r/UnixPorn: https://www.reddit.com/r/unixporn/
