@echo off
:: Definir DNS Cloudflare (1.1.1.1)

echo.
echo [=] Definindo DNS Cloudflare (1.1.1.1)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Aplicando DNS Cloudflare a todas as interfaces...
for /f "tokens=3,*" %%a in ('netsh interface show interface ^| findstr /R /C:"Connected"') do (
    echo    Configurando %%b...
    netsh interface ipv4 set dns name="%%b" static 1.1.1.1 >nul 2>&1
    netsh interface ipv4 add dns name="%%b" 1.0.0.1 index=2 >nul 2>&1
)

echo [OK] DNS Cloudflare configurado.
echo.
echo [INFORMACAO] Cloudflare (1.1.1.1) e muito rapido e seguro.
echo [V] DNS Cloudflare (1.1.1.1) configurado!
pause
