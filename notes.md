# Important notes:

- Avoid applying permission changes recursively (messed up once already)

# Media control keys not working

Media control keys(next, previous and pause-play) won't control playback. My case they did not work because of chromium browser capturing the keys instead of the spotify application. solution [here](https://askubuntu.com/a/1384986/1558273)

# Time sync bw Windows and Linux

Windows time was wrong everytime I booted. Running the command
`$ timedatectl set-local-rtc 1`
should make it right, found [here](https://technastic.com/fix-time-between-windows-10-and-ubuntu-in-dual-boot/).

# Customising GRUB menu

Edit the file with super user permissions;
`sudo nano /etc/default/grub`
then run
`sudo update-grub` to apply the changes.

### Possible customisations:

- I removed the GRUB timeout:
`GRUB_TIMEOUT=-1`
- Can change default entry:
`GRUB_DEFAULT=x` \[x is zero indexed\]
- Can also [change the GRUB menu color](https://askubuntu.com/a/82223/1558273)
- I [changed my grub theme](https://ostechnix.com/change-grub-theme-in-linux/) to [this](https://www.pling.com/p/1230780/)

# Add commands to execute at start of every terminal instance

Execute commands, like setting variables, at the end of `~/.bashrc` file or can also write a new bash script **`source`** it at the end of `~/.bashrc`.
**Note:** Executing a bash script will open a new terminal for every script, so can not set environment variables by executing scripts, have to source it. Look at [this](https://superuser.com/a/176788/1655640).

### As an example,

I reduced the length of prompt directory in terminal:
`export PROMPT_DIRTRIM=2`
Wrote this in a script `~/mybash.sh` and sourced it at end of `~/.bashrc`:
`. ~/mybash.sh`

### This will be used for a lot of stuff as we keep using linux.

# Bluetooth device connection shortcut

Assigned keyboard shortcut to terminal command to connect to my Google Home Mini as it keeps disconnecting when not active for certain time period.
Commands used:
`hcitool` and `bluetoothctl`
Looked at [this article](https://simpleit.rocks/linux/shell/connect-to-bluetooth-from-cli/) and:

- Got the device MAC address using `hcitool`
- Trusted the device using `bluetoothctl`
- Command to connect: `bluetoothctl connect <MAC address>`
- Go to `keyboard shortcuts` in settings and add.

For handling multiple bluetooth devices, I wrote a separate bash script. Assign a keyboard shortcut to run this file. It will cycle through paired devices. The file path: `/home/werdun/myscripts/connect_bluetooth.sh`

# Hotspot connection shortcut

- connect Hotspot: `sh -c "nmcli radio wifi on; nmcli device wifi hotspot ssid <ssid> password <password>"`
- disconnect Hotspot: `sh -c "nmcli device disconnect <device>;nmcli radio wifi off"`
    - the `<device>` can be found after running `connect hotspot` command once
- check devices connected to your hotspot: `iw dev <device> station dump`

# Removing snap

**Risky**
Followed [this answer](https://askubuntu.com/a/1353729) for uninstalling snaps cuz I wanted to uninstall it.
Link: https://askubuntu.com/a/1353729

# Brightness adjust

Laptop brightness too high at minimum. Followed [this](https://askubuntu.com/a/909392/1558273) to reduce below minimum. Some other interesting discussions about this [here](https://askubuntu.com/questions/62249/how-do-you-change-brightness-color-and-sharpness-from-command-line).
`xrandr --output eDP-1 --brightness 0.6`
value 0.6 depends on situation.
next thing: try to get night light at low brightness

# Tmux

[install tmux](https://linuxize.com/post/getting-started-with-tmux/) with `sudo apt install tmux`
set keyboard shortcut for tmux: `alt+shift+t`
you cannot put the command directly as `tmux` because it is not an app. It can only be run inside another terminal. So the command to launch tmux is:
`gnome-terminal -e "tmux new"`
[reference for command](https://stackoverflow.com/a/53721298/17819859)

# Choosing bw dGPU and iGPU

`prime-select query` shows the current gpu being used
`sudo prime-select intel` will select Intel's iGPU
`sudo prime-select nvidia` will select NVIDIA's dGPU

- Using iGPU can give better battery life than dGPU.

# Suspend on critical battery

In dconf-editor(installed from apt, cuz flatpak doesnot have required keys), go to `/org/gnome/settings-daemon/plugins/power/`
and set `critical-battery-action` to `suspend`. Also toggle `use-time-for-policy` to `off`.

# Managing fan speed for better thermals

I'm using a Dell laptop and these links helped me, especially the second link:
- https://www.cyberciti.biz/faq/controlling-dell-fan-speeds-temperature-on-ubuntu-debian-linux/
- https://askubuntu.com/a/1319565/1558273

The second link is thoroughly researched.<br>
My fan curve:
- set config(0)   {{0 0}  -1  50  -1  55}
- set config(1)   {{1 1}  45  60  50  65}
- set config(2)   {{2 2}  55  70  60  80}
- set config(3)   {{2 2}  65 128  75 128}


# Script for muting spotify ads

- answers on ask ubuntu that helped me and/or are interesting:
    - https://askubuntu.com/a/368875/1558273
    - https://askubuntu.com/a/697973/1558273
    - https://askubuntu.com/a/588936/1558273
- tools used:
    - dbus-monitor
    - grep
    - pactl
- script can be found at ~/my-scripts/mute\_spotify\_ads.sh
- read the comments in the script to understand how to use it

# Analyze boot time
- `systemd-analyze` is a tool useful to check boot times.
- `systemd-analyze critical-chain` - (from the manpage) prints a tree of time critical chain of units. It can be used to check how much time services are taking to init.

I disabled the `NetworkManager-wait-online` service, as apparently it wastes time during system boot (source: https://itsfoss.com/check-boot-time-linux/) but did not see any decrease in boot time.

# Using old laptop as a server(?)
So I have this old laptop which was lying around useless. Decided I'll put it to some use. Routers aren't allowed in my hostel, so made it a hotspot. And then I came up on the idea of streaming audio so I can move my actual laptop freely without having to disconnect from my wired speakers.
### Audio server
- can probably try [trx](https://www.pogo.org.uk/~mark/trx/) for this, but not available without snap on ubuntu 20.04
- sources to achieve Ubuntu to Ubuntu audio streaming:
  - https://askubuntu.com/a/28041/1558273
  - https://askubuntu.com/a/61920/1558273
- sources for Windows to Ubuntu audio streaming:
  - use [scream](https://github.com/duncanthrax/scream), [source](https://www.reddit.com/r/archlinux/comments/i8y196/comment/g1bwfez/).
- some other interesting resources:
	- https://partofthething.com/thoughts/multi-room-audio-over-wi-fi-with-pulseaudio-and-raspberry-pis/
	- https://unix.stackexchange.com/a/1896

### Remote Desktop Connection
- setup SSH within a LAN: https://askubuntu.com/a/1108044/1558273
- useful resource for VNC with SSH and about VPNs on [askubuntu](https://askubuntu.com/a/1267978/1558273)
- To use Remote Desktop from Windows, the host has to be logged out, otherwise we get a black screen. But to use Remmina with VNC plugin, for remote desktop we need the user to be logged in already. To have remote access when the host is logged out, [check this out](https://askubuntu.com/a/649327/1558273)

# PulseAudio config
- this will make your PulseAudio installation detect your subwoofer: https://gist.github.com/Jiab77/c84cedd53f8471d7dce15671aad8a624
- other resources about PulseAudio:
  - https://www.reddit.com/r/Ubuntu/comments/wldjxs/make_sound_great_again/
  - https://linuxreviews.org/PulseAudio
- something old maybe worth exploring: [link](https://0pointer.de/lennart/projects/padevchooser/)