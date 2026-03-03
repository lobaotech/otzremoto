@echo off
:: Agendamento de GPU Acelerado por Hardware

echo.
echo [=] Ativando Agendamento de GPU Acelerado por Hardware...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Ativando HwSchMode para GPU...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

echo [OK] Agendamento de GPU acelerado por hardware ativado.
echo.
echo [V] Agendamento de GPU Acelerado por Hardware ativado!
pause
