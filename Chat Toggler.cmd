@echo off
REM  --> This block of code makes the script ask for admin permission
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 
REM -> End of admin permission
@echo off
REM -> Varible for final colors
set NUM=0 1 2 3 4 5 6 7 8 9 A B C D E F 
@echo off
:reset
REM -> Input server
set /p server="Choose your server(EUW/NA/TR/LAS/LAN): "
@ECHO OFF

REM ->Swith to select your server ip
2>NUL CALL :CASE_%server%
IF ERRORLEVEL 1 CALL :DEFAULT_CASE
ECHO Done.
EXIT /B

REM ↓↓If the ip changes you need to change it here↓↓
:CASE_EUW
  set ip=172.65.252.238 
  GOTO END_CASE
:CASE_euw
  set ip=172.65.252.238
  GOTO END_CASE
:CASE_NA
  set ip=172.65.244.155
  GOTO END_CASE
:CASE_na
  set ip=172.65.244.155
  GOTO END_CASE
:CASE_TR
  set ip=172.65.202.166
  GOTO END_CASE
:CASE_tr
set ip=172.65.202.166
GOTO END_CASE
:CASE_LAS
  set ip=172.65.194.233
  GOTO END_CASE
:CASE_las
  set ip=172.65.194.233
  GOTO END_CASE
:CASE_LAN
  set ip=172.65.250.49
  GOTO END_CASE
:CASE_lan
  set ip=172.65.250.49
  GOTO END_CASE
:DEFAULT_CASE
  powershell write-host -fore Red "Unknown server %server%. It isn't one of the options'";
  GOTO :reset
:END_CASE





@echo off
REM -> Random ascii art
set disabled=You are disconnected from %server%
set enabled=You are connected to %server%
:::	       .__            __      __                       .__                
:::	  ____ |  |__ _____ _/  |_  _/  |_  ____   ____   ____ |  |   ___________ 
:::	_/ ___\|  |  \\__  \\   __\ \   __\/  _ \ / ___\ / ___\|  | _/ __ \_  __ \
:::	\  \___|   Y  \/ __ \|  |    |  | (  <_> ) /_/  > /_/  >  |_\  ___/|  | \/
:::	 \___  >___|  (____  /__|    |__|  \____/\___  /\___  /|____/\___  >__|   
:::	     \/     \/     \/                   /_____//_____/           \/      
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
REM -> To check connection status, firstly trys to delete the rule and depending on result display the status  
netsh advfirewall firewall delete rule name="lolchat" > nul 2>&1
if not %errorlevel% GTR 0 (
  REM -> There was a rule called lolchat so creates it again
	netsh advfirewall firewall add rule name="lolchat" dir=out remoteip=%ip% protocol=TCP action=block > nul 2>&1
	powershell write-host -fore Red %disabled%
	SET status=0
	
)
if %errorlevel% GTR 0 (
  REM -> There wasn't a rule called lolchat
	powershell write-host -fore Green %enabled%
	SET status=1
)
@echo off
set stop=0
:toggle
REM -> Yes/No input
set /p id="Do you want to toggle chat connection?(Y/N): "

REM -> Just some conditionals and a loop control
if %id%==Y ( goto :cond
)
if %id%==y ( goto :cond
)
IF  %id%==N (
    echo+
    echo+
    powershell write-host -fore Green oukay bruh ill close
    echo+
    echo+
    goto:skip
)

IF  %id%==n ( 
    echo+
    echo+
    powershell write-host -fore Green oukay bruh ill close
    echo+
    echo+
    goto :skip
) 
if %stop%==5 (
    powershell write-host -fore Green It isn't that hard buddy, Y or N'
    set /A stop=%stop%+2
    goto :toggle
)
if %stop%==10 (
    powershell write-host -fore Red Nah gtfo
    color 64
    sleep 2
    goto :exit
) ELSE (
    powershell write-host -fore Red You must insert Y or N
    set /A stop=%stop%+1
    goto :toggle

)

:cond
REM -> If disconnected, connects you
if %status%==0 (
netsh advfirewall firewall delete rule name="lolchat" > nul 2>&1
echo+
echo Now you are connected %server%
echo Closing this window...
goto :skip
)
REM -> If connected, connects you
if %status%==1 (
netsh advfirewall firewall add rule name="lolchat" dir=out remoteip=%ip% protocol=TCP action=block > nul 2>&1 
echo+
echo Now you are disconnected from %server%
echo Closing this window...
)
:skip
REM -> More random ascii
:::      ___                                                             
:::     /___\_/                                                          
:::     |\_/|<\                               
:::     (`o`) `   __(\_            |\_                                   
:::     \ ~ /_.-`` _|__)  ( ( ( ( /()/                                   
:::    _/`-`  _.-``               `\|       
::: .-`      (    .-.                                                    
:::(   .-     \  /   `-._                                                
::: \  (\_    /\/        `-.__-()                                        
:::  `-|__)__/ /  /``-.   /_____8                                        
:::        \__/  /     `-`                                               
:::       />|   /                                                        
:::      /| J   L                                                        
:::      `` |   |                                                        
:::         L___J                                                        
:::          ( |                       
:::         .oO()
:::
:::
:::
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
@echo off
REM -> Loop for color change
for %%x in (%NUM%) do ( 
    for %%y in (%NUM%) do (
        color 0%%y
        timeout 0 >nul
    )
    if [%%x]==[1] (
    goto :exit
    
    )
)
:exit
REM -> Bye
exit