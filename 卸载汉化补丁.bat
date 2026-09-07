@echo off
rem Thomas Was Alone Chinese localization patch - uninstaller launcher
rem This bat only launches uninstall.ps1 (all logic inside, PowerShell required)
chcp 65001 >nul
title Thomas Was Alone Chinese Patch - Uninstaller
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"
