@echo off
:: Desativar Servico Windows Update

echo.
echo [=] Desativando Servico Windows Update...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Parando servico de atualizacao...
sc stop "wuauserv"

echo [+] Desativando na inicializacao...
sc config "wuauserv" start=disabled

echo [OK] Windows Update desativado.
echo.
echo [INFORMACAO] Evita downloads durante jogos. Reative periodicamente para seguranca.
echo [AVISO] Seu sistema ficara desatualizado. Use com cuidado!
echo [V] Windows Update desativado!
pause
