@echo off
:: Remover Limite de Largura de Banda QoS

echo.
echo [=] Removendo Limite de Largura de Banda QoS...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Removendo limite QoS (NonBestEffortLimit=0)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f

echo [OK] Limite QoS removido.
echo.
echo [INFORMACAO] QoS reserva 20%% da largura de banda. Remover libera 100%% para aplicacoes.
echo [V] Limite QoS removido!
pause
