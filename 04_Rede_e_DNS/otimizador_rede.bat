@echo off
:: OTIMIZADOR DE REDE E DNS - FPS MACHINE

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
echo                  OTIMIZADOR DE REDE E DNS - FPS MACHINE
necho =====================================================================
echo.
echo   [1] Reset de Fabrica de Rede
necho   [2] Habilitar Receive Side Scaling (RSS)
necho   [3] TCP Auto-Tuning (Baixa Latencia)
necho   [4] Definir MTU para 1400
necho   [5] Desativar IPv6
necho   [6] TCP No Delay & AckFreq
necho   [7] Indice de Estrangulamento de Rede
necho   [8] Desativar TCP Coalescing
necho   [9] Remover Limite de Largura de Banda QoS
necho   [10] Limpar e Renovar DNS
necho   [11] Definir DNS Cloudflare (1.1.1.1)
necho   [12] Definir DNS Google (8.8.8.8)
necho   [13] Definir OpenDNS (208.67.222.222)
necho.
echo   [A] APLICAR TUDO (RECOMENDADO)
necho   [0] Sair
echo.

set /p "choice=Digite sua escolha: "

if /i "%choice%"=="1" goto :reset_rede
if /i "%choice%"=="2" goto :rss
if /i "%choice%"=="3" goto :tcp_autotuning
if /i "%choice%"=="4" goto :mtu
if /i "%choice%"=="5" goto :desativar_ipv6
if /i "%choice%"=="6" goto :tcp_nodelay
if /i "%choice%"=="7" goto :estrangulamento_rede
if /i "%choice%"=="8" goto :tcp_coalescing
if /i "%choice%"=="9" goto :qos
if /i "%choice%"=="10" goto :limpar_dns
if /i "%choice%"=="11" goto :dns_cloudflare
if /i "%choice%"=="12" goto :dns_google
if /i "%choice%"=="13" goto :dns_opendns
if /i "%choice%"=="A" goto :aplicar_tudo
if /i "%choice%"=="0" exit

echo Opcao invalida.
pause
goto :menu

:reset_rede
echo [OTIMIZACAO] Resetando Winsock e Pilha TCP/IP...
netsh int ip reset
netsh winsock reset
pause
goto :menu

:rss
echo [OTIMIZACAO] Habilitando Receive Side Scaling (RSS)...
netsh int tcp set global rss=enabled
pause
goto :menu

:tcp_autotuning
echo [OTIMIZACAO] Configurando TCP Auto-Tuning para Baixa Latencia...
netsh int tcp set global autotuninglevel=highlyrestricted
pause
goto :menu

:mtu
echo [OTIMIZACAO] Definindo MTU para 1400 em todas as interfaces ativas...
for /f "tokens=3,*" %%a in ("netsh interface ipv4 show interfaces ^| findstr /R /C:"connected"") do (
    netsh interface ipv4 set subinterface "%%b" mtu=1400 store=persistent
)
pause
goto :menu

:desativar_ipv6
echo [OTIMIZACAO] Desativando IPv6...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f
pause
goto :menu

:tcp_nodelay
echo [OTIMIZACAO] Desativando Nagle's Algorithm (TCP No Delay)...
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f
FOR /F "tokens=*" %%G IN ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces') DO (
    reg add "%%G" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%G" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
)
pause
goto :menu

:estrangulamento_rede
echo [OTIMIZACAO] Removendo Indice de Estrangulamento de Rede...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
pause
goto :menu

:tcp_coalescing
echo [OTIMIZACAO] Desativando TCP Coalescing (RSC)...
netsh int tcp set global rsc=disabled
pause
goto :menu

:qos
echo [OTIMIZACAO] Removendo Limite de Largura de Banda QoS...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f
pause
goto :menu

:limpar_dns
echo [OTIMIZACAO] Limpando e Renovando DNS...
ipconfig /flushdns
ipconfig /renew
pause
goto :menu

:dns_cloudflare
echo [OTIMIZACAO] Definindo DNS Cloudflare (1.1.1.1)...
for /f "tokens=3,*" %%a in (
    'netsh interface show interface ^| findstr /R /C:"Connected"'
) do (
    netsh interface ipv4 set dns name="%%b" static 1.1.1.1
    netsh interface ipv4 add dns name="%%b" 1.0.0.1 index=2
)
pause
goto :menu

:dns_google
echo [OTIMIZACAO] Definindo DNS Google (8.8.8.8)...
for /f "tokens=3,*" %%a in (
    'netsh interface show interface ^| findstr /R /C:"Connected"'
) do (
    netsh interface ipv4 set dns name="%%b" static 8.8.8.8
    netsh interface ipv4 add dns name="%%b" 8.8.4.4 index=2
)
pause
goto :menu

:dns_opendns
echo [OTIMIZACAO] Definindo OpenDNS (208.67.222.222)...
for /f "tokens=3,*" %%a in (
    'netsh interface show interface ^| findstr /R /C:"Connected"'
) do (
    netsh interface ipv4 set dns name="%%b" static 208.67.222.222
    netsh interface ipv4 add dns name="%%b" 208.67.220.220 index=2
)
pause
goto :menu

:aplicar_tudo
call :reset_rede
call :rss
call :tcp_autotuning
call :mtu
call :desativar_ipv6
call :tcp_nodelay
call :estrangulamento_rede
call :tcp_coalescing
call :qos
call :limpar_dns
call :dns_cloudflare
echo.
echo [CONCLUIDO] Todas as otimizacoes de rede foram aplicadas.
pause
goto :menu
