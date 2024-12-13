#
# ~/.bashrc
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias conf='micro ~/.config/i3/config'
alias conf-picom='micro ~/.config/picom.conf'
alias nano='micro'
alias chx='chmod +x'
#PS1="\[\e[1;34m\]\w\[\e[m\]\ \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;36m\]>\[\e[m\] "
PS1="\[\e[1;34m\]\w\[\e[m\] "
