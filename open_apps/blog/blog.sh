#!/bin/bash
source ~/scripts/get_mons.sh

# 1. open dolphin in /Videos and have user be able to move videos in (then hit enter to continue)
# 2. open dolphin --split /Pictures /mnt/third_wheel/code/websites/ryushe.github.io/Pictures/<boxname>
#   - make be able to move to 2nd mon
# 3. run videomerger /Videos/<boxname>
# 3. open vlc with /Videos/<boxname>/output...
# 3. call open apps like usual
#
# ADD
# 1. make boxname in /mnt/third_wheel/code/websites/ryushe.github.io/Pictures/<boxname>
# 2. maybe make a new file with current date with box name date-box.md in the category that i did

video_manager() {
  if [ ! -d $video_path ]; then
    mkdir $video_path
    echo "made folder at $video_path"
  fi

  echo ""
  echo "Move the videos that you want to combine into $box_name and then press enter"
  dolphin "$video_path/.." >/dev/null 2>&1 &
  read
  if [ ! -f "$video_path/$video_output" ]; then
    sleep 1
    echo "Merging videos at $video_path"
    vidmerger $video_path
    echo "merged"
  fi
}

box_name=$1
video_path="$HOME/Videos/$box_name/"
video_output=$(find "$video_path" -type f -name "*output*")

if [[ -n $box_name ]]; then
  video_manager
  sleep 1
  echo ""
  echo "opening split dolphin for ss's"
  dolphin --split ~/Pictures/ /mnt/third_wheel/code/websites/ryushe.github.io/assets/images/ >/dev/null 2>&1 &
  # make move to space
  # hyprctl dispatch movetoworkspace $space
  sleep 1
  vlc "$video_path/output.mkv" >/dev/null 2>&1 &

  echo "run blog.conf? [y/n]"
  read blog_run
  if [[ $blog_run == "y" ]]; then
    echo "running blog.conf"
    exec $HOME/scripts/open_apps/open_apps.sh $HOME/scripts/open_apps/blog/blog.conf
  else
    echo "not running blog.conf"
  fi

else
  echo "Help menu:"
  echo "  -h (shows this menu)"
  echo "  ./blog.sh <box name>"
  echo "  ex: ./blog.sh relevant"
  echo ""
  echo "How to use:"
  echo "  * make a folder with the name of the box you are doing"
  echo "  * move the videos you want to combine into that folder"
  echo "  * run ./blog.sh <box name || name of new folder>"
  echo ""
  echo "What this does:"
  echo "  * opens a dolphin split tab of /Pictures and the path to the box (for my blog)"
  echo "  * combines blog videos in /Videos/<name of box>"
  echo "  * opens vlc with the combined videos"
  echo "  * runs open apps like normal RAHH"
  echo ""
  echo "Notes:"
  echo "  * no spaces allowed in names unless wrapped in ''"
  echo "  * the name has to be the same name you have in your ~/Videos/ folder"
fi
