@echo off
:: Desativar Economia de Energia USB

echo.
echo [=] Desativando Economia de Energia USB...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desbloqueando atributos de economia USB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\48e6b7a6-50f5-4782-a5d4-53bb8f07e226" /v Attributes /t REG_DWORD /d 2 /f

echo [+] Desativando suspensao seletiva USB...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f

echo [OK] Economia de energia USB desativada.
echo.
echo [INFORMACAO] Evita que o Windows desative portas USB para economizar energia.
echo [V] Economia de Energia USB desativada!
pause
