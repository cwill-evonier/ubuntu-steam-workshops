#!/bin/bash

#################################################### 
# CONFIGURATION: START
#################################################### 

# Path to existing Steam workshop directory.
# Is configurable in Steam-app.
# Example: ~/.local/share/Steam/steamapps/workshop
WORKSHOP_DIR=/opt/steam/steamapps/workshop

####################################################
# CONFIGURATION: END
####################################################

# Current TTY user
USR=$(whoami)

# Detect loop device for mounting
AVL_LOOP_DEVICE=$(sudo losetup -f)

# Workshop's parent directory
STEAM_APPS_DIR=${WORKSHOP_DIR%/*}

# Image path
FAT32_IMG=${STEAM_APPS_DIR}/civ6workshop-fat32.img

# Path for temporarily backups
BACKUP_DIR=$(mktemp --directory)

ubuntifySteam () {
    printf "+++ Ubuntify Steam Workshop +++\n"

    printf "Backup Workshop contents to %s" "$BACKUP_DIR"
    cp -r $WORKSHOP_DIR/content "$BACKUP_DIR"
    printf "\n..done\n\n"

    printf "Create FAT32 image in %s" "$FAT32_IMG"
    rm -f $FAT32_IMG
    sudo mkfs.vfat -C -F 32 $FAT32_IMG 2097152
    printf "..done\n\n"

    printf "Emulate Workshop on loop device %s" "$AVL_LOOP_DEVICE"
    rm -rf $WORKSHOP_DIR/content/**
    sudo losetup "$AVL_LOOP_DEVICE" $FAT32_IMG
    sudo mount -o uid="$USR",gid=users,fmask=113,dmask=002,iocharset=iso8859-1 "$AVL_LOOP_DEVICE" "${WORKSHOP_DIR}/content/"
    cp -r "$BACKUP_DIR"/content/* $WORKSHOP_DIR/content
    printf "\n..done\n\n"

    printf "Emulation of Workshops set up and running.."

    printf "\n\nPress [CTRL]+[C] to quit"
}    


unubuntifySteam () {
    printf "\n\n+++ Unubuntify Steam Workshop +++\n"

    echo "Unmount FAT32-image"
    sudo umount $WORKSHOP_DIR/content
    
    echo "Restore original Workshop files"
    cp -r "$BACKUP_DIR"/content/* $WORKSHOP_DIR/content
    
    printf "\nDelete tmp-files %s" "$BACKUP_DIR"
    rm -rf "$BACKUP_DIR"
    
    printf "\nDelete image %s" $FAT32_IMG
    rm -f $FAT32_IMG
    
    printf "\nDone"
    
    # Check loop devices, should not contain any workshop mountpoint anymore
    # lsblk
}

# If either user or system terminates the script rollback the changes.
finish()
{
    unubuntifySteam
    exit
}
trap finish SIGINT
trap finish SIGTERM
trap finish SIGQUIT

ubuntifySteam

# Keep script running while listening on SIGINT
while :; do
    sleep 5
done