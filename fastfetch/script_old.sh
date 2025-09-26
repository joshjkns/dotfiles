#!/bin/bash

# Check if Spotify is running (returns 0 if yes)
if ! pgrep -x "Spotify" > /dev/null; then
  echo "Nothing playing"
  exit 0
fi

track=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
artist=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)
art_url=$(osascript -e 'tell application "Spotify" to artwork url of current track' 2>/dev/null)

if [[ -z "$track" ]]; then
  echo "Nothing playing"
else
  # Download album art to temp (optional)
  curl -s "$art_url" -o ~/.config/fastfetch/album_art.jpg

  # Output info (Fastfetch will show this)
  echo "$artist - $track"
fi
