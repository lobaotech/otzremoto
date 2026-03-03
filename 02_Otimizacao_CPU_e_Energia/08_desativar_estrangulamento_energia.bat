@echo off
:: Desativar Estrangulamento de Energia (Power Throttling)

echo.
echo [=] Desativando Estrangulamento de Energia...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando Power Throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f

echo [OK] Estrangulamento de energia desativado.
echo.
echo [V] Estrangulamento de Energia desativado!
pause
