@echo off
setlocal
cd /d "%~dp0"

if "%~1"=="" (
  echo Usage: build_docker.bat dockerhub_username/image_name[:tag]
  echo Example: build_docker.bat myuser/hash256-node-miner:latest
  exit /b 1
)

set IMAGE=%~1

echo Building %IMAGE% ...
docker build -t %IMAGE% .
if errorlevel 1 (
  echo Docker build failed.
  exit /b 1
)

echo Built %IMAGE%
