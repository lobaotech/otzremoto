@echo off
color 0A
title Otimizador GTA V

echo ==================================================
echo               OTIMIZADOR GTA V
echo ==================================================

echo Este script aplica otimizacoes para Grand Theft Auto V.
echo.
pause

:: Nome do processo do jogo
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
echo Otimizacoes para GTA V aplicadas.
echo ==================================================
pause
exit
