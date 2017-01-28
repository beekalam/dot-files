#!/bin/sh
# taken from
# http://askubuntu.com/questions/66914/how-to-change-desktop-background-from-command-line-in-unity
# http://stackoverflow.com/questions/10374520/gsettings-with-cron

# Wallpaper's directory.
dir="${HOME}/Pictures/wallpapers"

# export DBUS_SESSION_BUS_ADDRESS environment variable
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

# Random wallpaper.
wallpaper=`find "${dir}" -type f | shuf -n1`

gsettings set org.gnome.desktop.background picture-options "zoom"
gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper}"
