@echo off
:: SFC Scannow

echo.
echo [=] Executando SFC Scannow...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Verificando integridade dos arquivos do sistema...
sfc /scannow

echo [OK] SFC concluido.
echo.
echo [INFORMACAO] Verifica e repara arquivos de sistema corrompidos.
echo [AVISO] Isto pode levar varios minutos.
echo [V] SFC executado!
pause
