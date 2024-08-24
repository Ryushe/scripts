#!/bin/bash

main_apps=("vmware")
left_apps=("obs")
right_apps=()
main_space=4
left_space=12
right_space=24
space=$main_space
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
files_list=($(ls "$script_dir" | grep "url.*\.txt"))
files=$(printf "%s " "${files_list[@]}")
# files=("urls_ai.txt" "urls_test.txt") #if want to specify manually

#so i can send the apps
apps_main_str="${main_apps[*]}"
apps_left_str="${left_apps[*]}"
apps_right_str="${right_apps[*]}"
urls_str="${urls[*]}"
files_str="${files[*]}"

# ~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$urls_str"
~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$files_str"
