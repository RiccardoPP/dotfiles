#
# ~/.bashrc
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
alias conf-hb='micro ~/.config/herbstluftwm/autostart'
alias conf-poly='micro ~/.config/polybar/config.ini'
alias conf-picom='micro ~/.config/picom.conf'
alias nano='micro'
alias hc='herbstclient'
# PS1='[\u@\h \W]\$ '
PS1="\[\e[1;34m\]\w\[\e[m\]\ \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;36m\]>\[\e[m\] "

# Completion for herbstclient
source /usr/share/bash-completion/completions/herbstclient
complete -F _herbstclient_complete -o nospace hc
