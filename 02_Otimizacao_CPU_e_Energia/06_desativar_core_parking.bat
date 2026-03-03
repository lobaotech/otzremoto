@echo off
:: Desativar Core Parking

echo.
echo [=] Desativando Core Parking...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Abrindo configuracoes de energia avancadas...
echo [+] Procure por "Core Parking" e desative-o manualmente ou use o comando abaixo:
echo.

:: Tenta desativar Core Parking via PowerShell
echo [+] Desativando Core Parking via PowerShell...
powershell -Command "Get-CimInstance -Namespace 'root\cimv2\power' -ClassName Win32_PwrCapabilities | Select-Object -ExpandProperty CpuCoreParking"

echo.
echo [AVISO] Core Parking pode variar conforme o processador.
echo [DICA] Use PowerSettingsExplorer ou ferramentas como ThrottleStop para desativar Core Parking.
echo.
pause
