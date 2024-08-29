#!/bin/bash

monitor=($(hyprctl monitors -j | jq -r '.[].activeWorkspace.name'))
main_apps=("vmware")
left_apps=("obs")
right_apps=()
# ${monitor[i]} - find with get_index.sh
main_space=0
left_space=12
right_space=24
space=$main_space
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
urls_str="${urls[*]}"
files_str="${files[*]}"

# ~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$urls_str"
~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$files_str"
