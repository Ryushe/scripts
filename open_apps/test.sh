current_workspaces=($(hyprctl monitors -j | jq -r '.[].activeWorkspace.name'))
echo ${current_workspaces[@]}
