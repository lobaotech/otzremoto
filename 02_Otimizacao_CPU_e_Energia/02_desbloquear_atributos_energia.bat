@echo off
:: Desbloquear Atributos de Energia Ocultos

echo.
echo [=] Desbloqueando Atributos de Energia Ocultos...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desbloqueando atributos de energia...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\bc5038f7-23e0-4961-969f-58e3a97d2729" /v Attributes /t REG_DWORD /d 2 /f

echo [OK] Atributos desbloqueados.
echo.
echo [V] Atributos de Energia Ocultos desbloqueados!
pause
