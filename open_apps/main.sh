# make a global file that allows for input of apps
#!/bin/bash

# Read arguments
apps_main_str="$1"
apps_left_str="$2"
apps_right_str="$3"
main_space="$4"
left_space="$5"
right_space="$6"
urls_str="$7"

# Convert strings back to arrays
IFS=' ' read -r -a main_apps <<<"$apps_main_str"
IFS=' ' read -r -a left_apps <<<"$apps_left_str"
IFS=' ' read -r -a right_apps <<<"$apps_right_str"
IFS=' ' read -r -a urls <<<"$urls_str"

declare -A apps
apps[main]="${main_apps[@]}"
apps[left]="${left_apps[@]}"
apps[right]="${right_apps[@]}"

# You can now access the arrays and spaces as needed
echo "urls: ${urls[@]}"
echo "Main apps: ${main_apps[@]}"
echo "Left apps: ${left_apps[@]}"
echo "Right apps: ${right_apps[@]}"

echo "Main space: $main_space"
echo "Left space: $left_space"
echo "Right space: $right_space"

open_app() {
  local app=$1
  local side=$2
  if [ $app == "google-chrome-stable" ]; then
    echo "starting chrome wins RAHHH"
    $app --profile-directory="Profile 1" --new-window "${urls[@]}" &
  else
    if pgrep -x "$app" >/dev/null; then
      echo "$app is already running."
    else
      echo "$app is not running. Starting $app..."
      $app >/dev/null 2>&1 &
    fi
  fi
  sleep 1

  if [ "$side" == "right" ]; then
    space=$right_space
  elif [ "$side" == "left" ]; then
    space=$left_space
  else
    space=$main_space # main default hehe
  fi
  hyprctl dispatch movetoworkspace $space
}

for side in "${!apps[@]}"; do
  echo "side $side:"
  app="${apps[$side]}"
  open_app "$app" "$side"

done
