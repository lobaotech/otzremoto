@echo off
:: Desativar HPET (High Precision Event Timer)

echo.
echo [=] Desativando HPET (High Precision Event Timer)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Removendo configuracao de HPET...
bcdedit /deletevalue useplatformclock

echo [OK] HPET desativado.
echo.
echo [INFORMACAO] HPET pode aumentar latencia em alguns sistemas. Desativar pode reduzir latencia.
echo [AVISO] Tambem desative HPET no BIOS para melhor resultado.
echo [V] HPET desativado!
pause
