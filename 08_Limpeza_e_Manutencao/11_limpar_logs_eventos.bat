@echo off
:: Limpar Todos os Logs de Eventos

echo.
echo [=] Limpando Todos os Logs de Eventos...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Limpando logs de Aplicacao...
wevtutil.exe cl Application 2>nul

echo [+] Limpando logs de Seguranca...
wevtutil.exe cl Security 2>nul

echo [+] Limpando logs de Sistema...
wevtutil.exe cl System 2>nul

echo [OK] Logs de eventos limpos.
echo.
echo [INFORMACAO] Libera espaco em disco ao remover logs antigos.
echo [V] Logs limpos!
pause
