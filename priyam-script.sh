#!/bin/bash

# sudo -s
# run curl <link> | bash

apt update
apt-get update


add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository universe -y

apt update
apt-get update

apt install -y flatpak
apt install gnome-software-plugin-flatpak

su - $SUDO_USER -c "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"

snap remove --purge firefox
snap remove --purge snap-store
snap remove --purge gnome-3-38-2004
snap remove --purge gtk-common-themes
snap remove --purge snapd-desktop-integration
snap remove --purge bare
snap remove --purge core20
snap remove --purge snapd


apt remove --autoremove snapd -y

apt update

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

apt install -y curl git python3 python3-pip software-properties-common ttf-mscorefonts-installer ca-certificates \
gnome-disk-utility mpv htop neofetch openssh-server synaptic ubuntu-restricted-extras \
dconf-editor pavucontrol blueman gnome-sushi ffmpeg ffmpegthumbnailer \
net-tools gthumb fish gnome-tweaks

source /etc/bash.bashrc

flatpak install flathub com.github.tchx84.Flatseal com.github.donadigo.appeditor com.belmoussaoui.Decoder \
com.mattjakeman.ExtensionManager org.gnome.clocks de.haeckerfelix.Fragments org.x.Warpinator org.gnome.clocks \
it.mijorus.gearlever com.raggesilver.BlackBox org.gustavoperedo.FontDownloader \
com.github.GradienceTeam.Gradience io.github.hakandundar34coding.system-monitoring-center org.gnome.SoundRecorder -y

apt install nautilus-admin ranger

# install TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update
sudo apt install tlp tlp-rdw
# tlp-rdw: tlp Radio wizard

# install VS-CODE
apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# install adw3-gtk-theme
cd /tmp
wget -o- https://github.com/lassekongo83/adw-gtk3/releases/download/v4.7/adw-gtk3v4-7.tar.xz
tar -xJf adw-gtk3v4-7.tar.xz -C /usr/share/themes

flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

# install colloid theme
cd /tmp
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
chmod +x install.sh
./install.sh

# install Whitesur theme
cd /tmp
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
chmod +x install.sh tweaks.sh
# ./install.sh 
# ./tweaks.sh -F
# ./tweaks.sh -g

cd /tmp
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
chmod +x install.sh
./install.sh
./install.sh -b

sudo apt-get purge apport
apt-get install -y gstreamer1.0-gtk3 gstreamer1.0-pulseaudio gstreamer1.0-libav meld -y

# remove screenshot image
sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture.oga.bak
# Create an empty sound file
sudo touch /usr/share/sounds/freedesktop/stereo/screen-capture.oga
# Make the sound file read-only
sudo chmod 444 /usr/share/sounds/freedesktop/stereo/screen-capture.oga

cd /tmp
wget -o- https://github.com/msm-linux/wallpaper-client-app/releases/download/Libadwaita_update_v1.1.0/msm-wallpaper-browser_1.1.0_amd64.deb
apt-get install ./msm-wallpaper-browser_1.1.0_amd64.deb

# install debget
cd /tmp
apt install curl lsb-release wget
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | bash -s install deb-get

# install VirtualBox 7.0
cd /tmp
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" >> /etc/apt/sources.list
# gpg --dearmor oracle_vbox_2016.asc --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
sudo apt-get update
apt-get install virtualbox-7.0
# sudo usermod -aG vboxusers $(whoami)


# install pacstall
cd /tmp
bash -c "$(curl -fsSL https://pacstall.dev/q/install)"

apt install nala 

# END
cd /tmp
rm -rf /tmp

