@echo off
color 0A
title Otimizador FiveM

echo ==================================================
echo               OTIMIZADOR FIVEM
echo ==================================================

echo Este script aplica otimizacoes para FiveM.
echo.
pause

:: FiveM usa o executavel do GTA V, mas pode ter seu proprio processo
:: O processo principal do FiveM geralmente e FiveM.exe ou FiveM_b2189_GTAProcess.exe
:: Para maior compatibilidade, vamos focar no GTA5.exe que e o jogo base.
set GAME_PROCESS=GTA5.exe

echo.
echo [1/3] Definindo prioridade alta para o processo do jogo (%GAME_PROCESS%)...
wmic process where name="%GAME_PROCESS%" CALL setpriority "high priority"

echo.
echo [2/3] Desativando otimizacoes de tela cheia (FSO) para o jogo (%GAME_PROCESS%)...
reg add "HKCU\System\GameConfigStore\Children\%GAME_PROCESS%" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f

echo.
echo [3/3] Otimizando o agendador multimídia para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_DWORD /d 8 /f

echo ==================================================
echo Otimizacoes para FiveM aplicadas.
echo ==================================================
pause
exit
