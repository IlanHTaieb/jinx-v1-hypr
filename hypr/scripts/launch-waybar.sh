#!/bin/bash

CONFIG=~/.config/waybar/config.jsonc
STYLE=~/.config/waybar/style.css

# start waybar if not started
if ! pgrep -x "waybar" > /dev/null; then
  waybar -c "$CONFIG" &
fi

current_checksum_config=$(md5sum "$CONFIG")
current_checksum_style=$(md5sum "$STYLE")

while true; do
  sleep 1

  new_checksum_config=$(md5sum "$CONFIG")
  new_checksum_style=$(md5sum "$STYLE")

  if [ "$current_checksum_config" != "$new_checksum_config" ] \
  || [ "$current_checksum_style" != "$new_checksum_style" ]; then

    killall waybar
    waybar -c "$CONFIG" &

    current_checksum_config=$new_checksum_config
    current_checksum_style=$new_checksum_style
  fi
done

