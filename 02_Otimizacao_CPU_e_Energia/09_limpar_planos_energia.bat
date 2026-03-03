@echo off
:: Limpar Planos de Energia Antigos

echo.
echo [=] Limpando Planos de Energia Antigos...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Listando planos de energia...
powercfg /list

echo [+] Removendo planos duplicados...
for /f "tokens=4" %%a in ('powercfg /list ^| findstr /v "Active"') do (
    powercfg /delete %%a 2>nul
)

echo [OK] Planos de energia limpos.
echo.
echo [INFORMACAO] Remove planos duplicados ou antigos.
echo [V] Planos de energia limpos!
pause
