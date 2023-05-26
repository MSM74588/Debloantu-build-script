#!/bin/bash


# Check if the user is running the script with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with root privileges. Please use sudo or run as root."
    exit 1
fi


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


snap remove --purge firefox
snap remove --purge snap-store
snap remove --purge gnome-3-38-2004

snap remove --purge gtk-common-themes
snap remove --purge snapd-desktop-integration
snap remove --purge bare
snap remove --purge core20
snap remove --purge snapd

apt remove --autoremove snapd -y

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
dconf-editor blueman gnome-sushi ffmpeg ffmpegthumbnailer \
net-tools gthumb 

apt install os-prober

flatpak install flathub com.github.tchx84.Flatseal com.github.donadigo.appeditor \
com.mattjakeman.ExtensionManager org.gnome.clocks de.haeckerfelix.Fragments org.x.Warpinator \
com.github.GradienceTeam.Gradience io.github.hakandundar34coding.system-monitoring-center -y

apt install nautilus-admin ranger

flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

cd /tmp
wget -o- https://github.com/lassekongo83/adw-gtk3/releases/download/v4.7/adw-gtk3v4-7.tar.xz
tar -xJf adw-gtk3v4-7.tar.xz -C /usr/share/themes

cd /tmp
git clone https://github.com/catppuccin/grub.git && cd grub
mkdir -p /usr/share/grub/themes
sudo cp -r src/* /usr/share/grub/themes/
# Define the GRUB theme path
theme_path="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"

# Check if the theme path exists
if [ -f "$theme_path" ]; then
    # Add the GRUB_THEME entry to /etc/default/grub
    echo "GRUB_THEME=\"$theme_path\"" | sudo tee -a /etc/default/grub >/dev/null
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    # Update GRUB configuration
    sudo update-grub
    echo "GRUB theme added successfully."
else
    echo "Error: The specified theme file does not exist."
fi

cd /tmp
git clone https://github.com/adi1090x/plymouth-themes.git
cd plymouth-themes/pack_4
sudo cp -r red_loader /usr/share/plymouth/themes/
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/red_loader/red_loader.plymouth 100
sudo update-alternatives --config default.plymouth
sudo update-initramfs -u

cd /tmp
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
chmod +x install.sh
./install.sh


bash -c "$(curl -fsSL https://pacstall.dev/q/install)"

apt install fish nala -y

# Create a temporary directory to download and extract the font

cd /tmp
tmp_dir=$(mktemp -d)
cd "$tmp_dir"
# Download the font archive
font_url="https://github.com/google/fonts/raw/main/ofl/rubik/Rubik.zip"
wget -q "$font_url" -O Rubik.zip
# Check if the download was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to download the Rubik font."
    exit 1
fi
# Extract the font archive
unzip Rubik.zip
# Move the font files to the system's font directory
font_dir="/usr/share/fonts/truetype/rubik"
mkdir -p "$font_dir"
mv *.ttf "$font_dir"
# Update the font cache
fc-cache -f
# Clean up temporary files
rm -rf "$tmp_dir"
echo "Rubik font has been installed successfully."

cd /tmp
sudo apt-get purge apport
apt-get install -y gstreamer1.0-gtk3 gstreamer1.0-pulseaudio gstreamer1.0-libav meld -y

cd /tmp

# remove screenshot image
sudo mv /usr/share/sounds/freedesktop/stereo/screen-capture.oga /usr/share/sounds/freedesktop/stereo/screen-capture.oga.bak
# Create an empty sound file
sudo touch /usr/share/sounds/freedesktop/stereo/screen-capture.oga
# Make the sound file read-only
sudo chmod 444 /usr/share/sounds/freedesktop/stereo/screen-capture.oga

cd /tmp
wget -o- https://github.com/msm-linux/wallpaper-client-app/releases/download/Libadwaita_update_v1.1.0/msm-wallpaper-browser_1.1.0_amd64.deb
apt-get install ./msm-wallpaper-browser_1.1.0_amd64.deb

cd /tmp
sudo apt install python3-pygit2 python3-nautilus meld
git clone https://gitlab.gnome.org/philippun1/turtlegit.git
cd turtlegit
python3 install.py install [--user]

cd /tmp
rm -rf /tmp

echo "SCRIPT COMPLETED. Now install schema override"

