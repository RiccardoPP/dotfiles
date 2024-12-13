#
# Riccardo Palombo - https://riccardo.im
# Preparato per la community Patreon: patreon.com/riccardopalombo
#
# Script originale: Felix Kling
# Link: https://felix-kling.de/blog/2021/linux-toggle-dark-mode.html
#
#!/bin/sh

# Determine mode
if [ "$(readlink ~/.Xresources.colors)" = ".Xresources.colors.light" ]; then
  background=dark
else
  background=light
fi

# A specific mode (light/dark) can be forced from the command line
if [ -n "$1" ] && [ "$1" != "$background" ]; then
  exit 0
fi

# Update color files
# i3 and other applications that use X resources. The symlink is used to load
# the correct color scheme on startup (.Xresources includes .Xresources.colors
# via #include .Xresources.colors)
ln -sf ".Xresources.colors.$background" ~/.Xresources.colors

# Overwrite color configuration
xrdb -merge ~/.Xresources.colors

# Rofi
echo "$background" > ~/.config/rofi/theme

# For triggering dark themes in GTK apps.
  if [ $background = dark ]; then
    sed -i s/Akwa-light/Akwa-dark/ ~/.xsettingsd
  else
    sed -i s/Akwa-dark/Akwa-light/ ~/.xsettingsd
  fi

# Reload

# Update WM background
feh --bg-tile ~/Immagini/mappa-$(echo $background).png

# Update Gtk apps
killall -HUP xsettingsd

# Update i3
i3-msg reload

# Update terminal emulator
kitty +kitten themes --reload-in=all "Theme-$(echo $background)"
