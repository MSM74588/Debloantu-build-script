# CHANGE LOG
## Base System: Ubuntu 22.04
---
## Added:
    - Repository: multiverse
    - Repository: restricted
    - Repository: universe
    - i386 arch dpkg Added
    - chrome-gnome-shell
    - chrome-gnome-shell-pref
    - flatpak
    - gnome-software-plugin-flatpak
    - os-prober
    - gnome-software
    - firefox(ppa)
    - apt pkgs:
        - curl
        - git
        - python3
        - python3-pip
        - software-properties-common
        - ttf-mscorefonts-installer
        - ca-certificates
        - gnome-disk-utility
        - mpv
        - htop
        - neofetch
        - stacer
        - openssh-server
        - synaptic
        - ubuntu-restricted-extras
        - dconf-editor
        - gdebi
        - pavucontrol
        - blueman
        - gnome-sushi
        - ffmpeg
        - ffmpegthumbnailer
        - cpupower-gui
        - ghex
        - handbrake
        - net-tools
        - openjdk-8-jdk
        - gthumb
        - gnome-firmware
        - python3-yaml
        - python3-dateutil
        - python3-pyqt5
        - python3-packaging
        - python3-requests
    - flatpak (flathub pkgs)
        - flathub com.belmoussaoui.Decoder 
        - com.github.muriloventuroso.pdftricks
        - com.github.tchx84.Flatseal
        - com.github.donadigo.appeditor
        - com.github.fabiocolacio.marker
        - com.github.xournalpp.xournalpp
        - com.mattjakeman.ExtensionManager
        - org.upnproutercontrol.UPnPRouterControl
        - com.usebottles.bottles
        - org.gnome.design.IconLibrary
        - org.gnome.Firmware
        - no.mifi.losslesscut
        - org.gnome.Rhythmbox3
        - org.gnome.clocks
        - de.haeckerfelix.Fragments
        - org.x.Warpinator
        - re.sonny.Tangram
        - vn.hoabinh.quan.CoBang
        - io.bassi.Amberol
        - org.gnome.SoundRecorder
        - com.github.hugolabe.Wike
        - org.gnome.Connections
        - net.davidotek.pupgui2
        - io.github.prateekmedia.appimagepool
        - com.github.muriloventuroso.easyssh
    - gnome-tweaks
    - gnome-shell-extension-gsconnect
    - gnome-shell-extension-material-shell
    - gnome-shell-extensions
    - grub-customizer(+ppa)
    - nautilus-image-converter
    - folder-color (+ppa)
    - yaru-colors-folder-color (+ppa)
    - nautilus-admin
    - timeshift (+ppa)
    - Font:
        - DroidSansMono (nerd-fonts)
    - fish-shell (+ppa)
## Removed:
    - firefox(snap)
    - snap-store(ubuntu-software)
    - gnome-3-38-2004
    - gtk-common-themes(snap)
    - snapd-desktop-integration
    - bare(snap)
    - core20(snap)
    - snapd
## Modified:
    - /etc/apt/preferences.d/nosnap.pref
    - /etc/apt/apt.conf.d/51unattended-upgrades-firefox
    - /etc/apt/preferences.d/mozillateamppa
    - ~/.config/fish
## Planned/Ideas to be implemented/removed:
    - Wine setup script
    - bottles
    - winetricks
    - deb-get
    - gnome media softwares(video+audio)[remove]
    - Rubik font
    - VS code (preferably codium)
    - Nala apt frontend

## To compile custom glib
    glib-compile-schemas /usr/share/glib-2.0/schemas

## run scripts directly
    curl -fsSL https://raw.githubusercontent.com/MSM74588/Debloantu-build-script/main/custom-cubic-script.sh | sh