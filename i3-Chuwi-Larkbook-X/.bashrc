#
# ~/.bashrc
#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
alias conf='micro ~/.config/i3/config'
alias conf-kitty='micro ~/.config/kitty/kitty.conf'
alias conf-picom='micro ~/.config/picom.conf'
alias chx='chmod +x'
alias ddu='du -sh * | sort -hr | head -20'

#PS1='[\u@\h \W]\$ '
PS1="\[\e[1;34m\]\w\[\e[m\] "


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
