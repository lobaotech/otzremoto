@echo off
:: Atualizar Drivers e SO

echo.
echo [=] Atualizando Drivers e SO...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Iniciando verificacao de atualizacoes...
UsoClient.exe StartScan

echo [+] Verificando dispositivos Plug and Play...
PnPUtil.exe /scan-devices

echo [OK] Verificacao de drivers concluida.
echo.
echo [INFORMACAO] Procura por drivers atualizados para seus dispositivos.
echo [V] Drivers verificados!
pause
