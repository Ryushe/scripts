#!/bin/bash

echo "Starting chrome"
urls=("https://example.com" "anothir.xom")
main_apps=("vmware")
left_apps=("obs")
right_apps=("google-chrome-stable")
main_space=4
left_space=12
right_space=24
space=$main_space

#so i can send the apps
apps_main_str="${main_apps[*]}"
apps_left_str="${left_apps[*]}"
apps_right_str="${right_apps[*]}"
urls_str="${urls[*]}"

~/scripts/open_apps/main.sh "$apps_main_str" "$apps_left_str" "$apps_right_str" $main_space $left_space $right_space "$urls_str"
