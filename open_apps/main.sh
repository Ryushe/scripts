#!/bin/bash
apps_main_str="$1"
apps_left_str="$2"
apps_right_str="$3"
main_space="$4"
left_space="$5"
right_space="$6"
files_str="$7"

echo "
 ██████╗ ██████╗ ███████╗███╗   ██╗     █████╗ ██████╗ ██████╗ ███████╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██╔══██╗██╔══██╗██╔════╝
██║   ██║██████╔╝█████╗  ██╔██╗ ██║    ███████║██████╔╝██████╔╝███████╗
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
╚██████╔╝██║     ███████╗██║ ╚████║    ██║  ██║██║     ██║     ███████║
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝ "
echo "-----------------------------------------------------------------------------"
sleep 1
# Convert strings back to arrays
IFS=' ' read -r -a main_apps <<<"$apps_main_str"
IFS=' ' read -r -a left_apps <<<"$apps_left_str"
IFS=' ' read -r -a right_apps <<<"$apps_right_str"
IFS=' ' read -r -a url_files <<<"$files_str"

declare -A apps
declare -A urls

apps[main]="${main_apps[@]}"
apps[left]="${left_apps[@]}"
apps[right]="${right_apps[@]}"

main_sleep_time=.5
# You can now access the arrays and spaces as needed
echo "
########
# Apps #
######## "
sleep $main_sleep_time
echo "Main apps: ${main_apps[@]}"
echo "Left apps: ${left_apps[@]}"
echo "Right apps: ${right_apps[@]}"

echo "
##########
# Spaces #
########## "
sleep $main_sleep_time
echo "Main space: $main_space"
echo "Left space: $left_space"
echo "Right space: $right_space"

open_app() {
  local app=$1
  local side=$2
  shift 2
  local urls=("$@")
  local move_app=true

  if [[ -n "$profile" && "$app" == "google-chrome-stable" ]]; then # will check if profile, and if not then open chrome with default
    echo "starting chrome with profile: ${profile}"
    $app --profile-directory="${profile}" --new-window "${urls[@]}" >/dev/null 2>&1 &
  elif [ "$app" == "google-chrome-stable" ]; then
    echo "starting chrome wins RAHHH"
    $app --profile-directory="Default" --new-window "${urls[@]}" >/dev/null 2>&1 &
  elif [[ $app ]]; then
    if pgrep -x "$app" >/dev/null; then
      echo "$app is already running."
      move_app=false
    else
      echo "$app is not running. Starting $app..."
      $app >/dev/null 2>&1 &
    fi
  else
    echo "no app for category $side"
    move_app=false
  fi

  if [[ "$side" == "right" && -n "$app" ]]; then
    space=$right_space
  elif [[ "$side" == "left" && -n "$app" ]]; then
    space=$left_space
  elif [[ "$side" == "main" && -n "$app" ]]; then
    space=$main_space # main default hehe
  fi
  sleep 1.5
  # if any space != 0 then move it to that space, if not keep it where it opens
  if [[ $main_space -ne 0 || $left_space -ne 0 || $right_space -ne 0 ]] && [[ $move_app == true ]]; then
    echo "moved app $app to $side monitor"
    hyprctl dispatch movetoworkspace $space
  fi
}

echo "
########
# Info #
######## "
sleep $main_sleep_time
# handles chrome
echo url_files = ${url_files[@]}
for i in "${!url_files[@]}"; do
  file="${url_files[$i]}"
  if [[ -f "$file" ]]; then
    # file_contents=$(<"$file")
    mapfile -t file_contents <"$file"
    read -r side profile_num <<<"${file_contents[0]}" # allows for profile on line 1
    # side=${file_contents[0]}
    if [[ -n "$profile_num" ]]; then
      number="${profile_num//[!0-9]/}"
      profile="Profile $number"
    fi
    urls[$i]=$(printf "%s " "${file_contents[@]:1}")
    echo urls = ${urls[$i]}
    echo "
#########
# Sides #
######### "
    sleep $main_sleep_time
    open_app "google-chrome-stable" "$side" ${urls[$i]}
  else
    echo "no urls in file ${file}"
    echo "${urls[$i]}"
  fi
done

for side in "${!apps[@]}"; do
  echo "side $side:"
  app="${apps[$side]}"
  open_app "$app" "$side"

done
