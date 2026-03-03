@echo off
:: Buffers de Entrada de Baixa Latencia

echo.
echo [=] Configurando Buffers de Entrada de Baixa Latencia...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Configurando buffer do mouse...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 16 /f

echo [+] Configurando buffer do teclado...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 16 /f

echo [OK] Buffers de entrada configurados.
echo.
echo [INFORMACAO] Reduz latencia de mouse e teclado ao aumentar o tamanho do buffer.
echo [V] Buffers de Entrada de Baixa Latencia configurados!
pause
