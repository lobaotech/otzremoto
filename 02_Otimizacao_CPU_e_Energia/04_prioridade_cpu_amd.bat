@echo off
:: Prioridade CPU AMD - Desempenho Maximo

echo.
echo [=] Otimizando Prioridade para CPUs AMD...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Configurando prioridade de GPU para AMD...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f

echo [+] Configurando categoria de agendamento...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f

echo [OK] Prioridade de CPU AMD otimizada.
echo.
echo [V] Prioridade CPU AMD - Desempenho Maximo ativada!
pause
