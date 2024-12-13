#
# ~/.bashrc
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
# Qualche alias utile (bisogna installare exa!)
#

 alias ls='ls --color=auto'
 alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
 alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
 alias reboot='sudo reboot'
 alias conf='micro ~/.config/labwc/rc.xml'
 alias conf-bar='micro ~/.config/waybar/config'
 alias conf-term='micro ~/.config/foot/foot.ini'
 alias waykill='killall waybar && waybar &'

#alias dots='cd ~/code/dotfiles && lazygit'
#alias labwc='dbus-launch --exit-with-session labwc'

#alias wg="setfont /usr/share/consolefonts/ter-v28b.psf.gz; wordgrinder note/new.wg; setfont /usr/share/consolefonts/ter-112n.psf.gz; clear"
#alias wr="setfont /usr/share/consolefonts/ter-v24b.psf.gz; micro -statusline false -ruler false note/todo.md; setfont /usr/share/consolefonts/ter-112n.psf.gz; clear"

#PS1='[\u@\h \W]\$ '
PS1='[\u@\W]\$ '
#PS1='\[\e[1;37m\][\u@\W]\$\[\e[0m\] '
#PS1='\[\e[0;31m\]┌──\[\e[0;32m\][\u]\[\e[0;31m\]─\e[0;33m\[[$(battery_status)]\e[0;31m\]─\[\e[0;36m\][\A]\[\e[0;31m\]─\[\e[0;34m\][\w]\[\e[m\]\n\[\e[0;31m\]└────╼ \[\e[0;31m\]\[$(tput sgr0)\]'
