@echo off
:: Resetar Cache do Windows Update

echo.
echo [=] Resetando Cache do Windows Update...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Parando servico Windows Update...
sc stop "wuauserv" 2>nul

echo [+] Removendo cache...
rd /s /q %windir%\SoftwareDistribution 2>nul

echo [+] Reiniciando servico...
sc start "wuauserv" 2>nul

echo [OK] Cache do Windows Update resetado.
echo.
echo [INFORMACAO] Resolve problemas de atualizacao corrompidas.
echo [V] Cache resetado!
pause
