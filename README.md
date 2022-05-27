# ubuntu-steam-workshops

Steam Workshop-Emulator for Ubuntu.
Emulate Windows filesystem for Steam workshops on Ubuntu.

## Background:
Steam workshops are sometimes lacking Linux support natively. The main reason for this is the difference in case-sensitivity between Windows and Linux.

This script emulates a FAT32-filesystem and replaces the workshop-directory with a Windows-Image supported by Steam.

## Usage:

Configure `WORKSHOP_DIR` once in `ubuntifySteam.sh` to point to your existing Steam workshop directory.

Example:
```
WORKSHOP_DIR=/opt/steam/steamapps/workshop
```

Then run
```
ubuntifySteam.sh
```

Press `[CTRL]+[C]` for exiting the script.

## Notes:
- The script must be run when Steam is NOT running.
- Create a backup of your workshop-directory once before running this script

## Update Workshops

In order to update workshops start Steam WITHOUT this script. Once workshop-files are updated, quit Steam and run this script again.

## Dev-Notes:

This script:
- is inspired by: https://forums.civfanatics.com/threads/linux-ubuntu-18-04-summer-patch-mods-cqui.639638/
- creates a backup of the current Steam-workshop in a temporary directory provided by Ubuntu
- removes the Workshop-files, creates a FAT32-Image in Steam's Workshop-directory, and copies origin Workshop-files into this image
- on exit, it reverts the FAT32-Image and replaces the Workshop-directory with its orig content

