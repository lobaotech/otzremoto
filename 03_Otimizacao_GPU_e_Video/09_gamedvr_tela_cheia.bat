@echo off
:: GameDVR e Otimizacoes de Tela Cheia

echo.
echo [=] Desativando GameDVR e Otimizacoes de Tela Cheia...
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Execute como Administrador.
    pause
    exit
)

echo [+] Desativando GameDVR...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

echo [+] Desativando FSE Behavior...
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f

echo [+] Desativando GameDVR globalmente...
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f

echo [OK] GameDVR e otimizacoes de tela cheia desativados.
echo.
echo [V] GameDVR e Otimizacoes de Tela Cheia desativados!
pause
