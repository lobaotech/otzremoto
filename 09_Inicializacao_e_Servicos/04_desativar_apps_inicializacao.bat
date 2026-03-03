@echo off
:: Desativar Apps de Inicializacao Comuns

echo.
echo [=] Desativando Apps de Inicializacao Comuns...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando Teams...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /t REG_SZ /d "" /f

echo [+] Desativando Cortana...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Cortana" /t REG_SZ /d "" /f

echo [+] Desativando Skype...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Skype" /t REG_SZ /d "" /f

echo [+] Desativando YourPhone...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "YourPhone" /t REG_SZ /d "" /f

echo [+] Desativando Microsoft Edge...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_..." /t REG_SZ /d "" /f

echo [OK] Apps de inicializacao desativados.
echo.
echo [INFORMACAO] Reduz tempo de boot ao desativar apps desnecessarios.
echo [V] Apps desativados!
pause
