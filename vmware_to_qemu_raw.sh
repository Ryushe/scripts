#!/bin/bash
input="$1"
output="$2"
file=$(basename $1)
local_dir="$(dirname "$(realpath "$0")")"
echo $files

if [ -z "$1" ]; then
  echo "Help menu:"
  echo "  ./script.sh <box name>"
  echo "  ex: ./script.sh relevant"
  echo ""
  echo "How to use:"
  echo "./script input_path output_path(optional)"
  echo ""
  echo "What this does:"
  echo "  * converts vmware vmdk files to raw"
  echo ""
  echo "Notes:"
  echo "  * no spaces allowed in names unless wrapped in ''"
  exit 1
fi

if [ -z $2 ]; then
  output="./"
fi

qemu-img convert -f vmdk -O raw $input $output
