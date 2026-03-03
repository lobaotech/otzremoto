@echo off
:: Limpar e Renovar DNS

echo.
echo [=] Limpando e Renovando DNS...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Limpando cache DNS...
ipconfig /flushdns

echo [+] Renovando configuracoes DHCP...
ipconfig /renew

echo [OK] Cache DNS limpo e configuracoes renovadas.
echo.
echo [INFORMACAO] Remove entradas de DNS em cache que possam estar desatualizadas.
echo [V] DNS limpo e renovado!
pause
