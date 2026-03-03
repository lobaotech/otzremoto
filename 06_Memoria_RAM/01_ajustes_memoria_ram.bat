@echo off
color 0A
title Ajustes de Memoria RAM

echo ==================================================
echo             AJUSTES DE MEMORIA RAM
echo ==================================================

echo Este script otimiza as configuracoes de memoria RAM do Windows.
echo.
pause

:: Detecta a quantidade de RAM (em MB)
for /f "skip=1 tokens=2" %%a in (
    'wmic ComputerSystem get TotalPhysicalMemory /value ^| findstr "="'
) do (
    set /a TotalRAM_Bytes=%%a
)
set /a TotalRAM_GB=%TotalRAM_Bytes% / 1024 / 1024 / 1024

echo RAM Detectada: %TotalRAM_GB% GB
echo.

:: ==================================================
:: Ajustes de Arquivo de Paginacao (Memoria Virtual)
:: ==================================================

echo [1/2] Ajustando o arquivo de paginacao (memoria virtual)...

:: Desativa o gerenciamento automatico do arquivo de paginacao
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=FALSE

:: Define o tamanho do arquivo de paginacao com base na RAM
:: Recomendacao geral: 1.5x RAM para min, 3x RAM para max
set /a InitialSizeMB=%TotalRAM_GB% * 1024 * 1.5
set /a MaximumSizeMB=%TotalRAM_GB% * 1024 * 3

:: Garante um minimo razoavel para sistemas com pouca RAM
if %InitialSizeMB% LSS 2048 set InitialSizeMB=2048
if %MaximumSizeMB% LSS 4096 set MaximumSizeMB=4096

echo Definindo tamanho inicial: %InitialSizeMB% MB
echo Definindo tamanho maximo: %MaximumSizeMB% MB

wmic pagefile where name="C:\pagefile.sys" set InitialSize=%InitialSizeMB%,MaximumSize=%MaximumSizeMB%

echo.
echo [2/2] Otimizando a lista de espera (Standby List) para liberar RAM...

:: Este comando requer uma ferramenta externa (EmptyStandbyList.exe) para ser eficaz.
:: Se o usuario nao tiver, o script informara.
:: A ferramenta EmptyStandbyList.exe pode ser baixada de: https://docs.microsoft.com/en-us/sysinternals/downloads/empty-standby-list

if exist "%~dp0EmptyStandbyList.exe" (
    echo Executando EmptyStandbyList.exe...
    "%~dp0EmptyStandbyList.exe" workingsets
    "%~dp0EmptyStandbyList.exe" modifiedpagelist
    "%~dp0EmptyStandbyList.exe" standbyalist
    "%~dp0EmptyStandbyList.exe" priority0standbylist
) else (
    echo AVISO: EmptyStandbyList.exe nao encontrado na pasta do script.
    echo Para liberar a lista de espera, baixe-o em: https://docs.microsoft.com/en-us/sysinternals/downloads/empty-standby-list
    echo E coloque-o na mesma pasta deste script.
)

echo ==================================================
echo Ajustes de memoria RAM aplicados.
echo Pode ser necessario reiniciar para que todas as alteracoes tenham efeito.
echo ==================================================
pause
exit
