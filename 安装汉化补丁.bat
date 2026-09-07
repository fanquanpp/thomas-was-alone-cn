@echo off
rem Thomas Was Alone Chinese localization patch - installer launcher
rem This bat only launches install.ps1 (all logic inside, PowerShell required)
chcp 65001 >nul
title Thomas Was Alone Chinese Patch - Installer
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
