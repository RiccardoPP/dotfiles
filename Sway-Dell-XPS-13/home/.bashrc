#
# ~/.bashrc
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
# Qualche alias utile (bisogna installare exa!)
# 
[[ $- != *i* ]] && return

alias ls='exa -lgh'
alias ll='exa -lgha'
alias lt='exa --tree'
alias conf='micro ~/.config/sway/config'
alias conf-term='micro ~/.config/foot/foot.ini'
alias dots='cd ~/dotfiles'
alias chx='chmod +x'
alias ddu='du -sh * | sort -hr | head -20'
alias colors='cat .config/foot/themes/dark'
#PS1='[\u@\h \W]\$ '
PS1="\[\e[1;34m\]\w\[\e[m\] "
#PS1="\[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;36m\]>\[\e[m\] "
