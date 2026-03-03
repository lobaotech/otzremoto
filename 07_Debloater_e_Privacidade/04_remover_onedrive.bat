@echo off
color 0A
title Remover OneDrive

echo ==================================================
echo               REMOVER ONEDRIVE
echo ==================================================

echo Este script remove o OneDrive do Windows.
echo Isso pode liberar recursos e melhorar a privacidade.
echo.
pause

:: Finalizando o processo do OneDrive
taskkill /f /im OneDrive.exe

:: Desinstalando o OneDrive
if exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" (
    "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" /uninstall
) else (
    "%SYSTEMROOT%\System32\OneDriveSetup.exe" /uninstall
)

:: Removendo o OneDrive do Explorer
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f

echo ==================================================
echo OneDrive removido.
echo ==================================================
pause
exit
