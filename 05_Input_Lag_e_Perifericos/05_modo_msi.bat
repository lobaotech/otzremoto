@echo off
:: Modo MSI (Prioridade Alta)

echo.
echo [=] Modo MSI (Message Signaled Interrupts) - Prioridade Alta...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [INFORMACAO] MSI permite que dispositivos sinalizem interrupcoes de forma mais eficiente.
echo [INFORMACAO] Isso reduz latencia de GPU e perifericos USB.
echo.
echo [AVISO] Esta otimizacao requer o utilitario MSI Utility (MSI_util_v3.exe).
echo.
echo [PASSOS]:
echo   1. Baixe o MSI Utility do repositorio oficial
echo   2. Execute o programa como administrador
echo   3. Procure por GPU e USB nos dispositivos
echo   4. Defina a prioridade para "High"
echo   5. Reinicie o sistema
echo.
pause
