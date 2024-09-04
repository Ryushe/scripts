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
1. run 
  - `./new_opener.sh filename`
or   
2. `./new_opener.sh filename foldername` - makes folder to put sh into 
  - helpful when want to use the url file feature
3. open new script and edit the workspaces/apps to open
4. If wanting chrome tabs, make file with the name `url` anywhere in the name and end with .txt to have opened (optional)
  - each new file is a new chrome instance: `ex name: aiurls.txt`
  - see more on this below
5. run with alias created 
  - eg: `japaneese`
  - eg: `htb current 11 24` (main, left, right) -> monitors
6. When editing the txt file made by new.sh, entering anything that isnt a number for the workspace will set it to the current monitor
  - eg: `main_space=current`

## making new chrome instances:  
- every file that has `urls` and ends with `.txt` will be used 
  - creates a chrome instance with urls in it
ex file: `important_urls.txt`  
ex file contents:  
```
Side options: left/right/main
Optional: profile (after the side, see below for example)
urls: make sure new line for each url
```
```
left
https://fitgirl-repacks.site/
https://google.com

or 

main profile1
https://fitgirl-repacks.site/
https://google.com
```

### Chrome instance notes: 
* left/right/main determines which monitor to put it on so pick one  
* profile is optional (no spaces allowed within the profile)
  - profile will use default profile if not specified

## Obsidian
* if want to open an obsidian use `obsidian (note-url)`
  - this will open the note/vault you want to open 

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
- `get_index.sh` - finds the monitor index for opening on current workspace
  - to then use this navigate to where you created your opening script (if haven't run ./new.sh)
  - go to the newly created file and enter the newly found index (thats it)

## Todo
- instead of script input, always call main.sh but have $1=thing to open 
  - then positional main left right
  - allows for easier customization & faster modification
  - alias would look like main.sh japaneese (for jap config)

author: Ryushe

  

 



