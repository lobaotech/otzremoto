@echo off
title CRIAR PONTO DE RESTAURACAO - PACK PREMIUM
:: Verifica privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERRO: Execute como ADMINISTRADOR.
    pause
    exit /b
)

echo ======================================================
echo       CRIANDO PONTO DE RESTAURACAO DO SISTEMA
echo ======================================================
echo.
echo Este passo e CRITICO antes de qualquer otimizacao.
echo.
powershell.exe -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Antes_Otimizacao_Premium' -RestorePointType 'MODIFY_SETTINGS'"

if %errorLevel% equ 0 (
    echo.
    echo [OK] Ponto de restauracao criado com sucesso!
) else (
    echo.
    echo [!] FALHA ao criar ponto de restauracao. 
    echo Verifique se a Protecao do Sistema esta ativada no C:
)
echo.
pause
