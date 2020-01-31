#!/bin/bash

# set keyboard delay and rate
xset r rate 200 30 &

# werkt niet voor xps...
synclient ClickFinger2=2
synclient TapButton2=2

synclient ClickFinger3=3
synclient TapButton3=3

# Adjust font scaling factor based on display
primaryDisp=$(xrandr -q | grep primary)

if [[ $primaryDisp == *"eDP-1"* ]];
then
    #internal
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
else
    #external
    gsettings set org.gnome.desktop.interface text-scaling-factor 0.8
fi
