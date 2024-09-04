#!/bin/bash
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
script_dir=$(echo "$script_dir" | sed "s|$HOME|~|") # makes it ~ not /

if [[ $1 && $2 ]]; then
  if [[ ! -d $2 ]]; then
    echo "making dir $2"
    mkdir $2
  else
    echo "$2 exists already, not touching it"
  fi
  echo "creating template named: $1"
  cp "template.conf" "$2/$1"
elif [[ $1 ]]; then
  echo "creating template named: $1"
  cp "template.conf" "$1"
else
  echo "Help menu:"
  echo "  -h (shows this menu)"
  echo "  ./new.sh <name of config>.conf <folder>"
  echo "  ex: ./new.sh start_breakapps.conf break"
  echo ""
  echo "Notes:"
  echo "  * no spaces allowed in names unless wrapped in ''"
fi

if [[ -n "$1" ]]; then
  echo "write alias ${1%.sh} to bashrc? [y/n]"
  read write_to_bashrc
  if [[ "$write_to_bashrc" == "y" ]]; then
    if [[ -n $1 ]]; then
      alias_name=${1%%.*}
      command="alias $alias_name='$script_dir/open_apps.sh $script_dir/$2/$1'"
    else # if folder name not specified create alias under script_dir with file name
      echo "enter alias name"
      read alias_name
      command="alias $alias_name='$scriptn_dir/open_apps.sh $script_dir/$1'"
    fi
    echo "writing alias $alias_name into the $HOME/.bash_aliases"
    echo "$command" >>$HOME/.bash_aliases
  else
    echo "exiting..."
    exit 1
  fi
fi
