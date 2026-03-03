@echo off
:: Forcar Resolucao de Timer 0.5ms

echo.
echo [=] Forcando Resolucao de Timer 0.5ms...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [INFORMACAO] Timer resolution controla a precisao do kernel do Windows.
echo [INFORMACAO] Reduzir para 0.5ms melhora a precisao de eventos (reduz latencia).
echo.
echo [AVISO] Esta otimizacao requer utilitarios externos:
echo   - ISLC (Intelligent Standby List Cleaner) - Recomendado
echo   - SetTimerResolution
echo.
echo [PASSOS - ISLC]:
echo   1. Baixe o ISLC (https://www.wagnardsoft.com/forums/viewtopic.php?t=1256)
echo   2. Execute como administrador
echo   3. Marque "Optimize system responsiveness"
echo   4. Clique em "Start"
echo   5. O ISLC mantera a resolucao em 0.5ms
echo.
echo [PASSOS - SetTimerResolution]:
echo   1. Baixe SetTimerResolution
echo   2. Execute: SetTimerResolution.exe -resolution 5000 -cs
echo   3. Isso define a resolucao para 0.5ms
echo.
pause
