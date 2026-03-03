@echo off
:: OTIMIZADOR DE INPUT LAG - FPS MACHINE

:: Verifica privilégios de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO] Este script precisa ser executado como Administrador.
    pause
    exit
)

:menu
cls
echo =====================================================================
echo                  OTIMIZADOR DE INPUT LAG - FPS MACHINE
echo =====================================================================
echo.
echo   [1] Buffers de Entrada de Baixa Latencia
necho   [2] Maximizar Resposta do Teclado
necho   [3] Desativar HPET (BIOS/SO)
necho   [4] Desativar Economia de Energia USB
necho   [5] Modo MSI (Prioridade Alta)
necho   [6] Forcar Escala na GPU
necho   [7] Forcar Resolucao de Timer 0.5ms
necho   [8] Desativar Aceleracao do Mouse
necho   [9] Desativar Teclas de Aderencia e Acesso
necho   [10] Diagnostico de Latencia DPC
echo.
echo   [A] APLICAR TUDO (RECOMENDADO)
necho   [0] Sair
echo.

set /p "choice=Digite sua escolha: "

if /i "%choice%"=="1" goto :buffers_entrada
if /i "%choice%"=="2" goto :resposta_teclado
if /i "%choice%"=="3" goto :desativar_hpet
if /i "%choice%"=="4" goto :economia_usb
if /i "%choice%"=="5" goto :modo_msi
if /i "%choice%"=="6" goto :escala_gpu
if /i "%choice%"=="7" goto :timer_resolution
if /i "%choice%"=="8" goto :aceleracao_mouse
if /i "%choice%"=="9" goto :teclas_aderencia
if /i "%choice%"=="10" goto :diagnostico_dpc
if /i "%choice%"=="A" goto :aplicar_tudo
if /i "%choice%"=="0" exit

echo Opcao invalida.
pause
goto :menu

:buffers_entrada
echo [OTIMIZACAO] Configurando Buffers de Entrada de Baixa Latencia...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 16 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 16 /f
pause
goto :menu

:resposta_teclado
echo [OTIMIZACAO] Maximizando Resposta do Teclado...
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Keyboard" /v AutoRepeatRate /t REG_SZ /d "500" /f
pause
goto :menu

:desativar_hpet
echo [OTIMIZACAO] Desativando HPET (High Precision Event Timer)...
bcdedit /deletevalue useplatformclock
pause
goto :menu

:economia_usb
echo [OTIMIZACAO] Desativando Economia de Energia USB...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\48e6b7a6-50f5-4782-a5d4-53bb8f07e226" /v Attributes /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f
pause
goto :menu

:modo_msi
echo [OTIMIZACAO] Ativando Modo MSI (Prioridade Alta)...
echo [AVISO] Esta otimizacao requer o utilitario MSI (MSI_util_v3.exe).
echo [AVISO] Execute o utilitario e defina a prioridade para GPU e USB como 'High'.
pause
goto :menu

:escala_gpu
echo [OTIMIZACAO] Forcando Escala na GPU...
echo [AVISO] Esta otimizacao deve ser feita no Painel de Controle da NVIDIA.
echo [AVISO] Abra o Painel de Controle da NVIDIA > Ajustar o tamanho e a posicao da area de trabalho > Executar escala em: GPU.
pause
goto :menu

:timer_resolution
echo [OTIMIZACAO] Forcando Resolucao de Timer 0.5ms...
echo [AVISO] Esta otimizacao requer o utilitario ISLC (Intelligent Standby List Cleaner).
echo [AVISO] Baixe e execute o ISLC e configure a resolucao do timer para 0.5ms.
pause
goto :menu

:aceleracao_mouse
echo [OTIMIZACAO] Desativando Aceleracao do Mouse...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f
pause
goto :menu

:teclas_aderencia
echo [OTIMIZACAO] Desativando Teclas de Aderencia e Acesso...
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "122" /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "58" /f
pause
goto :menu

:diagnostico_dpc
echo [OTIMIZACAO] Executando Diagnostico de Latencia DPC...
echo [AVISO] Esta otimizacao requer o utilitario LatencyMon.
echo [AVISO] Baixe e execute o LatencyMon para diagnosticar a latencia DPC.
pause
goto :menu

:aplicar_tudo
call :buffers_entrada
call :resposta_teclado
call :desativar_hpet
call :economia_usb
call :aceleracao_mouse
call :teclas_aderencia
echo.
echo [CONCLUIDO] Todas as otimizacoes de input lag aplicaveis foram executadas.
echo [AVISO] As otimizacoes de Modo MSI, Escala na GPU, Timer Resolution e Diagnostico DPC requerem utilitarios externos.
pause
goto :menu
