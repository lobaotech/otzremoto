@echo off
:: Plano de Desempenho Maximo

echo.
echo [=] Ativando Plano de Desempenho Maximo...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Duplicando esquema de energia Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

echo [+] Ativando plano...
for /f "tokens=2 delims=:" %%a in ('powercfg -list ^| find "Ultimate Performance"') do set "guid=%%a"
if defined guid (
    powercfg -setactive %guid%
    echo [OK] Plano ativado: %guid%
) else (
    echo [AVISO] Plano nao encontrado.
)

echo.
echo [V] Plano de Desempenho Maximo ativado!
pause
