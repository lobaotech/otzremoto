@echo off
:: Desativar Aceleracao do Mouse (MarkC Fix)

echo.
echo [=] Desativando Aceleracao do Mouse (MarkC Fix)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando aceleracao do mouse...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f

echo [+] Desativando thresholds do mouse...
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f

echo [OK] Aceleracao do mouse desativada.
echo.
echo [INFORMACAO] Aceleracao do mouse adiciona latencia. Desativar garante resposta consistente.
echo [DICA] Tambem desative a aceleracao no driver do mouse (se disponivel).
echo [V] Aceleracao do Mouse desativada!
pause
