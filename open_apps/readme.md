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
  - helpful when want to use the urls feature

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

author: Ryushe

  

 



