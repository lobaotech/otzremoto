@echo off
:: Definir DNS Google (8.8.8.8)

echo.
echo [=] Definindo DNS Google (8.8.8.8)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Aplicando DNS Google a todas as interfaces...
for /f "tokens=3,*" %%a in ('netsh interface show interface ^| findstr /R /C:"Connected"') do (
    echo    Configurando %%b...
    netsh interface ipv4 set dns name="%%b" static 8.8.8.8 >nul 2>&1
    netsh interface ipv4 add dns name="%%b" 8.8.4.4 index=2 >nul 2>&1
)

echo [OK] DNS Google configurado.
echo.
echo [INFORMACAO] Google DNS (8.8.8.8) oferece boa velocidade e confiabilidade.
echo [V] DNS Google (8.8.8.8) configurado!
pause
