#!/usr/bin/env bash
xkbcomp -xkb "$DISPLAY" xkbmap
FILE="/home/$USER/xkbmap"
NEWSCRIPT="/home/$USER/capslock.sh"
DESKTOP_AUTO_FILE="$HOME/.config/autostart/capslockf.desktop"
RUNLOG="/path/to/script.log"
sed -i 's/key <CAPS> {         \[       Caps_Lock ] };/key <CAPS> {\n        repeat=no,\n        type[group1]="ALPHABETIC",\n        symbols[group1]=[ Caps_Lock, Caps_Lock],\n        actions[group1]=[ LockMods(modifiers=Lock), Private(type=3,data[0]=1,data[1]=3,data[2]=3)]\n    };/' "$FILE"
cat <<EOF >"$NEWSCRIPT"
  #!/usr/bin/env bash
  xkbcomp -w 0 /home/$USER/xkbmap $DISPLAY
  cp $HOME
EOF
cat <<EOF2 >"$DESKTOP_AUTO_FILE"
[Desktop Entry]
Type=Application
Exec=$NEWSCRIPT
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=CapsLockf
Name=CapsLockf
Comment[en_US]=
Comment=
EOF2
date >> $RUNLOG