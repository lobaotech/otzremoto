@echo off
color 0A
title Remover Microsoft Teams

echo ==================================================
echo             REMOVER MICROSOFT TEAMS
echo ==================================================

echo Este script remove o aplicativo Microsoft Teams do Windows.
echo Isso pode liberar recursos e melhorar a privacidade.
echo.
pause

:: Removendo Microsoft Teams (versao AppX)
PowerShell -Command "Get-AppxPackage *MicrosoftTeams* | Remove-AppxPackage"

:: Removendo Microsoft Teams (versao instalador)
if exist "%LOCALAPPDATA%\Microsoft\Teams" (
    rd /s /q "%LOCALAPPDATA%\Microsoft\Teams"
)
if exist "%APPDATA%\Microsoft\Teams" (
    rd /s /q "%APPDATA%\Microsoft\Teams"
)
if exist "%PROGRAMFILES%\WindowsApps\Microsoft.Teams_*.Appx" (
    PowerShell -Command "Get-AppxPackage -AllUsers *Microsoft.Teams* | Remove-AppxPackage"
)

echo ==================================================
echo Microsoft Teams removido.
echo ==================================================
pause
exit
