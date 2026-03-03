@echo off
title BACKUP DO REGISTRO - PACK PREMIUM
:: Verifica privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERRO: Execute como ADMINISTRADOR.
    pause
    exit /b
)

echo ======================================================
echo           BACKUP COMPLETO DO REGISTRO
echo ======================================================
echo.
echo Criando backup do registro na pasta atual...
echo.

set "backup_file=%~dp0REG_BACKUP_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.reg"
set "backup_file=%backup_file: =0%"

reg export HKLM "%backup_file%" /y >nul 2>&1
reg export HKCU "%backup_file%_user.reg" /y >nul 2>&1

echo [OK] Backup do registro concluido!
echo Arquivo: %backup_file%
echo.
pause
