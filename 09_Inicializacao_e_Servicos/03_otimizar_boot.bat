@echo off
:: Otimizar Tempo de Boot (10s)

echo.
echo [=] Otimizando Tempo de Boot para 10 segundos...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Definindo timeout do Boot Manager para 10 segundos...
bcdedit /set {bootmgr} timeout 10

echo [OK] Tempo de boot otimizado.
echo.
echo [INFORMACAO] Reduz o tempo de espera no menu de boot de 30s para 10s.
echo [V] Boot otimizado!
pause
