@echo off
:: Desativar Spooler de Impressao

echo.
echo [=] Desativando Spooler de Impressao...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Parando servico de impressao...
sc stop "Spooler"

echo [+] Desativando na inicializacao...
sc config "Spooler" start=disabled

echo [OK] Spooler desativado.
echo.
echo [INFORMACAO] Libera recursos se voce nao usa impressoras.
echo [AVISO] Impressoras nao funcionarao ate reativar.
echo [V] Spooler desativado!
pause
