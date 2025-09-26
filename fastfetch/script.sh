#!/bin/bash

# Fetch JSON from your worker
json=$(curl -s "https://lastfm.josshuaj7.workers.dev/")

# Extract fields
artist=$(echo "$json" | jq -r '.recenttracks.track[0].artist["#text"]')
track=$(echo "$json" | jq -r '.recenttracks.track[0].name')
art_url=$(echo "$json" | jq -r '.recenttracks.track[0].image[] | select(.size=="extralarge")["#text"]')

# Check if track exists
if [[ -z "$track" || "$track" == "null" ]]; then
  echo "Nothing playing"
  exit 0
fi

# Download album art (optional)
curl -s "$art_url" -o ~/.config/fastfetch/album_art.jpg

# Output info
echo "$artist - $track"

