@echo off
:: Desativar Superfetch (SysMain)

echo.
echo [=] Desativando Superfetch (SysMain)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Parando servico SysMain...
sc stop "SysMain"

echo [+] Desativando SysMain na inicializacao...
sc config "SysMain" start=disabled

echo [OK] Superfetch desativado.
echo.
echo [INFORMACAO] Superfetch precarrega arquivos em memoria. Desativar libera RAM.
echo [V] Superfetch desativado!
pause
