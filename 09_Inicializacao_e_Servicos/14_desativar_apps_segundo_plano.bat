@echo off
:: Desativar Apps em Segundo Plano

echo.
echo [=] Desativando Apps em Segundo Plano...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando acesso em segundo plano global...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f

echo [OK] Apps em segundo plano desativados.
echo.
echo [INFORMACAO] Libera CPU e RAM ao desativar apps desnecessarios em background.
echo [V] Apps em segundo plano desativados!
pause
