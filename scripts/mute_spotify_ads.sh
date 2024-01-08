#!/bin/bash

# execute the below command:
# dbus-monitor "interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" | grep --line-buffered "https://open.spotify.com/" | xargs -I '{}' /bin/bash /home/werdun/my-ubuntu-stuff/my-scripts/mute_spotify_ads.sh {}
# above command can not be executed directly by running command in a prompt other than terminal for some reason
# so instead run the file dbus_monitor_for_spotify_ads.sh

# explanation of above command:
# i looked around for ways to trigger a script whenever spotify's media changed
# i also needed to know information about the media that is being played
# the dbus monitor command above provided both, just had to filter text using grep and pass it as argument while executing this script

# how this script works:
# first the pactl command is used along with grep to get the sink-input-index of the spotify media player
# then the current media from dbus-monitor command is matched with regex and:
# if the media is advertisement, spotify's internal volume setting is set to 0% using pactl
# if the media is not an advertisement, spotify's internal volume setting is set to 72% using pactl

current_media=$1
spotify_sink_input_index=25

spotify_sink_input_index_string=$(pactl list sink-inputs | grep "Sink Input\|media.name" | grep -B 1 Spotify | grep -o "[0-9]\+")

# spotify creates new clients on desktop whenever we switch from mobile
# https://community.spotify.com/t5/Desktop-Linux/Spotify-opens-too-many-connections-to-PulseAudio-Linux/m-p/1457757/highlight/true#M3906
# to recognize the active (latest) client:
spotify_sink_input_indices=($spotify_sink_input_index_string)
spotify_active_sink_input_index=${spotify_sink_input_indices[-1]}

if [[ $current_media =~ (ad) ]]; then
	pactl set-sink-input-volume $spotify_active_sink_input_index 0%
	icon_path="/usr/share/icons/HighContrast/scalable/status/audio-volume-muted.svg"
	notify-send --icon=$icon_path "$(basename $0)" "Spotify is playing an Ad"
	echo "advertisement: $current_media";
elif [[ $current_media =~ (track) ]]; then
	pactl set-sink-input-volume $spotify_active_sink_input_index 72%
	echo "not advertisement: $current_media";
fi