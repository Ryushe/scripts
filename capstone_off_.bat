@echo off

REM Check and save state for Internal PC-1
VBoxManage showvminfo "Internal PC-1" | find "running" > nul
if %errorlevel% equ 0 (
    echo Internal PC-1 is running, saving state...
    VBoxManage controlvm "Internal PC-1" savestate
) else (
    echo Internal PC-1 is not running
)

REM Check and save state for Internal PC-2
VBoxManage showvminfo "Internal PC-2" | find "running" > nul
if %errorlevel% equ 0 (
    echo Internal PC-2 is running, saving state...
    VBoxManage controlvm "Internal PC-2" savestate
) else (
    echo Internal PC-2 is not running
)

REM Check and save state for DMZ Linux Server
VBoxManage showvminfo "DMZ Linux Server" | find "running" > nul
if %errorlevel% equ 0 (
    echo DMZ Linux Server is running, saving state...
    VBoxManage controlvm "DMZ Linux Server" savestate
) else (
    echo DMZ Linux Server is not running
)

REM Check and save state for flatIronOS
VBoxManage showvminfo "flatIronOS" | find "running" > nul
if %errorlevel% equ 0 (
    echo flatIronOS is running, saving state...
    VBoxManage controlvm "flatIronOS" savestate
) else (
    echo flatIronOS is not running
)

REM Check and save state for ACMEsecurity
VBoxManage showvminfo "ACMEsecurity" | find "running" > nul
if %errorlevel% equ 0 (
    echo ACMEsecurity is running, saving state...
    VBoxManage controlvm "ACMEsecurity" savestate
) else (
    echo ACMEsecurity is not running
)

REM Check and save state for Consultant Machine
VBoxManage showvminfo "Consultant Machine" | find "running" > nul
if %errorlevel% equ 0 (
    echo Consultant Machine is running, saving state...
    VBoxManage controlvm "Consultant Machine" savestate
) else (
    echo Consultant Machine is not running
)

echo Done.
