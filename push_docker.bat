@echo off
setlocal
cd /d "%~dp0"

if "%~1"=="" (
  echo Usage: push_docker.bat dockerhub_username/image_name[:tag]
  echo Example: push_docker.bat myuser/hash256-node-miner:latest
  exit /b 1
)

set IMAGE=%~1

echo Pushing %IMAGE% ...
docker push %IMAGE%
if errorlevel 1 (
  echo Docker push failed. Run docker login first.
  exit /b 1
)

echo Pushed %IMAGE%
