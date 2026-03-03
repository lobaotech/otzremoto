@echo off
color 0A
title Otimizador de Jogo Generico

echo ==================================================
echo           OTIMIZADOR DE JOGO GENERICO
echo ==================================================

echo Este script aplica otimizacoes genericas para jogos.
echo Sera necessario editar o script para o nome do processo do seu jogo.
echo.
pause

echo.
echo [1/3] Definindo prioridade alta para o processo do jogo...
echo. (Voce precisara editar o nome do processo no script)

:: Altere 'NomeDoProcessoDoJogo.exe' para o nome real do executavel do seu jogo
wmic process where name="NomeDoProcessoDoJogo.exe" CALL setpriority "high priority"

echo.
echo [2/3] Desativando otimizacoes de tela cheia (FSO) para o jogo...
:: Altere 'NomeDoProcessoDoJogo.exe' para o nome real do executavel do seu jogo
reg add "HKCU\System\GameConfigStore\Children\NomeDoProcessoDoJogo.exe" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f

echo.
echo [3/3] Otimizando o agendador multimídia para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_DWORD /d 8 /f

echo ==================================================
echo Otimizacoes genericas aplicadas.
echo Lembre-se de editar o nome do processo do jogo no script.
echo ==================================================
pause
exit
