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
alias conf='micro ~/.config/hypr/hyprland.conf'
alias conf-term='micro ~/.config/foot/foot.ini'
alias chx='chmod +x'
#alias dots='cd ~/Documents/dotfiles && ls'
alias ddu='du -sh * | sort -hr | head -20'
alias waykill='killall waybar && scripts/waybar_top.sh && scripts/waybar_bottom.sh'
PS1='[\u@\h \W]\$ '
#PS1="\[\e[1;34m\]\w\[\e[m\] "
#PS1="\[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]>\[\e[m\]\[\e[1;33m\]>\[\e[m\]\[\e[1;36m\]>\[\e[m\] "
export MICRO_TRUECOLOR=1
