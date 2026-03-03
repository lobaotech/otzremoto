@echo off
:: Bloquear Updates Automaticos de Driver

echo.
echo [=] Bloqueando Updates Automaticos de Driver...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Bloqueando atualizacoes automaticas de driver...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f

echo [OK] Updates de driver bloqueados.
echo.
echo [INFORMACAO] Evita drivers problematicos que podem quebrar jogos.
echo [AVISO] Atualize drivers manualmente quando necessario.
echo [V] Updates de driver bloqueados!
pause
