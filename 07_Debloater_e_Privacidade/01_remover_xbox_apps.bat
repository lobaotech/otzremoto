@echo off
color 0A
title Remover Apps Xbox

echo ==================================================
echo               REMOVER APPS XBOX
echo ==================================================

echo Este script remove os aplicativos Xbox pre-instalados do Windows.
echo Isso pode liberar recursos e melhorar a privacidade.
echo.
pause

echo [1/4] Removendo Xbox App...
PowerShell -Command "Get-AppxPackage *xboxapp* | Remove-AppxPackage"

echo [2/4] Removendo Xbox Game Bar...
PowerShell -Command "Get-AppxPackage *xboxgamebar* | Remove-AppxPackage"

echo [3/4] Removendo Xbox Identity Provider...
PowerShell -Command "Get-AppxPackage *xboxidentityprovider* | Remove-AppxPackage"

echo [4/4] Removendo Xbox Speech To Text Overlay...
PowerShell -Command "Get-AppxPackage *xboxspeechtotextoverlay* | Remove-AppxPackage"

echo ==================================================
echo Aplicativos Xbox removidos.
echo ==================================================
pause
exit
