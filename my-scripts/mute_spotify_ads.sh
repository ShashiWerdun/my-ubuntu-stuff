#!/bin/bash

# execute the below command:
# dbus-monitor "interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" | grep --line-buffered "https://open.spotify.com/" | xargs -I '{}' /bin/bash ~/my-ubuntu-stuff/my-scripts/mute_spotify_ads.sh {}

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

spotify_sink_input_index=$(pactl list sink-inputs | grep "Sink Input\|media.name" | grep -B 1 Spotify | grep -o "[0-9]\+")

if [[ $current_media =~ (ad) ]]; then
	pactl set-sink-input-volume $spotify_sink_input_index 0%
	echo "advertisement: $current_media";
elif [[ $current_media =~ (track) ]]; then
	pactl set-sink-input-volume $spotify_sink_input_index 72%
	echo "not advertisement: $current_media";
fi