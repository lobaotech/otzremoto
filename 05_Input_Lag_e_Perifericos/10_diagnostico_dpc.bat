@echo off
:: Diagnostico de Latencia DPC

echo.
echo [=] Diagnostico de Latencia DPC...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [INFORMACAO] DPC (Deferred Procedure Call) latency afeta a responsividade do sistema.
echo [INFORMACAO] Se a latencia DPC for alta, pode haver problemas de audio/video.
echo.
echo [AVISO] Esta otimizacao requer o utilitario LatencyMon.
echo.
echo [PASSOS]:
echo   1. Baixe LatencyMon (https://www.resplendence.com/latencymon)
echo   2. Execute como administrador
echo   3. Deixe rodando por alguns minutos durante uso normal
echo   4. Procure por drivers que causam latencia alta
echo   5. Atualize ou desabilite drivers problemáticos
echo.
echo [VALORES]:
echo   - Excelente: Menor que 1000 microsegundos
echo   - Bom: 1000-2000 microsegundos
echo   - Aceitavel: 2000-4000 microsegundos
echo   - Ruim: Maior que 4000 microsegundos
echo.
pause
