@echo off
REM 6-7 ARCADE booth launcher: builds once, serves locally, opens the browser full-screen.
cd /d "%~dp0"
set "PATH=C:\Program Files\nodejs;%PATH%"

if not exist node_modules (
  echo Installing dependencies...
  call npm install || goto :fail
)
echo Building game...
call npm run build || goto :fail

start "6-7 ARCADE server" /min cmd /c "npx vite preview --port 5173 --strictPort"
timeout /t 3 /nobreak >nul

REM Prefer Chrome kiosk mode; fall back to Edge kiosk mode.
set "URL=http://localhost:5173"
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --kiosk --autoplay-policy=no-user-gesture-required "%URL%"
) else (
  start "" msedge --kiosk "%URL%" --edge-kiosk-type=fullscreen --autoplay-policy=no-user-gesture-required
)
exit /b 0

:fail
echo Something went wrong. Make sure Node.js is installed.
pause
