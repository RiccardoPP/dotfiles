## Riccardo Palombo - email at riccardo dot im

Pacchetti necessari:

- herbstluftwm (https://herbstluftwm.org/)
- redshift
- rofi
- firefox
- dmenu
- polybar
- micro (lo schema colori è cmc-16, pre-installato)
- Akwa-dark (tema GTK per il software non QT)
- Roboto Condensed
- FontAwesome

Attenzione a:

- configurare il file powermenu-alt (polybar/script) con i comandi della propria distro.
- controllare i file di Polybar (config e modules) perché contengono voci che devono essere adattate al vostro setup (es: i monitor, la scheda audio, ecc)

Istruzioni:

1) Installare i pacchetti necessari nella propria distro con KDE Plasma (anche Kubuntu, KDE Neon, Manjaro KDE o quel che è).
2) Copiare i file dots dell'archivio seguendo la struttura esistente.
3) Uscire dalla sessione attiva e scegliere la nuova voce Plasma + Herbstluftwm (o come l'avete chiamata) dal vostro login manager (probabilmente SDDM se avete KDE).
4) Da qui iniziare a configurare KDE con i temi, i caratteri e le procedure mostrate nel video (i file dovrebbero già aver fatto tutto per voi, ma è meglio controllare).

Le procedure sono semplici e lineari ma richiedono un po' di pratica con l'ambiente Linux. Non si può passare ad un setup tiling come questo senza un po' di rodaggio.
In caso di problemi potete sempre tornare alla sessione KDE standard (basta selezionarla al momento del login), ma consiglio di sforzarsi ad usare il nuovo ambiente così
da trovare errori e, uno alla volta, capire come risolverli. I più comuni sono: Polybar non si avvia (controllare config, impostazioni monitor o errori di battitura), i font sono diversi
dal previsto (li avete installati? la vostra distro come li chiama?), non si sa cosa premere (vedi sotto).

Per aprire il terminale: Win+INVIO.
Per lanciare Firefox: Win+Barra e poi scrivere Firefox e premere INVIO.
Per chiudere una finestra: Win+Ctrl+Q.
Per aprire il config di Herbstluftwm: aprire il terminale e poi "conf-hb". Con "conf-poly" si apre il config di Polybar. Questi "alias" sono definiti nel file .bashrc che avete installato.

Happy Linux!

Riccardo
