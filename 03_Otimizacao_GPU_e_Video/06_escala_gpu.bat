@echo off
:: Forcar Escala na GPU

echo.
echo [=] Forcando Escala na GPU...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [INFORMACAO] Escala na GPU reduz latencia de renderizacao.
echo [INFORMACAO] Ao inves de escalar na CPU, a GPU faz o trabalho (mais rapido).
echo.
echo [AVISO] Esta otimizacao deve ser feita no Painel de Controle da NVIDIA.
echo.
echo [PASSOS - NVIDIA]:
echo   1. Clique com botao direito na area de trabalho
echo   2. Abra "Painel de Controle da NVIDIA"
echo   3. Vá para "Ajustar o tamanho e a posicao da area de trabalho"
echo   4. Em "Executar escala em", selecione "GPU"
echo   5. Clique em "Aplicar"
echo.
echo [PASSOS - AMD]:
echo   1. Abra o AMD Radeon Settings
echo   2. Vá para "Display"
echo   3. Procure por opcoes de escala
echo   4. Selecione "GPU Scaling"
echo.
pause
