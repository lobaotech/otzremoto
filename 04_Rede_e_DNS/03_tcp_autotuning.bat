@echo off
:: TCP Auto-Tuning (Baixa Latencia)

echo.
echo [=] Configurando TCP Auto-Tuning para Baixa Latencia...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Definindo autotuninglevel=highlyrestricted...
netsh int tcp set global autotuninglevel=highlyrestricted

echo [OK] TCP Auto-Tuning configurado para baixa latencia.
echo.
echo [INFORMACAO] highlyrestricted reduz latencia em conexoes de rede.
echo [V] TCP Auto-Tuning configurado!
pause
