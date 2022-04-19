# could not run this command as a startup application so made it a script
# now run the script as startup application
dbus-monitor "interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" | grep --line-buffered "https://open.spotify.com/" | xargs -I '{}' /bin/bash /home/werdun/my-ubuntu-stuff/my-scripts/mute_spotify_ads.sh {}