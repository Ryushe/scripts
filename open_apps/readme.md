# Open apps
![charizard](./charizard.jpg)
## info
This program was intended for hyprland using hyprsome (monitor manager)  
everything will call main.sh (keep in root dir of open_apps)  
PROGRAM ASSUMES YOU USE .bash_aliases in home dir  

What it does:  
This program allows for the creation of a template script to move apps/chrome tabs around hyprsome's workspaces  

Some of the ways I use this program:  
- to open all my htb chrome tabs/apps (eg: ai(right mon), vmware(main), obs(left))
- job searching (eg: linkedin(main), ai(main), resume_buliders(right))

## start:
- run 
  - `./new.sh filename`
or   
- `./new.sh filename foldername` - makes folder to put sh into 
  - helpful when want to use the url file feature

## making new chrome instances:  
- every file that has `urls` and ends with `.txt` will be used 
  - creates a chrome instance with urls in it
ex file: `important_urls.txt`  
ex file contents:  
```
left/right/main 
https://fitgirl-repacks.site/
https://google.com
```
note: left/right/main determines which monitor to put it on so pick one  

## Helpful tips
- monitors are gotten by hyprsome's monitor layout 
  - meaning, when editing the newly copied template.sh from new.sh pick the 
  workspaces based on your current monitor setup 
  - check your config by running `hyprctl monitors` and look at the workspaces
  of your monitors
  - ex: my main workspaces(0-10) left(11-20) right(21-30)
- IF NOT USING HYPRSOME: 
  - if not using hyprsome monitor management your workspaces repeat every # of monitors
    - ex: 2 monitors -> ws1=mon1 ws2=mon2 ws3=mon1 ws4=mon2.....
      - ws = workspace

## Todo
- get current monitor layout, and open the apps on the workspaces
  - currently opens on workspaces predefined, but cant find it when nothing given

author: Ryushe

  

 



