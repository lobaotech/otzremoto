@echo off
:: Habilitar Receive Side Scaling (RSS)

echo.
echo [=] Habilitando Receive Side Scaling (RSS)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Ativando RSS para distribuir processamento de rede...
netsh int tcp set global rss=enabled

echo [OK] RSS habilitado.
echo.
echo [INFORMACAO] RSS distribui o processamento de rede entre multiplos nucleos da CPU.
echo [V] Receive Side Scaling (RSS) habilitado!
pause
