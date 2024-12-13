#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias gnome-screenshot='gnome-screenshot -i'
alias conf-i3='micro ~/.config/i3/config'
alias conf-polybar='micro ~/.config/polybar/config'
alias conf-compton='micro ~/.config/compton.conf'
PS1='[\u@\h \W]\$ '
