#!/bin/bash

## Must be run as Sudo
# bash script run after installation


apt update
apt-get update

add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository universe -y
dpkg --add-architecture i386 
apt update
apt-get update

apt-get install chrome-gnome-shell chome-gnome-shell-pref
#setup flatpak
apt install -y flatpak
apt install gnome-software-plugin-flatpak
su - $SUDO_USER -c "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"

#installing important utilities
apt install os-prober


# source ~/.bashrc
exec bash

## removing snap

snap remove --purge firefox
snap remove --purge snap-store
snap remove --purge gnome-3-38-2004

snap remove --purge gtk-common-themes
snap remove --purge snapd-desktop-integration
snap remove --purge bare
snap remove --purge core20
snap remove --purge snapd

apt remove --autoremove snapd -y



# nosnap config
touch /etc/apt/preferences.d/nosnap.pref
echo -e "Package: snapd\nPin: release a=*\nPin-Priority: -10" > /etc/apt/preferences.d/nosnap.pref

apt update

apt install --install-suggests gnome-software -y

add-apt-repository ppa:mozillateam/ppa -y
apt update
apt install -t 'o=LP-PPA-mozillateam' firefox


## configuring firefox to allow update
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

## config to prevent firefox from intall snap associated pkg
touch /etc/apt/preferences.d/mozillateamppa

tee -a /etc/apt/preferences.d/mozillateamppa <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
EOF

## merging msm install script
# apt install -y curl git python3 python3-pip software-properties-common ttf-mscorefonts-installer ca-certificates \
# gnome-disk-utility mpv htop neofetch stacer openssh-server synaptic ubuntu-restricted-extras \
# dconf-editor gdebi pavucontrol winetricks blueman gnome-sushi ffmpeg ffmpegthumbnailer \
# cpupower-gui ghex handbrake net-tools openjdk-8-jdk gthumb gnome-firmware python3-yaml \
# python3-dateutil python3-pyqt5 python3-packaging python3-requests

apt install -y curl git python3 python3-pip software-properties-common ttf-mscorefonts-installer ca-certificates \
gnome-disk-utility mpv htop neofetch openssh-server synaptic ubuntu-restricted-extras \
dconf-editor pavucontrol blueman gnome-sushi ffmpeg ffmpegthumbnailer \
net-tools gthumb python3-yaml tigervnc-standalone-server \
python3-dateutil python3-pyqt5 python3-packaging python3-requests

# source ~/.bashrc
exec bash

## setting up useful flatpak packages 
flatpak install flathub com.belmoussaoui.Decoder com.github.muriloventuroso.pdftricks \
com.github.tchx84.Flatseal com.github.donadigo.appeditor \
com.mattjakeman.ExtensionManager \
org.gnome.Firmware \
org.gnome.clocks de.haeckerfelix.Fragments \
org.x.Warpinator \
org.gnome.SoundRecorder \
com.github.muriloventuroso.easyssh -y

## setting up useful flatpak packages
# flatpak install flathub com.github.muriloventuroso.pdftricks \
# com.github.tchx84.Flatseal com.github.donadigo.appeditor com.github.fabiocolacio.marker \
# com.github.xournalpp.xournalpp com.mattjakeman.ExtensionManager org.upnproutercontrol.UPnPRouterControl \
# com.usebottles.bottles org.gnome.design.IconLibrary org.gnome.Firmware \
# no.mifi.losslesscut org.gnome.Rhythmbox3 org.gnome.clocks de.haeckerfelix.Fragments \
# org.x.Warpinator re.sonny.Tangram vn.hoabinh.quan.CoBang io.bassi.Amberol \
# org.gnome.SoundRecorder com.github.hugolabe.Wike org.gnome.Connections net.davidotek.pupgui2  \
# io.github.prateekmedia.appimagepool com.github.muriloventuroso.easyssh -y

## setting up gnome extensions via apt (untested)
apt install gnome-tweaks gnome-shell-extension-gsconnect \
gnome-shell-extension-material-shell  gnome-shell-extensions

## enable extensions

## install grub customizer
add-apt-repository ppa:danielrichter2007/grub-customizer -y
apt install grub-customizer

## nautilus extension
apt install nautilus-image-converter

## folder color nautilus extension
add-apt-repository ppa:costales/folder-color -y
## yaru specific
add-apt-repository ppa:costales/yaru-colors-folder-color -y

apt update
apt-get update
apt install folder-color yaru-colors-folder-color
apt-get install folder-color

## install nautilus extension
apt install nautilus-admin


## install nerd font

cd $HOME/Downloads && echo "[-] Download fonts [-]" && \
su - $SUDO_USER -c "echo \"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip\" && \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip && \
unzip DroidSansMono.zip -d ~/.fonts && \
fc-cache -fv"

# pip3 

#Configure fish (place at last)
apt-add-repository ppa:fish-shell/release-3 -y
apt update
apt install fish -y

chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
set -g -x fish_greeting ''

## enable wayland
