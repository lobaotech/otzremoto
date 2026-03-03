@echo off
:: Definir MTU para 1400

echo.
echo [=] Definindo MTU para 1400 em todas as interfaces...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Listando interfaces de rede...
netsh interface ipv4 show interfaces

echo.
echo [+] Aplicando MTU 1400 a todas as interfaces ativas...
for /f "tokens=3,*" %%a in ('netsh interface ipv4 show interfaces ^| findstr /R /C:"connected"') do (
    echo    Configurando %%b...
    netsh interface ipv4 set subinterface "%%b" mtu=1400 store=persistent >nul 2>&1
)

echo [OK] MTU configurado para 1400.
echo.
echo [INFORMACAO] MTU 1400 reduz fragmentacao em algumas conexoes.
echo [V] MTU 1400 aplicado!
pause
