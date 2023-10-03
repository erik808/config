#!/bin/bash

# set keyboard delay and rate
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30

# set check-alive-timeout
gsettings set org.gnome.mutter check-alive-timeout 15000

# synclient... alleen X11?
# synclient ClickFinger2=2
# synclient TapButton2=2

# synclient ClickFinger3=3
# synclient TapButton3=3

# adjust font scaling factor based on display
primaryDisp=$(xrandr -q | grep primary)

if [[ $primaryDisp == *"eDP-1"* ]];
then
    #internal
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.1
else
    #external
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
fi

# poging om headerbar uit te zetten in terminal
# gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

# alt-tab behavior
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.shell.window-switcher current-workspace-only "true"


# conky
conky -c ~/.conkyrc
