@echo off
:: Reset de Fabrica de Rede

echo.
echo [=] Resetando Winsock e Pilha TCP/IP...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Resetando TCP/IP...
netsh int ip reset

echo [+] Resetando Winsock...
netsh winsock reset

echo [OK] Rede resetada para configuracoes padrao.
echo.
echo [V] Reset de Fabrica de Rede concluido!
pause
