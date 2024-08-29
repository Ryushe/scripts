#!/bin/bash
# gets an array of mons
IFS=$'\n' read -r -d '' -a mons < <(hyprctl monitors | grep Monitor | awk '{print $2}' && printf '\0')
IFS=$'\n' read -r -d '' -a positions < <(hyprctl monitors | grep " at " | awk '{print $3}' && printf '\0')
# echo "${mons[@]}"
# echo "${positions[@]}"

main_mon=""
right_mon=""
left_mon=""
current_workspaces=($(hyprctl monitors -j | jq -r '.[].activeWorkspace.name'))

#below vars not used rn
main_mon_res=$(hyprctl monitors | grep -Eo '[0-9]{3,}x[0-9]{3,}@[^ ]+ at 0x0' | awk '{print $1}' | sed 's/@.*//')
IFS='x' read -r main_x main_y <<<"$main_mon_res"

echo "Place the monitor[i] in the script you made with new.sh"
echo "eg: main_space=monitor[0]"
echo
if [ "${#mons[@]}" -eq "${#positions[@]}" ]; then
  for i in "${!mons[@]}"; do
    mon="${mons[$i]}"
    position="${positions[$i]}"
    IFS='x' read -r x y <<<"$position"
    if [ "$x" -lt 0 ]; then # could add support for mons in a vert access
      left_mon=$mon
      direction="left"
    elif [[ "$x" -gt 0 ]]; then
      right_mon=$mon
      direction="right"
    else
      main_mon=$mon
      direction="main"
    fi
    echo "$mon($direction) - \${monitor[$i]}"

  done
else
  echo "The arrays 'mons' and 'positions' have different lengths."
fi
