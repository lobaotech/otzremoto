@echo off
:: Definir OpenDNS (208.67.222.222)

echo.
echo [=] Definindo OpenDNS (208.67.222.222)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Aplicando OpenDNS a todas as interfaces...
for /f "tokens=3,*" %%a in ('netsh interface show interface ^| findstr /R /C:"Connected"') do (
    echo    Configurando %%b...
    netsh interface ipv4 set dns name="%%b" static 208.67.222.222 >nul 2>&1
    netsh interface ipv4 add dns name="%%b" 208.67.220.220 index=2 >nul 2>&1
)

echo [OK] OpenDNS configurado.
echo.
echo [INFORMACAO] OpenDNS oferece seguranca e controle parental.
echo [V] OpenDNS (208.67.222.222) configurado!
pause
