@echo off
:: Agendar CHKDSK

echo.
echo [=] Agendando CHKDSK...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Agendando verificacao de disco para proxima inicializacao...
chkdsk C: /f /r

echo [OK] CHKDSK agendado.
echo.
echo [INFORMACAO] Verificara e reparara erros de disco na proxima inicializacao.
echo [AVISO] Isto pode levar muito tempo.
echo [V] CHKDSK agendado!
pause
