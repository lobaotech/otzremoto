@echo off
:: Remover Bloatware e Telemetria

echo.
echo [=] Removendo Bloatware e Telemetria...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Removendo BingWeather...
powershell -Command "Get-AppxPackage *BingWeather* | Remove-AppxPackage" 2>nul

echo [+] Removendo XboxApp...
powershell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage" 2>nul

echo [+] Removendo GetHelp...
powershell -Command "Get-AppxPackage *GetHelp* | Remove-AppxPackage" 2>nul

echo [+] Desativando Telemetria...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

echo [OK] Bloatware e telemetria removidos.
echo.
echo [INFORMACAO] Libera espaco e privacidade ao remover apps desnecessarios.
echo [V] Bloatware removido!
pause
