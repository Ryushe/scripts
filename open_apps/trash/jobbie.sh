#!/bin/bash

monitor=($(hyprctl monitors -j | jq -r '.[].activeWorkspace.name'))
# just add apps to the bottom like "app1" "app2"
main_apps=()
left_apps=()
right_apps=("obsidian obsidian://open?vault=jobs&file=To%20learn%20(based%20off%20jobs)")
# set space to 0 for current space
main_space=${monitor[0]}
left_space=12
right_space=22

if [[ "$1" =~ ^[0-9]+$ ]]; then
  main_space="$1"
fi
if [[ -n $2 ]]; then
  left_space="$2"
fi
if [[ -n $3 ]]; then
  right_space="$3"
fi
script_dir="$(dirname "$(realpath "$0")")"
echo "Script directory: $script_dir"
files_list=($(ls "$script_dir" | grep "url.*\.txt"))
echo "files: ${files_list[@]}"
files=()
for file in "${files_list[@]}"; do
  files+=("${script_dir}/${file}")
done

#so i can send the apps
apps_main_str="${main_apps[*]}"
apps_left_str="${left_apps[*]}"
apps_right_str="${right_apps[*]}"
files_str="${files[*]}"

~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$files_str"
