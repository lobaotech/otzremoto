@echo off
:: Win32PrioritySeparation - Prioridade de CPU

echo.
echo [=] Configurando Win32PrioritySeparation...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Definindo Win32PrioritySeparation para 38 (0x26)...
echo [INFORMACAO] Valor 38 (0x26) = Prioridade maxima para aplicacoes em primeiro plano
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

echo [OK] Win32PrioritySeparation configurado.
echo.
echo [V] Win32PrioritySeparation configurado!
pause
