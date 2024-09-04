#!/bin/bash
# apps_main_str="$1"
# apps_left_str="$2"
# apps_right_str="$3"
# main_space="$4"
# left_space="$5"
# right_space="$6"
# files_str="$7"

# Convert strings back to arrays
# IFS=' ' read -r -a main_apps <<<"$apps_main_str"
# IFS=' ' read -r -a left_apps <<<"$apps_left_str"
# IFS=' ' read -r -a right_apps <<<"$apps_right_str"
# IFS=' ' read -r -a url_files <<<"$files_str"

main_sleep_time=.5
default_browser="google-chrome-stable"
# zen-browser (borked due to new proj), google-chrome-stable
# You can now access the arrays and spaces as needed
local_dir="$(dirname "$(realpath "$0")")"

load_config() {
  config_file="$1"
  if [[ -f "$config_file" ]]; then
    source "$config_file"
  else
    echo "Config file not found: $config_file"
    exit 1
  fi
}

zens_special_opener() { # dumb thing no work
  zen-browser -P ${profile} --new-window "${urls[0]}" >/dev/null 2>&1 &
  for ((i = 1; i < ${#urls[@]}; i++)); do
    zen-browser -P ${profile} --new-tab "${urls[$i]}" >/dev/null 2>&1 &
  done
}

open_app() {
  local app=$1
  local side=$2
  shift 2
  local urls=("$@")
  local move_app=true

  if [[ "$app" == "google-chrome-stable" ]]; then
    echo "starting chrome with profile: ${profile}"
    $app --profile-directory="${profile}" --new-window "${urls[@]}" >/dev/null 2>&1 &
  elif [ "$app" == "zen-browser" ]; then
    echo "starting zen with profile: ${profile}"
    zens_special_opener
    # "$app" -P "$profile" --new-window "${urls[@]}"
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
  elif [[ $main_space -eq 0 || $left_space -eq 0 || $right_space -eq 0 ]] && [[ $move_app == true ]]; then
    hyprctl dispatch movetoworkspace $space
  fi
}

is_number() {
  local var="$1"
  if [[ "$var" =~ ^[0-9]+$ ]]; then
    return 0 # True if it is a number
  else
    return 1 # False if it is not a number
  fi
}

get_monitors() {
  monitor=($(hyprctl monitors -j | jq -r '.[].activeWorkspace.name'))
  # main_space=${monitor[0]}
  # left_space=${monitor[1]}
  # right_space=${monitor[2]}
  spaces=($main_space $left_space $right_space)
  for i in "${!spaces[@]}"; do
    if ! is_number "${spaces[$i]}"; then # if space isnt a number
      spaces[$i]=${monitor[$i]}
    fi
  done
  # MAKE USE SPACES ACCORDINGLY (right now just string current, i want current to set the space)

  # resets variables to ensure global variables are set
  main_space="${spaces[0]}"
  left_space="${spaces[1]}"
  right_space="${spaces[2]}"
}

get_url_files() {
  dir_path="${config_file%/*}"
  files_list=($(ls "$dir_path" | grep "url.*\.txt"))
  if [ -n $files_list ]; then
    echo "files: ${files_list[@]}"
    echo "directory: $dir_path"
    files=()
    for file in "${files_list[@]}"; do
      url_files+=("$dir_path/$file")
    done
  fi
}

#### Start of main
# need to make parse the data when i load config (right now doesnt)
config_file="$local_dir/config.conf"
if [[ -n $1 ]]; then
  config_file="$1"
fi
load_config "$config_file"
get_monitors
get_url_files

declare -A apps
declare -A urls
apps[main]="${main_apps[@]}"
apps[left]="${left_apps[@]}"
apps[right]="${right_apps[@]}"

echo "
 ██████╗ ██████╗ ███████╗███╗   ██╗     █████╗ ██████╗ ██████╗ ███████╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██╔══██╗██╔══██╗██╔════╝
██║   ██║██████╔╝█████╗  ██╔██╗ ██║    ███████║██████╔╝██████╔╝███████╗
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
╚██████╔╝██║     ███████╗██║ ╚████║    ██║  ██║██║     ██║     ███████║
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝ "
echo "-----------------------------------------------------------------------------"
sleep 1

echo "
########
# Apps #
######## "
echo "Main apps: ${main_apps[@]}"
echo "Left apps: ${left_apps[@]}"
echo "Right apps: ${right_apps[@]}"
sleep $main_sleep_time

echo "
##########
# Spaces #
########## "
echo "Main space: $main_space"
echo "Left space: $left_space"
echo "Right space: $right_space"
sleep $main_sleep_time

echo "
########
# Info #
######## "
# handles chrome
echo url_files = ${url_files[@]}
for i in "${!url_files[@]}"; do
  file="${url_files[$i]}"
  if [[ -f "$file" ]]; then
    # file_contents=$(<"$file")
    mapfile -t file_contents <"$file"
    read -r side profile browser <<<"${file_contents[0]}" # allows for profile on line 1 and browser choice
    # side=${file_contents[0]}
    if [[ -z $browser ]]; then # if empty makes below default
      browser=$default_browser
    fi
    if [[ -z $profile ]]; then
      profile="Default"
    fi
    if [[ "$browser" == "google-chrome-stable" ]]; then
      if [[ "$profile" != "Default" ]]; then
        number="${profile//[!0-9]/}"
        profile="Profile $number"
        echo $profile
      fi
    fi
    urls[$i]=$(printf "%s " "${file_contents[@]:1}")
    echo "Browser = $browser"
    echo urls = ${urls[$i]}
    sleep $main_sleep_time

    echo "
#########
# Sides #
######### "
    sleep $main_sleep_time
    open_app $browser "$side" ${urls[$i]}
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
