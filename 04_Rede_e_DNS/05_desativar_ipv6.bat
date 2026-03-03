@echo off
:: Desativar IPv6

echo.
echo [=] Desativando IPv6...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando protocolo IPv6 no registro...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f

echo [OK] IPv6 desativado.
echo.
echo [INFORMACAO] IPv6 pode causar latencia em alguns casos. Desativar pode melhorar ping.
echo [V] IPv6 desativado!
pause
