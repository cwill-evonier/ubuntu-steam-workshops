# ubuntu-steam-workshops

Steam Workshop-Emulator for Ubuntu.
Emulate Windows filesystem for Steam workshops on Ubuntu.

## Background:
Steam workshops are sometimes lacking Linux support natively. The main reason for this is the difference in case-sensitivity between Windows and Linux.

This script emulates a FAT32-filesystem and replaces the workshop-directory with a Windows-Image supported by Steam.

## Usage:

Configure `WORKSHOP_DIR` once in `ubuntifySteam.sh` to point to your existing Steam workshop directory.
```
WORKSHOP_DIR=/opt/steam/steamapps/workshop
```

Then run
```
ubuntifySteam.sh
```

## Notes:
 - The script must be run when Steam is NOT running.
 - Create a backup of your workshop-directory once before running this script

Inspired by this post:
https://forums.civfanatics.com/threads/linux-ubuntu-18-04-summer-patch-mods-cqui.639638/

