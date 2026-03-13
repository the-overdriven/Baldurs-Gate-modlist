@echo off

set DEST=D:\Dropbox\_GAMES\_BG1\PROJECTS\MODLIST
set LUA_SRC=%USERPROFILE%\Documents\Baldur's Gate - Enhanced Edition\baldur.lua

echo Generating WeiDU.md...
node weidu-to-md.js WeiDU.log "%DEST%\README.md"
if errorlevel 1 (
    echo ERROR: Failed to generate markdown. Aborting.
    pause
    exit /b 1
)

echo Copying baldur.lua...
copy "%LUA_SRC%" "%DEST%\baldur.lua"
if errorlevel 1 (
    echo ERROR: Failed to copy baldur.lua. Aborting.
    pause
    exit /b 1
)

echo Committing and pushing...
cd /d "%DEST%"
git add .
git commit -m "update mods"
git push

echo Done!
pause
