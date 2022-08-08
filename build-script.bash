#!/bin/bash

echo "💿 MSM MODIFIED OS SCRIPT 💿"
echo "this script runs as ADMIN!"

## ! MUST BE RUN IN A CONTAINING FOLDER(or it will be messy)

CURRENT_WORK_DIR=$(pwd)
BUILD_PATH=$CURRENT_WORK_DIR/iso-output
############### CONFIGERATIONS #########################
BASE_ISO_PATH="/home/msm/Documents/test-iso/iso/Zorin-OS-16.1-Core-64-bit.iso"
BASE_ISO_NAME="Zorin-OS-16.1-Core-64-bit.iso"

# Base iso path


# mkdir base_image
mv $BASE_ISO_PATH .
# the base iso is now copied to base_img folder

mkdir mnt
sudo mount -o loop $BASE_ISO_NAME mnt
# mounts the iso

mkdir extract-cd
sudo rsync --exclude=/casper/filesystem.squashfs -a mnt/ extract-cd # ! untested, may fail as iso is present in /base_img...

sudo unsquashfs mnt/casper/filesystem.squashfs
sudo mv squashfs-root edit
# extracts the desktop system

## CHROOT PREP
sudo cp /etc/resolv.conf edit/etc/  
# for dns

sudo mount -o bind /run/ edit/run
## ! binds dns to host system
sudo cp /etc/hosts $CURRENT_WORK_DIR/edit/etc/
## ! copys hosts from host-system

sudo mount --bind /dev/ edit/dev

## ? CHROOT ENVIRONMENT ##
sudo chroot edit
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts

export HOME=/root
export LC_ALL=C
#! to avoid locale issues

dbus-uuidgen > /var/lib/dbus/machine-id
#! In 9.10, before installing or upgrading packages you need to run 
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

## apt purge package-name
## to uninstall pkgs

## ? RUN CUSTOM SCRIPT AND INSTALLATIONS
apt install git curl synaptic -y

## ? CLEANUP ## 
apt clean
rm -rf /tmp/* ~/.bash_history
rm /etc/resolv.conf
rm /var/lib/dbus/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl

## ! UNMOUNTING ##
umount /proc || umount -lf /proc
umount /sys
umount /dev/pts
umount /dev
exit

## ? PACKAGING ##

chmod +w extract-cd/casper/filesystem.manifest
sudo su
chroot edit dpkg-query -W --showformat='${Package} ${Version}\n' > extract-cd/casper/filesystem.manifest
## generates filesystem manifest
exit
sudo cp extract-cd/casper/filesystem.manifest extract-cd/casper/filesystem.manifest-desktop
sudo sed -i '/ubiquity/d' extract-cd/casper/filesystem.manifest-desktop
sudo sed -i '/casper/d' extract-cd/casper/filesystem.manifest-desktop
# ! check what does ubiquity/d does

sudo rm extract-cd/casper/filesystem.squashfs
# sudo mksquashfs edit extract-cd/casper/filesystem.squashfs
sudo mksquashfs edit extract-cd/casper/filesystem.squashfs -comp xz -ef edit/boot


sudo su
printf $(du -sx --block-size=1 edit | cut -f1) > extract-cd/casper/filesystem.size
exit
# Update the filesystem.size file, which is needed by the installer:

sudo nano extract-cd/README.diskdefines

cd extract-cd
sudo rm md5sum.txt
find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt
# Remove old md5sum.txt and calculate new md5 sums 

# Add initial options first
cat <<EOF >xorriso.conf
-as mkisofs \\
-r -J --joliet-long \\
-o $BASE_ISO_NAME \\
EOF
# Use xorriso do the magic of figuring out options used to create original iso, making sure
# to append backslash to each line as required.
xorriso -report_about warning -indev "$BASE_ISO_NAME" -report_system_area as_mkisofs |
    sed -e 's|$| \\|'>>xorriso.conf
# Tell xorriso the root directory for the iso being created
echo 'extract-cd' >>xorriso.conf

# Modify options in xorriso.conf as desired or use as-is
sudo xorriso -options_from_file xorriso.conf