#!/bin/bash
dir_input="$1"
local_dir="$(dirname "$(realpath "$0")")"
files=($(ls | grep .MP4))
echo $files

if [ ! $1 ]; then
  dir_input="./"
fi

for file in ${files[@]}; do
  ffmpeg -ss 00:00:00 -i "$dir_input$file" -vframes 1 "$local_dir/${file%.MP4}.jpg"
done
