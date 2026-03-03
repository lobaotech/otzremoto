@echo off
:: Indice de Estrangulamento de Rede

echo.
echo [=] Removendo Indice de Estrangulamento de Rede...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Definindo NetworkThrottlingIndex para FFFFFFFF (sem limite)...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f

echo [OK] Indice de estrangulamento removido.
echo.
echo [INFORMACAO] Permite uso maximo de largura de banda sem limitacoes do Windows.
echo [V] Indice de Estrangulamento removido!
pause
