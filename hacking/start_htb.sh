#!/bin/bash

echo "Starting chrome"
apps=("vmware" "obs")
urls=("https://chatgpt.com/" "https://chat.hackerai.co/" "https://app.hackthebox.com/")
google-chrome-stable --profile-directory="Profile 1" --new-window "${urls[@]}" &
# Check if VMware Workstation is running
for app in "${apps[@]}"; do
  if pgrep -x "$app" >/dev/null; then
    echo "$app is already running."
  else
    echo "$app is not running. Starting $app..."
    if [[ $app -eq "obs" ]]; then
      nohup obs --start >/dev/null 2>&1 &
    else
      $app &
    fi
  fi
done
