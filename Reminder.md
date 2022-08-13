Add install instruction for ocs url

## force flatpak to use GTK theme
flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=GTK_THEME=my-theme 

setup calamares

setup deb-get

REMOVE UBUNTU BLOATS

## ubuntu bloatware
sudo apt-get remove account-plugin-facebook account-plugin-flickr account-plugin-jabber account-plugin-salut 
account-plugin-twitter account-plugin-windows-live account-plugin-yahoo aisleriot brltty duplicity empathy empathy-common 
example-content gnome-accessibility-themes gnome-contacts gnome-mahjongg gnome-mines gnome-orca gnome-screensaver gnome-sudoku 
gnome-video-effects gnomine landscape-common libreoffice-avmedia-backend-gstreamer libreoffice-base-core libreoffice-calc 
libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress libreoffice-math 
libreoffice-ogltrans libreoffice-pdfimport libreoffice-style-galaxy libreoffice-style-human libreoffice-writer libsane libsane-common 
mcp-account-manager-uoa python3-uno rhythmbox rhythmbox-plugins rhythmbox-plugin-zeitgeist sane-utils shotwell shotwell-common telepathy-gabble 
telepathy-haze telepathy-idle telepathy-indicator telepathy-logger telepathy-mission-control-5 telepathy-salut totem totem-common totem-plugins 
printer-driver-brlaser printer-driver-foo2zjs 
printer-driver-foo2zjs-common printer-driver-m2300w printer-driver-ptouch printer-driver-splix

# automated installation of Firefox extensions
# gnome extensions
## custom shortcuts

nautilus terminal

https://github.com/app-outlet/app-outlet  
custom fonts
## setup conky themes

https://github.com/elementary/appcenter

https://stackoverflow.com/questions/2518127/how-to-reload-bashrc-settings-without-logging-out-and-back-in-again

enable wayland

https://askubuntu.com/questions/741753/how-to-use-cubic-to-create-a-custom-ubuntu-live-cd-image


https://wiki.archlinux.org/title/desktop_entries

https://codereview.stackexchange.com/questions/243133/installing-gnome-extension-via-cli


## User-theme extension
https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v49.shell-extension.zip
- V-49, Shell-V 42
## Gsettings

```bash
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface locate-pointer true
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
gsettings set org.gnome.desktop.interface font-name 'Rubik 11'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-dark'
```
