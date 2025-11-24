#!/bin/bash

echo "[INFO] Updating the system: using pacman"
sudo pacman -Syu

echo "[INFO] Updating AUR: using yay"
yay -Syu

# ░█▀▄░█▀▀░█▀█░█▀▀░█▀█░█▀▄░█▀▀░█▀█░█▀▀░▀█▀░█▀▀░█▀▀
#░█░█░█▀▀░█▀▀░█▀▀░█░█░█░█░█▀▀░█░█░█░░░░█░░█▀▀░▀▀█
#░▀▀░░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀

echo "[SUCCESS] Done updating, installing dependancies"

sudo pacman -S git

# Terminal emulator
yay -S kitty

# Managment
yay -S nemo wlogout hyprshot vesktop

# Sway
yay -S swayfx swaylock swaync

# Launcher stuff
yay -S fuzzel clipman bemoji

# Wallpaper
yay -S swww waypaper

# Web browsing
yay -S chromium librewolf-bin

# Coding
yay -S vscodium

# Font
yay -S ttf-jetbrains-mono-nerd

echo "[SUCCESS] Done installing dependencies!"

#░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░▀█▀░█▀█░█▀▀
# ░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░█░░█░█░█░█
#░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀