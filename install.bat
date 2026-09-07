@echo off
echo Installing Fostercare Addon Suite...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-Suite.ps1"
pause
