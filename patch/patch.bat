:MENU_START
@echo off
cls
set INPUT=false
set "MENU_OPTION="
set "OPTION1_INPUT="
set "OPTION2_INPUT="
echo  +===============================================+
echo  .           BATCH SCRIPT - USER MENU            .
echo  +===============================================+
echo  .                                               .
echo  .  [1] ADMINISTRATOR ACCOUNT ACTIVATION         .
echo  .  [2] LAUNCH SCRIPTS                           .
echo  .  [3] DISABLE ADMINISTRATOR ACCOUNT            .
echo  .                                               .
echo  .  [4] EXIT                                     .
echo  .                                               .
echo  +===============================================+
echo.
set /p MENU_OPTION="OPTION: "

IF %MENU_OPTION%==1 GOTO OPTION1
IF %MENU_OPTION%==2 GOTO OPTION2
IF %MENU_OPTION%==3 GOTO OPTION3
IF %MENU_OPTION%==4 GOTO OPTION4
IF %INPUT%==false GOTO DEFAULT

:OPTION1
set INPUT=true
setlocal enabledelayedexpansion
set fore_dred=[31m
echo.
echo.
echo [31mAccount Administrator ACTIVATED![0m
net user Administrator /active:yes
timeout 1 > NUL
echo.
echo.
set/p "end=Press a key to disconnect the user!"
logoff

:OPTION2
set INPUT=true
setlocal enabledelayedexpansion
set fore_dred=[31m
set underline=[4m
echo.
echo.
wmic useraccount get name,SID
echo.
echo.
set/p "sid=[4mCopy the SID value here:[0m "
echo.
set/p "oldname=[4mCopy the name here:[0m "
echo.
set/p "newname=[4mEnter the new name:[0m "
echo.
echo.
echo.
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\ProfileList\%sid%" /v ProfileImagePath /t REG_EXPAND_SZ /d C:\Users\%newname% /f
echo.
echo.
cd c:\Users
rename "%oldname%" "%newname%"
echo.
wmic useraccount where name="%oldname%" rename "%newname%"
echo.
echo [31mAccount Administrator DISABLED![0m
:: net user Administrator /active:no
timeout 1 > NUL
echo.
echo.
echo.
set/p "end=Press a key to disconnect the user!"
logoff

:OPTION3
set INPUT=true
setlocal enabledelayedexpansion
set fore_dred=[31m
set underline=[4m
echo.
echo.
echo [31mAccount Administrator DISABLED![0m
net user Administrator /active:no
cd C:\Users
del /f /s /q Administrator 1 > NUL
rmdir /s /q Administrator
cd C:\
rmdir /s /q "$WINDOWS.~BT"
rmdir /s /q "$WINDOWS.~LS"
timeout 1 > NUL
echo.
echo.
set/p "end=[31mCleaning done, press a button to exit![0m"
exit

:OPTION4
set INPUT=true
echo.
echo Bye Bye!!!
echo.
timeout 2 > NUL
exit /b

:DEFAULT
echo Option not available
timeout 2 > NUL
GOTO MENU_START
