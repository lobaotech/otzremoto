@echo off
:: Otimizar Servicos para Jogos

echo.
echo [=] Otimizando Servicos para Jogos...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Configurando DiagTrack para demand...
sc config "DiagTrack" start=demand

echo [+] Configurando MapsBroker para demand...
sc config "MapsBroker" start=demand

echo [+] Configurando Xbox services para demand...
sc config "XboxGipSvc" start=demand
sc config "XblAuthManager" start=demand
sc config "XblGameSave" start=demand

echo [OK] Servicos otimizados para jogos.
echo.
echo [INFORMACAO] Estes servicos sao desativados para liberar recursos durante jogos.
echo [V] Servicos otimizados!
pause
