#!/bin/bash

# just add apps to the bottom like "app1" "app2"
main_apps=("anki")
left_apps=()
right_apps=("obsidian obsidian://open?vault=language&file=japaneese")
main_space=0
left_space=13
right_space=23
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
