@echo off
setlocal

set HASH256_URL=https://hash256.org/mine
set EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe
set CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe
set CHROME_X86=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe

if exist "%CHROME%" (
  start "HASH256 WebGPU" "%CHROME%" --app="%HASH256_URL%" --profile-directory="Default" --enable-unsafe-webgpu --enable-features=Vulkan,WebGPU
  goto done
)

if exist "%CHROME_X86%" (
  start "HASH256 WebGPU" "%CHROME_X86%" --app="%HASH256_URL%" --profile-directory="Default" --enable-unsafe-webgpu --enable-features=Vulkan,WebGPU
  goto done
)

if exist "%EDGE%" (
  start "HASH256 WebGPU" "%EDGE%" --app="%HASH256_URL%" --profile-directory="Default" --enable-unsafe-webgpu --enable-features=Vulkan,WebGPU
  goto done
)

start "HASH256 WebGPU" "%HASH256_URL%"

:done
echo Opened HASH256 browser miner. Select WebGPU/GPU mode in the page if available.
