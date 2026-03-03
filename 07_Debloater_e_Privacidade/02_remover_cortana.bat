@echo off
color 0A
title Remover Cortana

echo ==================================================
echo                REMOVER CORTANA
echo ==================================================

echo Este script remove o aplicativo Cortana do Windows.
echo Isso pode liberar recursos e melhorar a privacidade.
echo.
pause

:: Removendo Cortana
PowerShell -Command "Get-AppxPackage -AllUsers *Microsoft.Windows.Cortana* | Remove-AppxPackage"

echo ==================================================
echo Cortana removida.
echo ==================================================
pause
exit
