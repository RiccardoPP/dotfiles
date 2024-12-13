# Variante per Raspberry Pi OS e Raspberry Pi 400

Pacchetti necessari da installare con "apt install nomepacchetto".

- herbstluftwm
- rxvt-unicode
- redshift
- rofi
- dmenu
- polybar (va compilato seguendo queste istruzioni, solo la prima parte "Installation Guide": https://gitlab.com/mm3psych0sis/raspberry-pi-polybar)
- micro (lo schema colori è cmc-16, già installato. da attivare con "set colorscheme cmc-16" dalla console di micro)
- Akwa-dark (tema GTK. Scaricare e installare seguendo le istruzioni su https://github.com/berkiyo/akwa)
- FontAwesome (icone di Polybar: pacchetto fonts-font-awesome)
- Terminus (font per terminale: pacchetto xfonts-terminus)

Se non si trova un pacchetto usare "apt search nomepacchetto" e capire se ha un nome diverso.

## Istruzioni

1. Installare tutto e copiare i file nei posti corretti (seguendo la loro struttura originale);
2. attivare il tema GTK Akwa Dark da "Impostazioni dell'aspetto", mettere font Piboto Condensed, e icone PixFlat;
3. Da "Configurazione di Raspberry Pi" selezionare "Dalla Cli" nella voce "Avvio" e riavviare. Al boot successivo si potrà scrivere "startx" per avviare l'ambiente grafico con herbstluftwm.

Happy Linux!

Riccardo
