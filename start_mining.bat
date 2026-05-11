@echo off
setlocal
cd /d "%~dp0"

if not exist "node_modules\dotenv\package.json" (
  echo [%date% %time%] Installing Node.js dependencies...
  npm install
  if errorlevel 1 (
    echo [%date% %time%] npm install failed. Please run npm install manually.
    pause
    exit /b 1
  )
)

:loop
echo [%date% %time%] Starting HASH256 CPU miner mode...
node src\miner.js --mode=mine
echo [%date% %time%] CPU miner stopped or crashed. Restarting in 5 seconds...
timeout /t 5 /nobreak >nul
goto loop
