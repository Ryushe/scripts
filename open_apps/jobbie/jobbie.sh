#!/bin/bash

main_apps=()
left_apps=()
right_apps=()
main_space=2
left_space=12
right_space=22
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
files_list=($(ls "$script_dir" | grep "url.*\.txt"))
files=$(printf "%s " "${files_list[@]}") #Could make get any urls.txt in location
echo ${files}

#so i can send the apps
apps_main_str="${main_apps[*]}"
apps_left_str="${left_apps[*]}"
apps_right_str="${right_apps[*]}"
files_str="${files[*]}"

~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$files_str"
