@echo off
:: Desativar TCP Coalescing (RSC)

echo.
echo [=] Desativando TCP Coalescing (RSC)...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando RSC (Receive Segment Coalescing)...
netsh int tcp set global rsc=disabled

echo [OK] TCP Coalescing desativado.
echo.
echo [INFORMACAO] RSC agrupa pacotes, aumentando latencia. Desativar reduz latencia.
echo [V] TCP Coalescing desativado!
pause
