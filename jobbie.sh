#!/bin/bash
group_1_urls=(
  "https://www.linkedin.com/jobs/"
  "https://huntr.co/track/boards/63f53af19ad96e002eb406e2/board"
)
group_2_urls=(
  "https://chatgpt.com/"
  "https://aiapply.co/dashboard/job-hub?popup=true"
)
group_3_urls=(
  "https://drive.google.com/drive/u/0/folders/1kPUvvs3c1_-L1vE3p9okHGNFG6voOhSh" #resumes
  "https://drive.google.com/drive/folders/1d3AG3iTjeDi4hFVZR170lu7j8IJV9hm5"     #templates
)

declare -A chrome_groups
chrome_groups[group_1]="${group_1_urls[@]}"
chrome_groups[group_2]="${group_2_urls[@]}"
chrome_groups[group_3]="${group_3_urls[@]}"
ordered_groups=("group_1" "group_2" "group_3")
movewindows=("group_3")

for group in "${ordered_groups[@]}"; do
  echo "$group:"
  google-chrome-stable --profile-directory="Default" --new-window ${chrome_groups[$group]} &
  sleep 0.2
  if [[ "${movewindows[@]}" =~ "${group}" ]]; then
    hyprctl dispatch movetoworkspace 21
  fi
done
