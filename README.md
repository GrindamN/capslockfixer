# Caps Lock Fixer
Caps Lock delay fix for Ubuntu Budgie

If you are coming form Windows or MacOS, you may notice that there is delay when using Caps Lock to switch between uppercase and lowercase letters. This problem ,or bug, comes from default behaviour of old typewriters. The fix that has been pushed to xorg has not yet been applied so we have to relay on the tricks to get expected result.

For this fix to work, place the files in your /home directory.

Some background: Back when typewriters were still a thing if you wanted to switch to the uppercase letter you would use shift. Caps Lock was used for typing out Titles when you needed every letter to be uppercase. With the development of personal computers, this was still the thing. However, some operating systems like Windows, had users using Caps Lock instead of Shift to switch to the uppercase letter. So when they tried switching from lowercase to uppercase letter, and vice versa, there was not any kind of delay. Using CapsLock instead of Shift is more a question of habit especially if you used Windows, OS X before switching to Linux.

To “fix” this, I’ve tried multiple solutions, but I think the one in this post is the most practical and does not require patching X11.

So how does the script work?

The script in itself is made from few scripts that will run on startup, ensuring that everything works without needing to manually run it each time.

Here are the essential parts of the script:

The first part is made by exporting xkb config file. To do it run

xkbcomp -xkb $DISPLAY xkbmap

Open the exported file and fine this line

key <CAPS> { [ Caps_Lock ] };

Replace the whole line with this part

key <CAPS> { repeat=no, type[group1]="ALPHABETIC", symbols[group1]=[ Caps_Lock, Caps_Lock], actions[group1]=[ LockMods(modifiers=Lock), Private(type=3,data[0]=1,data[1]=3,data[2]=3)] };

Save the file with some name like capslockfix.sh
To test out new configuration reload the config file:

 xkbcomp -w 0 xkbmap $DISPLAY 
Try to type anything using Caps Lock to switch from uppercase to lowercase letters. There should be no more delay resulting in: THis is an example.

Since we don’t want to run it each time when we start OS via terminal, we will create additional script and startup service.

First the script to execute the command above

Create new bash script with the following data:

#! /bin/sh 

xkbcomp -w 0 /home/username/xkbmap $DISPLAY 
Save it. You can rename your xkbmap config to any other file name if you want to keep it more simple. After you’ve done this add it as a service.

If using Budgie: Go to ,Startup Applications" then click Add and then point out to the bash script created above.

In case this does not work for some reason or you are not using Ubuntu Budgie, you can always create startup file manually. Go to the /home/username/.config/autostart

Create a new file with the following data:

[Desktop Entry]
Name=Caps Lock Fixer
Comment=Fixes problem with
Exec="/home/username/capslockfix.sh"
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true]
  
Now, the whole problem with the typing delay should be solved. Due note that it works with multiple languages too as long as you have added additional keyboards before running the script. If you add new keyboard you will need to export new xkbmap file.
