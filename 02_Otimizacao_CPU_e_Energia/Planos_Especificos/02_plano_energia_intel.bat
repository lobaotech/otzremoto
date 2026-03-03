@echo off
color 0A
title Plano de Energia Intel

echo ==================================================
echo          PLANO DE ENERGIA ULTIMATE (INTEL)
echo ==================================================

echo Este script cria e ativa o plano de energia "Ultimate Performance"
echo otimizado para CPUs Intel.
echo.
pause

:: GUID do plano Ultimate Performance (oculto por padrao)
set ULTIMATE_GUID=e9a42b02-d5df-448d-aa00-03f14749eb61

echo [1/2] Duplicando o plano Ultimate Performance...
powercfg -duplicatescheme %ULTIMATE_GUID%

:: Captura o GUID do novo plano duplicado
for /f "tokens=4" %%a in (
    'powercfg -list ^| findstr /i "%ULTIMATE_GUID%"'
) do (
    set NEW_GUID=%%a
)

echo [2/2] Ativando o novo plano de energia...
powercfg -setactive %NEW_GUID%

echo ==================================================
echo Plano de energia "Ultimate Performance" ativado para Intel.
echo ==================================================
pause
exit
